import 'package:flutter/material.dart';
import 'jadwal_ibadah_page.dart';
import 'jadwal_pelayan_page.dart';

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
        children: const [JadwalIbadahPage(), JadwalPelayanPage()],
      ),
    );
  }
}
