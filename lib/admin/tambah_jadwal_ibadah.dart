import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahJadwalIbadah extends StatefulWidget {
  const TambahJadwalIbadah({Key? key}) : super(key: key);

  @override
  State<TambahJadwalIbadah> createState() => _TambahJadwalIbadahState();
}

class _TambahJadwalIbadahState extends State<TambahJadwalIbadah> {
  final leaderController = TextEditingController();
  final ibadahController = TextEditingController();
  final preacherController = TextEditingController();
  final tempatController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _submitSchedule() {
    String ibadah = ibadahController.text.trim();
    String tempat = tempatController.text.trim();
    String leader = leaderController.text.trim();
    String preacher = preacherController.text.trim();

    DateTime selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    FirebaseFirestore.instance.collection('jadwal_ibadah').add({
      'leader': leader,
      'nama_ibadah': ibadah,
      'preacher': preacher,
      'tanggal': selectedDateTime,
      'tempat': tempat,
    }).then((value) {
      leaderController.clear();
      preacherController.clear();
      ibadahController.clear();
      tempatController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jadwak ibadah berhasil ditambahkan')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Tambah Jadwal Ibadah'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16.0),
            TextField(
              controller: ibadahController,
              decoration: const InputDecoration(labelText: 'Nama Ibadah'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: tempatController,
              decoration: const InputDecoration(labelText: 'Tempat'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: leaderController,
              decoration: const InputDecoration(labelText: 'P. Pujian'),
            ),
            TextField(
              controller: preacherController,
              decoration: const InputDecoration(labelText: 'F. Tuhan'),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                      text:
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                  decoration: const InputDecoration(labelText: 'Tanggal'),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                      text:
                          '${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}'),
                  decoration: const InputDecoration(labelText: 'Jam'),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitSchedule,
              child: const Text('Tambah Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}
