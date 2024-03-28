import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataJemaat extends StatelessWidget {
  const DataJemaat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Data Jemaat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          // Memperoleh daftar jemaat dari snapshot
          final List<DocumentSnapshot> jemaatList = snapshot.data!.docs;

          return DataTable(
            columns: const [
              DataColumn(label: Text('Nama')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Nomor HP')),
              DataColumn(label: Text('Alamat')),
              // DataColumn(label: Text('Jenis Kelamin')),
            ],
            rows: jemaatList.map((jemaat) {
              final Map<String, dynamic> data =
                  jemaat.data() as Map<String, dynamic>;
              return DataRow(cells: [
                DataCell(Text(data['name'] ?? '')),
                DataCell(Text(data['email'] ?? '')),
                DataCell(Text(data['phone number'].toString())),
                DataCell(Text(data['address'])),
                // DataCell(Text(data['gender'])),
              ]);
            }).toList(),
          );
        },
      ),
    );
  }
}
