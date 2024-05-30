import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('assets/images/ibadah.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.dstATop,
                    )),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://maps.app.goo.gl/AAftXiy8imAeZ8BN6'));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D4A86).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset('lib/icons/maps.png',
                                color: Colors.white),
                            const Text(
                              ' Lokasi',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // DIFFERENT SECTION
            Column(
              children: [
                const Text('GPdI Kasih Setia',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Text(
                    'Gg. Bromo, Kec. Percut Sei Tuan, \nKabupaten Deli Serdang, \nSumatera Utara 20371, Indonesia',
                    textAlign: TextAlign.center),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://wa.me/6285158321104'));
                  },
                  child: const Text(
                    '+62 851 5832 1104',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D4A86),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('lib/icons/email.png'),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('lib/icons/facebook.png'),
                    ),
                    IconButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://youtube.com/@christinaprilliamanullang5227?si=07mmD8gAdTXW3Wyn'));
                      },
                      icon: Image.asset('lib/icons/youtube.png'),
                    ),
                    IconButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://www.instagram.com/christin.clj'));
                      },
                      icon: Image.asset('lib/icons/instagram.png'),
                    )
                  ],
                ),
                const Text('GEMBALA SIDANG',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/ibadah.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text('Pdt. Berkat Simatupang S.TH', style: TextStyle()),

                // SECTION IBADAH
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('JAM IBADAH',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        'MINGGU',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('08:00 WIB'),
                          SizedBox(width: 25),
                          Text('Kebaktian Sekolah Minggu'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('11:00 WIB'),
                          SizedBox(width: 32),
                          Text('Kebaktian Umum I'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('20:00 WIB'),
                          SizedBox(width: 25),
                          Text('Kebaktian Umum II'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'SELASA',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('20:00 WIB'),
                          SizedBox(width: 25),
                          Text('Kebaktian KOMSEL'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'RABU',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('20:00 WIB'),
                          SizedBox(width: 25),
                          Text('Menara Doa'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'KAMIS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('20:00 WIB'),
                          SizedBox(width: 25),
                          Text('Kebaktian Kaum Wanita'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'JUMAT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('20:00 WIB'),
                          SizedBox(width: 25),
                          Text('Kebaktian Rumah Tangga'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'SABTU',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('20:00 WIB'),
                          SizedBox(width: 25),
                          Text('Kebaktian Pemuda Remaja'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
