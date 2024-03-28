import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpdi_kaset_app/admin/my_drawer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
    'Sabtu'
  ];

  String selectedMonth = 'Maret';
  String selectedWeek = 'Minggu 4';
  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Padding(
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
            Flexible(
              child: Row(
                children: [
                  Expanded(child: _buildDropdownMonth()),
                  const SizedBox(width: 16),
                  Flexible(child: _buildDropdownWeek()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDropdownDay()),
                ],
              ),
            ),
            TextField(
              controller: renunganController,
              decoration: const InputDecoration(labelText: 'Renungan'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambah data renungan ke Firestore
                FirebaseFirestore.instance.collection('renungan_harian').add({
                  'tanggal': tanggalController.text,
                  'judul': judulController.text,
                  'ayatAlkitab': ayatController.text,
                  'renungan': renunganController.text,
                  'hari': selectedDayIndex,
                  'minggu': selectedWeek,
                  'bulan': selectedMonth,
                }).then((value) {
                  // Reset field setelah berhasil menambah data
                  tanggalController.clear();
                  judulController.clear();
                  ayatController.clear();
                  renunganController.clear();

                  // Tampilkan pesan sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Renungan berhasil ditambahkan')),
                  );
                }).catchError((error) {
                  // Tampilkan pesan kesalahan jika terjadi error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 25),
                backgroundColor: const Color(0xFF1D4A86),
              ),
              child: const Text(
                'Tambah Renungan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk dropdown bulan
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

// Widget untuk dropdown minggu
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
          // labelText: "Menu mode",
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
