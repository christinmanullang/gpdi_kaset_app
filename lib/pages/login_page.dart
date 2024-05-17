import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon and greetings
              Image.asset(
                'assets/images/gpdi-logo.png',
                width: 120,
              ),
              const SizedBox(height: 16),
              Text(
                'Selamat datang di \nGPdI Kasih Setia Tembung!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),

              // Email field
              MyTextField(
                prefixIcon: const Icon(Icons.email),
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 10),

              // Password field
              MyTextField(
                prefixIcon: const Icon(Icons.lock),
                obscureText: _obscureText,
                hintText: 'Password',
                controller: _pwController,
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),

              const SizedBox(height: 16),

              // BUTTON
              MyButton(
                onTap: () => login(context),
                text: 'Login',
              ),
              const SizedBox(height: 16),

              // ASKING TO REGISTER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Registrasi disini',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D4A86),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
