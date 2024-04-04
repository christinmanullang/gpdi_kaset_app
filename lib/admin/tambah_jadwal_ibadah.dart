import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahJadwalIbadah extends StatefulWidget {
  const TambahJadwalIbadah({Key? key}) : super(key: key);

  @override
  State<TambahJadwalIbadah> createState() => _TambahJadwalIbadahState();
}

class _TambahJadwalIbadahState extends State<TambahJadwalIbadah> {
  final TextEditingController leaderController = TextEditingController();
  final TextEditingController ibadahController = TextEditingController();
  final TextEditingController preacherController = TextEditingController();
  final TextEditingController tempatController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  void _submitSchedule() {
    String leader = leaderController.text.trim();
    String ibadah = ibadahController.text.trim();
    String preacher = preacherController.text.trim();
    String tempat = tempatController.text.trim();

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
      // Success, do something
      // For example, show a success dialog or navigate to another page
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Jadwal ibadah berhasil ditambahkan!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Optionally navigate to another page
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Jadwal Ibadah'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16.0),
            TextField(
              controller: ibadahController,
              decoration: InputDecoration(labelText: 'Nama Ibadah'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: tempatController,
              decoration: InputDecoration(labelText: 'Tempat'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: leaderController,
              decoration: InputDecoration(labelText: 'P. Pujian'),
            ),
            TextField(
              controller: preacherController,
              decoration: InputDecoration(labelText: 'F. Tuhan'),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                      text:
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                  decoration: InputDecoration(labelText: 'Tanggal'),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                      text:
                          '${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}'),
                  decoration: InputDecoration(labelText: 'Jam'),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitSchedule,
              child: Text('Tambah Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}
