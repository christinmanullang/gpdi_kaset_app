import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profil Gereja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/ibadah.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text('Tentang Kami',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('GPdI Kasih Setia',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla hendrerit erat sed urna dapibus, at finibus risus fringilla. Aliquam scelerisque sem purus, in placerat arcu vehicula at. Donec risus felis, auctor eget nulla at, suscipit porttitor risus. Pellentesque volutpat, nibh eget porttitor malesuada, felis velit viverra urna, sed placerat nisi est vel ligula. Nunc non sem vel arcu luctus lacinia. Pellentesque fringilla ultrices metus, quis commodo libero sollicitudin viverra.'),
              SizedBox(height: 10),
              Text('Kontak dan Lokasi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                  'HQX5+QHG, Gg. Bromo, Hutan, Kec. Percut Sei Tuan, Kabupaten Deli Serdang, Sumatera Utara 20371'),
              Text('0851 5832 1104'),
              Text('caprilliam11@gmail.com'),
              SizedBox(height: 10),
              Text('Jam Buka',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Selasa - Minggu'),
              Text('08.00 - 17.00 WIB'),
            ],
          ),
        ),
      ),
    );
  }
}
