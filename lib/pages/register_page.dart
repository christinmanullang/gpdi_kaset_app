import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _pwController = TextEditingController();
  final _confirmPwController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    addUserData(
      _emailController.text.trim(),
      _nameController.text.trim(),
      _addressController.text.trim(),
      int.parse(_phoneNumberController.text.trim()),
    );
    final auth = AuthService();
    if (_pwController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(
          _emailController.text,
          _confirmPwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Password don\'t match'),
        ),
      );
    }
  }

  Future addUserData(
      String email, String name, String address, int phoneNumber) async {
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'email': email,
      'name': name,
      'address': address,
      'phone number': phoneNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Akun"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            // FIELDS
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 5),
            MyTextField(
              hintText: 'Nama Lengkap',
              obscureText: false,
              controller: _nameController,
            ),
            const SizedBox(height: 5),
            MyTextField(
                hintText: 'Alamat',
                obscureText: false,
                controller: _addressController),
            const SizedBox(height: 5),
            MyTextField(
                hintText: 'No Handphone',
                obscureText: false,
                controller: _phoneNumberController),
            const SizedBox(height: 5),
            MyTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
              hintText: 'Confirm password',
              obscureText: true,
              controller: _confirmPwController,
            ),
            const SizedBox(height: 25),

            // BUTTON
            MyButton(
              onTap: () => register(context),
              text: 'Sign Up',
            ),
            const SizedBox(height: 25),

            // ASKING TO LOGIN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Login Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D4A86),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
