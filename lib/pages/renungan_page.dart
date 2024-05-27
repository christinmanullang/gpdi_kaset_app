import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/my_sliver_app_bar.dart';

class RenunganPage extends StatefulWidget {
  const RenunganPage({Key? key}) : super(key: key);

  @override
  State<RenunganPage> createState() => _RenunganPageState();
}

class _RenunganPageState extends State<RenunganPage>
    with SingleTickerProviderStateMixin {
  late String selectedMonth;
  late String selectedWeek;
  late int selectedDayIndex;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _setSelectedDate();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _setSelectedDate() {
    DateTime now = DateTime.now();
    selectedMonth = DateFormat('MMMM', 'id').format(now);
    selectedWeek = 'Minggu ${((now.day - 1) ~/ 7) + 1}';
    selectedDayIndex = now.weekday - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(text: 'Senin'),
                Tab(text: 'Selasa'),
                Tab(text: 'Rabu'),
                Tab(text: 'Kamis'),
                Tab(text: 'Jumat'),
                Tab(text: 'Sabtu'),
                Tab(text: 'Minggu'),
              ],
              onTap: (index) {
                setState(() {
                  selectedDayIndex = index;
                });
              },
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 48.0, left: 24, right: 24),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: _buildDropdownMonth()),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDropdownWeek()),
                  ],
                ),
              ),
            ),
          )
        ],
        body: _buildRenunganList(),
      ),
    );
  }

  /*
  C O M P O N E N T S
  */

  // DROPDOWN MONTH
  Widget _buildDropdownMonth() {
    final List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return DropdownSearch<String>(
      selectedItem: selectedMonth,
      items: months,
      onChanged: (String? newValue) {
        setState(() {
          selectedMonth = newValue!;
        });
      },
    );
  }

  // DROPDOWN WEEK
  Widget _buildDropdownWeek() {
    final List<String> weeks = [
      'Minggu 1',
      'Minggu 2',
      'Minggu 3',
      'Minggu 4',
      'Minggu 5'
    ];
    return DropdownSearch<String>(
      selectedItem: selectedWeek,
      items: weeks,
      onChanged: (String? newValue) {
        setState(() {
          selectedWeek = newValue!;
        });
      },
    );
  }

  // RENUNGAN LIST
  Widget _buildRenunganList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('renungan_harian')
          .where('bulan', isEqualTo: selectedMonth)
          .where('minggu', isEqualTo: selectedWeek)
          .where('hari', isEqualTo: selectedDayIndex)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Data tidak tersedia!'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var renungan =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    renungan['tanggal'],
                    style:
                        GoogleFonts.merriweather(fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Text(
                      '\n  ${renungan['judul']}',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      renungan['ayatAlkitab'],
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    renungan['renungan'].replaceAll('\\n', '\n'),
                    style: GoogleFonts.merriweather(),
                  ),
                  const SizedBox(height: 25)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
