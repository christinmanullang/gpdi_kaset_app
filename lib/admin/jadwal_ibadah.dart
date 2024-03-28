import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JadwalIbadah extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  JadwalIbadah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Ibadah'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('ibadah').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    // Handle onTap event
                  },
                  child: Card(
                    color: Colors.blueGrey[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Hari: '),
                        Text('Ibadah: '),
                        Text('Jam: '),
                        Text('Alamat: '),
                        Text('Petugas: '),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
