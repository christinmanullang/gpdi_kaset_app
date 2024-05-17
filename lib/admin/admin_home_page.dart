import 'package:flutter/material.dart';
import 'package:gpdi_kaset_app/admin/data_jemaat.dart';
import 'package:gpdi_kaset_app/admin/tambah_jadwal_ibadah.dart';

import '../pages/home_page.dart';
import 'my_drawer.dart';
import 'tambah_renungan.dart';

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
    title: 'Data Jemaat',
    icon: const Icon(Icons.people),
    content: const DataJemaat(),
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
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Halaman Admin'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: features.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToFeatureDetails(context, features[index]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
    );
  }
}
