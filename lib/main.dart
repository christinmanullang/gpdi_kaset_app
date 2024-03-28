import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin/jadwal_ibadah.dart';
import 'auth/auth_gate.dart';
import 'firebase_options.dart';
import 'admin/admin_home_page.dart';
import 'admin/data_jemaat.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/data_jemaat': (context) => const DataJemaat(),
        '/adminhomepage': (context) => const AdminHomePage(),
        '/homepage': (context) => const HomePage(),
        '/jadwal_ibadah': (context) => JadwalIbadah(),
      },
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}
