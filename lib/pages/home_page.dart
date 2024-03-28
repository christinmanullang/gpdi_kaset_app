import 'package:firebase_auth/firebase_auth.dart';
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
    imagePath: "assets/images/gallery.png",
    content: const Scaffold(),
  ),
  Feature(
    title: 'Tentang Kami',
    description: 'Tentang aplikasi',
    imagePath: "assets/images/church.png",
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
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('GPdI Kasih Setia'),
            centerTitle: true,
            leading: Image.asset(
              'assets/images/gpdi-logo.png',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Selamat datang di \nAplikasi GPdI Kasih Setia',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
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
                        color: Color(0xFFB0BEC5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.asset(
                                features[index].imagePath,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Text(
                              features[index].title,
                              style: GoogleFonts.nunito(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
