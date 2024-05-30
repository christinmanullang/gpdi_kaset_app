import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JadwalPelayanPage extends StatefulWidget {
  const JadwalPelayanPage({Key? key}) : super(key: key);

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
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('Belum ada jadwal pelayan minggu ini'));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Text(
                  'PELAYAN YANG BERTUGAS MELAYANI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (var doc in snapshot.data!.docs)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        _buildTableRow('Worship Leader', doc['worship_leader']),
                        _buildTableRow('Singers',
                            (doc['singers'] as List<dynamic>).join(', ')),
                        _buildTableRow('Doa Pembuka', doc['doa_pembuka']),
                        _buildTableRow('Penerima Tamu',
                            (doc['penerima_tamu'] as List<dynamic>).join(', ')),
                        _buildTableRow('Pemusik',
                            'Drum: ${doc['pemusik']['drum']}, Bass: ${doc['pemusik']['bass']}, Keyboard: ${doc['pemusik']['keyboard']}'),
                        _buildTableRow('Multimedia', doc['multimedia']),
                        _buildTableRow('Kolektan',
                            (doc['kolektan'] as List<dynamic>).join(', ')),
                        _buildTableRow('Tamborin',
                            (doc['tamborin'] as List<dynamic>).join(', ')),
                        _buildTableRow('Firman', doc['firman']),
                        _buildTableRow('Pelayan Perjamuan Kudus',
                            (doc['perjamuan'] as List<dynamic>).join(', ')),
                      ],
                    ),
                  ),
                const Text(
                  'Setiap yang melayani hadir 30 menit \nsebelum ibadah dimulai.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
