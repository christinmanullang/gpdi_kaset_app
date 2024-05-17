import 'package:flutter/material.dart';
import 'package:gpdi_kaset_app/pages/home_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                // color: Colors.blue,
                ),
            child: Text(
              'Menu',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Tambah Renungan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/adminhomepage');
            },
          ),
          ListTile(
            title: const Text('Tambah Jadwal Ibadah'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/jadwal_ibadah');
            },
          ),
          ListTile(
            title: const Text('Jemaat Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/data_jemaat');
            },
          ),
          ListTile(
            title: const Text('Keluar'),
            leading: const Icon(Icons.logout),
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/homepage');
              // SystemNavigator.pop();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
