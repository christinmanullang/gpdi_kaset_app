import 'package:flutter/material.dart';
import 'package:gpdi_kaset_app/admin/data_jemaat.dart';
import 'package:gpdi_kaset_app/admin/tambah_jadwal_ibadah.dart';
import 'package:gpdi_kaset_app/admin/tambah_jadwal_pelayan.dart';
import 'package:gpdi_kaset_app/admin/tambah_renungan.dart';
import '../pages/home_page.dart';

class Feature {
  final String title;
  final Icon icon;
  final Widget content;

  Feature({
    required this.title,
    required this.icon,
    required this.content,
  });
}

List<Feature> features = [
  Feature(
    title: 'Tambah Renungan',
    icon: const Icon(Icons.book),
    content: const TambahRenungan(),
  ),
  Feature(
    title: 'Tambah Jadwal Ibadah',
    icon: const Icon(Icons.edit_calendar),
    content: const TambahJadwalIbadah(),
  ),
  Feature(
    title: 'Tambah Jadwal Pelayan',
    icon: const Icon(Icons.edit_calendar),
    content: const TambahJadwalPelayan(),
  ),
  Feature(
    title: 'Data Jemaat',
    icon: const Icon(Icons.people),
    content: const DataJemaat(),
  ),
  Feature(
    title: 'Kembali ke Beranda',
    icon: const Icon(Icons.people),
    content: const HomePage(),
  ),
];

// NAVIGATE TO SELECTED PAGE
void navigateToFeatureDetails(BuildContext context, Feature feature) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => feature.content,
    ),
  );
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Halaman Admin'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: features.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      navigateToFeatureDetails(context, features[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: const Color(0xFFB0BEC5),
                      child: ListTile(
                        leading: features[index].icon,
                        title: Text(
                          features[index].title,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
