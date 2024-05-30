import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<Map<String, String>> galleryItems = [
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

  GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: galleryItems.length,
        itemBuilder: (context, index) {
          return GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(galleryItems[index]['title']!,
                  textAlign: TextAlign.center),
            ),
            child:
                Image.asset(galleryItems[index]['image']!, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
