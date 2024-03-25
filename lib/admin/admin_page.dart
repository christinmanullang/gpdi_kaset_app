import 'package:flutter/material.dart';

import 'admin_home_page.dart';

// 2. Verifikasi  Admin
class AdminForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AdminForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin '),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Verifikasi  admin
                String email = emailController.text;
                String password = passwordController.text;
                if (email == 'admin@gmail.com' && password == 'admin123') {
                  // Jika  berhasil, navigasi ke halaman admin
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminHomePage()),
                  );
                } else {
                  // Jika  gagal, tampilkan pesan kesalahan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid email or password')),
                  );
                }
              },
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
