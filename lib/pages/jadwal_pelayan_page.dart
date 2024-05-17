import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JadwalPelayanPage extends StatefulWidget {
  const JadwalPelayanPage({super.key});

  @override
  State<JadwalPelayanPage> createState() => _JadwalPelayanPageState();
}

class _JadwalPelayanPageState extends State<JadwalPelayanPage> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _calculateWeekRange();
  }

  void _calculateWeekRange() {
    DateTime now = DateTime.now();
    int weekday = now.weekday;
    _startDate = now.subtract(Duration(days: weekday - 1));
    _endDate = now.add(Duration(days: 7 - weekday));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pelayan')
            .where('tanggal', isGreaterThanOrEqualTo: _startDate)
            .where('tanggal', isLessThanOrEqualTo: _endDate)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('Tidak ada jadwal pelayan minggu ini'));
          }
          if (!snapshot.hasData) return const CircularProgressIndicator();

          List<Map<String, dynamic>> serviceData =
              snapshot.data!.docs.map((doc) {
            return {
              'Pelayanan': doc['Doa'],
              'Worship Leader': doc['Worship Leader'],
              'Singers': (doc['Singers'] as List<dynamic>).join(', '),
            };
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                for (var service in serviceData)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                      },
                      children: [
                        _buildTableRow('Pelayanan', service['Pelayanan']),
                        _buildTableRow(
                            'Worship Leader', service['Worship Leader']),
                        _buildTableRow('Singers', service['Singers']),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method untuk membuat baris tabel
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
