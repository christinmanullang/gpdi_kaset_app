import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahRenungan extends StatefulWidget {
  const TambahRenungan({super.key});

  @override
  State<TambahRenungan> createState() => _TambahRenunganState();
}

class _TambahRenunganState extends State<TambahRenungan> {
  final tanggalController = TextEditingController();
  final judulController = TextEditingController();
  final ayatController = TextEditingController();
  final renunganController = TextEditingController();

  final List<String> weeks = [
    'Minggu 1',
    'Minggu 2',
    'Minggu 3',
    'Minggu 4',
    'Minggu 5'
  ];

  final List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  final List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  late String selectedMonth;
  late String selectedWeek;
  late int selectedDayIndex;

  void _submitRenungan() {
    FirebaseFirestore.instance.collection('renungan_harian').add({
      'tanggal': tanggalController.text,
      'judul': judulController.text,
      'ayatAlkitab': ayatController.text,
      'renungan': renunganController.text,
      'hari': selectedDayIndex,
      'minggu': selectedWeek,
      'bulan': selectedMonth,
    }).then((value) {
      tanggalController.clear();
      judulController.clear();
      ayatController.clear();
      renunganController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Renungan berhasil ditambahkan')),
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
        backgroundColor: Colors.transparent,
        title: const Text('Tambah Renungan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Renungan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: tanggalController,
                decoration: const InputDecoration(labelText: 'Tanggal'),
              ),
              TextField(
                controller: judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: ayatController,
                decoration: const InputDecoration(labelText: 'Ayat Alkitab'),
              ),
              Row(
                children: [
                  Expanded(child: _buildDropdownMonth()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDropdownWeek()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDropdownDay()),
                ],
              ),
              TextField(
                controller: renunganController,
                decoration: const InputDecoration(labelText: 'Renungan'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitRenungan,
                child: const Text('Tambah Renungan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownMonth() {
    return DropdownSearch<String>(
      items: months,
      onChanged: (String? newValue) {
        setState(() {
          selectedMonth = newValue!;
        });
      },
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "Pilih Bulan...",
        ),
      ),
    );
  }

  Widget _buildDropdownWeek() {
    return DropdownSearch<String>(
      items: weeks,
      onChanged: (String? newValue) {
        setState(() {
          selectedWeek = newValue!;
        });
      },
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "Pilih Minggu...",
        ),
      ),
    );
  }

  Widget _buildDropdownDay() {
    return DropdownSearch<String>(
      items: days,
      onChanged: (String? selectedDay) {
        if (selectedDay != null) {
          setState(() {
            selectedDayIndex = days.indexOf(selectedDay);
          });
        }
      },
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "Pilih Hari...",
        ),
      ),
    );
  }
}
