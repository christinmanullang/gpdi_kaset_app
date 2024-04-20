import 'package:flutter/material.dart';
import 'dart:html' as html;

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
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                image: const DecorationImage(
                  image: AssetImage('assets/images/ibadah.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    html.window.open(
                        'https://maps.app.goo.gl/VRBqUu3egU3nNcRM8', 'maps');
                  },
                  child: const Column(children: [
                    Icon(Icons.location_on),
                    Text('GPdI Kasih Setia')
                  ]),
                ),
                InkWell(
                  onTap: () {
                    html.window.open('https://wa.me/6285158321104', 'google');
                  },
                  child: const Column(children: [
                    Icon(Icons.chat),
                    Text('+62 851-5832-1104'),
                  ]),
                ),
                InkWell(
                  onTap: () {},
                  child: const Column(children: [
                    Icon(Icons.mail),
                    Text('caprilliam11@gmail.com')
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
