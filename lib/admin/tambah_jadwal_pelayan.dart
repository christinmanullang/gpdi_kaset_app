import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahJadwalPelayan extends StatefulWidget {
  const TambahJadwalPelayan({super.key});

  @override
  State<TambahJadwalPelayan> createState() => _TambahJadwalPelayanState();
}

class _TambahJadwalPelayanState extends State<TambahJadwalPelayan> {
  final _worshipLeaderController = TextEditingController();
  final _singersController = TextEditingController();
  final _doaController = TextEditingController();
  final _penerimaTamuController = TextEditingController();
  final Map<String, TextEditingController> _pemusikControllers = {
    'drum': TextEditingController(),
    'bass': TextEditingController(),
    'keyboard': TextEditingController(),
  };
  final _multimediaController = TextEditingController();
  final _kolektanController = TextEditingController();
  final _tamborinController = TextEditingController();
  final _firmanController = TextEditingController();
  final _perjamuanController = TextEditingController();

  DateTime selectedDate = DateTime.now();

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

  Future<void> _submitForm() async {
    DateTime selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    try {
      await FirebaseFirestore.instance.collection('pelayan').add({
        'tanggal': selectedDateTime,
        'worship_leader': _worshipLeaderController.text,
        'singers': _singersController.text.split(','),
        'doa_pembuka': _doaController.text,
        'penerima_tamu': _penerimaTamuController.text.split(','),
        'pemusik': {
          'drum': _pemusikControllers['drum']!.text,
          'bass': _pemusikControllers['bass']!.text,
          'keyboard': _pemusikControllers['keyboard']!.text,
        },
        'multimedia': _multimediaController.text,
        'kolektan': _kolektanController.text.split(','),
        'tamborin': _tamborinController.text.split(','),
        'firman': _firmanController.text,
        'perjamuan': _perjamuanController.text.split(','),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jadwal pelayan berhasil ditambahkan')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Jadwal Pelayan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
              _buildTextField(_worshipLeaderController, 'Worship Leader'),
              _buildTextField(
                  _singersController, 'Singers (pisahkan dengan koma)'),
              _buildTextField(_doaController, 'Doa Pembuka'),
              _buildTextField(_penerimaTamuController,
                  'Penerima Tamu (pisahkan dengan koma)'),
              _buildTextField(_pemusikControllers['drum']!, 'Pemusik - Drum'),
              _buildTextField(_pemusikControllers['bass']!, 'Pemusik - Bass'),
              _buildTextField(
                  _pemusikControllers['keyboard']!, 'Pemusik - Keyboard'),
              _buildTextField(_multimediaController, 'Multimedia'),
              _buildTextField(
                  _kolektanController, 'Kolektan (pisahkan dengan koma)'),
              _buildTextField(
                  _tamborinController, 'Tamborin (pisahkan dengan koma)'),
              _buildTextField(_firmanController, 'Firman'),
              _buildTextField(_perjamuanController,
                  'Pelayan Perjamuan (pisahkan dengan koma)'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
