import 'package:flutter/material.dart';
// import 'package:gpdi_kaset_app/admin/data_jemaat.dart';
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
    icon: Icon(Icons.book),
    content: TambahRenungan(),
  ),
  Feature(
    title: 'Tambah Jadwal Ibadah',
    icon: Icon(Icons.edit_calendar),
    content: TambahJadwalIbadah(),
  ),
  Feature(
    title: 'Tambah Jadwal Pelayan',
    icon: Icon(Icons.edit_calendar),
    content: TambahJadwalPelayan(),
  ),
  // Feature(
  //   title: 'Data Jemaat',
  //   icon: Icon(Icons.people),
  //   content: DataJemaat(),
  // ),
  Feature(
    title: 'Kembali ke Beranda',
    icon: Icon(Icons.people),
    content: HomePage(),
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
  AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Halaman Admin'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
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
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                      color: Color(0xFFB0BEC5),
                      child: ListTile(
                        leading: features[index].icon,
                        title: Text(
                          features[index].title,
                          style: TextStyle(fontSize: 16),
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
