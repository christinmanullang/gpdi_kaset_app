import 'package:flutter/material.dart';
import 'package:gpdi_kaset_app/components/my_button.dart';
import '../components/my_textfield.dart';

class AdminLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/admin.png', scale: 5),
            // const Icon(Icons.sensor_occupied, size: 120),
            const SizedBox(height: 16),
            Text(
              'MASUK SEBAGAI ADMIN',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: emailController,
              labelText: 'Email',
              hintText: 'Masukkan email',
              obscureText: false,
            ),
            const SizedBox(height: 15),
            MyTextField(
              controller: passwordController,
              labelText: 'Password',
              hintText: 'Masukkan password',
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            MyButton(
              text: 'Login Admin',
              onTap: () {
                String email = emailController.text;
                String password = passwordController.text;
                if (email == 'admin@gmail.com' && password == 'admin123') {
                  Navigator.pushNamed(context, '/adminhomepage');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid email or password')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
