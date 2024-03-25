import 'package:flutter/material.dart';
import '../models/renungan.dart';

class RenunganPage extends StatefulWidget {
  final Renungan renungan;
  const RenunganPage({super.key, required this.renungan});

  @override
  State<RenunganPage> createState() => _RenunganPageState();
}

class _RenunganPageState extends State<RenunganPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('renunganMenu.name'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Image.asset(
                  widget.renungan.imagePath,
                  height: 200,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(widget.renungan.rating)
                  ],
                ),
                Text(
                  widget.renungan.name,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 25),
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Lorem ')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
