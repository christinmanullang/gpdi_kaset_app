import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/bottom_navigation_wrapper.dart';
import 'login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BottomNavigationWrapper();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
