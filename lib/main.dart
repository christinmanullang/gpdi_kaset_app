import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'auth/auth_gate.dart';
import 'firebase_options.dart';
import 'admin/tambah_jadwal_ibadah.dart';
import 'admin/admin_home_page.dart';
import 'admin/data_jemaat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('id', null);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: GoogleFonts.mavenProTextTheme(
          Theme.of(context).textTheme,
        )),
        routes: {
          '/data_jemaat': (context) => DataJemaat(),
          '/adminhomepage': (context) => const AdminHomePage(),
          '/jadwal_ibadah': (context) => const TambahJadwalIbadah(),
        },
        debugShowCheckedModeBanner: false,
        home: const AuthGate());
  }
}
