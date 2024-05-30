import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class JadwalIbadahPage extends StatefulWidget {
  const JadwalIbadahPage({Key? key}) : super(key: key);

  @override
  State<JadwalIbadahPage> createState() => _JadwalIbadahPageState();
}

class _JadwalIbadahPageState extends State<JadwalIbadahPage> {
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
            .collection('jadwal_ibadah')
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
                child: Text('Tidak ada jadwal ibadah minggu ini'));
          }

          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot schedule = snapshot.data!.docs[index];
                String namaIbadah = schedule['nama_ibadah'];
                String hari = DateFormat('EEEE', 'id')
                    .format(schedule['tanggal'].toDate());
                String tanggal = DateFormat('dd MMMM yyyy', 'id')
                    .format(schedule['tanggal'].toDate());
                String jam =
                    DateFormat.Hm().format(schedule['tanggal'].toDate());
                String tempat = schedule['tempat'];
                String leader = schedule['leader'];
                String preacher = schedule['preacher'];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Hari $hari'),
                        Text(tanggal),
                        const Divider(),
                        Text('Ibadah $namaIbadah'.toUpperCase()),
                        Text('Jam $jam WIB - selesai'),
                        const SizedBox(height: 8),
                        Text(
                          'Di ${tempat.replaceAll('\\n', '\n')}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('P. Pujian: $leader'),
                                Text('F. Tuhan: $preacher'),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
