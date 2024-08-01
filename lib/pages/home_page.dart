import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpdi_kaset_app/pages/keuangan_page.dart';

import '../components/my_button.dart';
import 'kontak_page.dart';
import 'warta_page.dart';
import 'renungan_page.dart';
import 'galeri_page.dart';

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

List<Feature> features = [
  Feature(
    title: 'Renungan',
    description: ' ',
    imagePath: "assets/images/bible.png",
    content: RenunganPage(),
  ),
  Feature(
    title: 'Warta Jemaat',
    description:
        'Lihat jadwal ibadah sepekan, dan pelayan yang bertugas melayani',
    imagePath: "assets/images/schedule.png",
    content: WartaJemaatPage(),
  ),
  Feature(
    title: 'Profil Gereja',
    description: ' ',
    imagePath: "assets/images/church.png",
    content: AboutPage(),
  ),
  Feature(
    title: 'Keuangan Gereja',
    description: ' ',
    imagePath: "assets/images/gallery.png",
    content: KeuanganPage(),
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
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('GPdI Kasih Setia'),
          centerTitle: true,
          leading: Image.asset(
            'assets/images/gpdi-logo.png',
          ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/banner.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.dstATop,
                  )),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/banner.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat datang di \nAplikasi GPdI Kasih Setia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      MyButton(
                        text: 'Galeri',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GaleriPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 120 / 135,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      navigateToFeatureDetails(context, features[index]),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            features[index].description,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}
