import 'package:flutter/material.dart';

class GaleriPage extends StatelessWidget {
  final List<Map<String, String>> galeriItems = [
    {'title': 'Foto Gereja', 'image': 'assets/images/gedung-gereja.jpg'},
    {
      'title': 'Keluarga Gembala',
      'image': 'assets/images/keluarga-gembala.jpg'
    },
    {'title': 'Pelayanan Wanita', 'image': 'assets/images/pelwap.jpg'},
    {'title': 'Pemuda-Remaja', 'image': 'assets/images/pelprap.jpg'},
    {'title': 'Sekolah Minggu', 'image': 'assets/images/sekolah-minggu.jpg'},
    {'title': 'Komsel', 'image': 'assets/images/komsel.jpg'},
  ];

  GaleriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Galeri'),
        backgroundColor: Colors.transparent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: galeriItems.length,
        itemBuilder: (context, index) {
          return GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(galeriItems[index]['title']!,
                  textAlign: TextAlign.center),
            ),
            child: Image.asset(galeriItems[index]['image']!, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
