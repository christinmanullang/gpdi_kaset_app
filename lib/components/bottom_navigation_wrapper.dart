import 'package:flutter/material.dart';
import 'package:gpdi_kaset_app/admin/admin_login_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class BottomNavigationWrapper extends StatefulWidget {
  const BottomNavigationWrapper({super.key});

  @override
  State<BottomNavigationWrapper> createState() =>
      _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    AdminLoginPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'lib/icons/church.png',
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'lib/icons/admin.png',
              ),
              label: 'Admin'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'lib/icons/profile.png',
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
