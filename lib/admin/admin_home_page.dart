import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomePage extends StatelessWidget {
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController ayatController = TextEditingController();
  final TextEditingController renunganController = TextEditingController();
  final TextEditingController hariController = TextEditingController();
  final TextEditingController mingguController = TextEditingController();
  final TextEditingController bulanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Admin Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tambah Renungan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: tanggalController,
              decoration: InputDecoration(labelText: 'Tanggal'),
            ),
            TextField(
              controller: judulController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: ayatController,
              decoration: InputDecoration(labelText: 'Ayat Alkitab'),
            ),
            TextField(
              controller: hariController,
              decoration: InputDecoration(labelText: 'hari'),
            ),
            TextField(
              controller: mingguController,
              decoration: InputDecoration(labelText: 'minggu'),
            ),
            TextField(
              controller: bulanController,
              decoration: InputDecoration(labelText: 'bulan'),
            ),
            TextField(
              controller: renunganController,
              decoration: InputDecoration(labelText: 'Renungan'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambah data renungan ke Firestore
                FirebaseFirestore.instance.collection('renungan_harian').add({
                  'tanggal': tanggalController.text,
                  'judul': judulController.text,
                  'ayatAlkitab': ayatController.text,
                  'renungan': renunganController.text,
                  'hari': hariController.text,
                  'minggu': mingguController.text,
                  'bulan': bulanController.text,
                }).then((value) {
                  // Reset field setelah berhasil menambah data
                  tanggalController.clear();
                  judulController.clear();
                  ayatController.clear();
                  renunganController.clear();

                  // Tampilkan pesan sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Renungan berhasil ditambahkan')),
                  );
                }).catchError((error) {
                  // Tampilkan pesan kesalahan jika terjadi error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                });
              },
              child: Text('Tambah Renungan'),
            ),
          ],
        ),
      ),
    );
  }
}
