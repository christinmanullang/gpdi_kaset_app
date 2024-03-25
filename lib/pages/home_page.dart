import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'renungan_page.dart';

// Buat model data untuk mewakili setiap fitur
class Feature {
  final String title;
  final String description;
  final String imagePath;
  final Widget content;

  Feature({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.content,
  });
}

// Buat daftar dari model data fitur
List<Feature> features = [
  Feature(
    title: 'Renungan',
    description: 'Baca renungan harian',
    imagePath: "assets/images/bible.png",
    content: const RenunganPage(),
  ),
  Feature(
    title: 'Jadwal Ibadah',
    description: 'Lihat jadwal ibadah',
    imagePath: "assets/images/schedule.png",
    content: const Scaffold(),
  ),
  Feature(
    title: 'Galeri',
    description: 'Lihat galeri foto',
    imagePath: "assets/images/newspaper.png",
    content: const Scaffold(),
  ),
  Feature(
    title: 'About',
    description: 'Tentang aplikasi',
    imagePath: "assets/images/bible.png",
    content: const Scaffold(),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GPdI Kasih Setia'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Selamat datang di \nAplikasi GPdI Kasih Setia',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 18),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        navigateToFeatureDetails(context, features[index]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(features[index].imagePath, height: 80),
                            Text(
                              features[index].title,
                              style: const TextStyle(fontSize: 20),
                            ),
                            // Text(features[index].description)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
