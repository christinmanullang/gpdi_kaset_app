import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpdi_kaset_app/pages/jadwal_ibadah_page.dart';

class WartaJemaatPage extends StatefulWidget {
  const WartaJemaatPage({super.key});

  @override
  State<WartaJemaatPage> createState() => _WartaJemaatPageState();
}

class _WartaJemaatPageState extends State<WartaJemaatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Warta Jemaat'),
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Jadwal Ibadah'),
            Tab(text: 'Pelayan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [JadwalIbadahPage(), ServiceTable()],
      ),
    );
  }
}

class ServiceTable extends StatefulWidget {
  const ServiceTable({super.key});

  @override
  _ServiceTableState createState() => _ServiceTableState();
}

class _ServiceTableState extends State<ServiceTable> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pelayan').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        // Dapatkan data dari snapshot
        List<Map<String, dynamic>> serviceData = snapshot.data!.docs.map((doc) {
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
