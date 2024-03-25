import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon and greetings
            const Icon(
              Icons.home_outlined,
              size: 60,
              // color: ,
            ),
            const SizedBox(height: 25),
            Text(
              'Selamat datang di GPdI Kasih Setia Tembung!',
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),

            // Email field
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),

            // Password field
            MyTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(height: 25),

            // BUTTON
            MyButton(
              onTap: () => login(context),
              text: 'Login',
            ),
            const SizedBox(height: 25),

            // ASKING TO REGISTER
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member? ',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Register Now',
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
    );
  }
}
