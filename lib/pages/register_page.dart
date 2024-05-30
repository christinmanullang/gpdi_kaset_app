import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/auth_service.dart';
import '../components/my_button.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _pwController = TextEditingController();
  final _confirmPwController = TextEditingController();
  final _dateController = TextEditingController();
  String? _gender;

  // FUNGSI TANGGAL LAHIR
  void _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  void register(BuildContext context) {
    final auth = AuthService();
    if (_pwController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(
          _emailController.text,
          _confirmPwController.text,
        );
        addUserData(
          _emailController.text.trim(),
          _nameController.text.trim(),
          _addressController.text.trim(),
          int.parse(_phoneNumberController.text.trim()),
          _dateController.text.trim(),
          _gender!,
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

  Future addUserData(String email, String nama, String alamat, int noHP,
      String tanggal, String gender) async {
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'Email': email,
      'Nama': nama,
      'Alamat': alamat,
      'No HP': noHP,
      'Tanggal Lahir': tanggal,
      'Jenis Kelamin': gender,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Buat Akun"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // FIELDS
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                ),
                obscureText: false,
                controller: _nameController,
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
                obscureText: false,
                controller: _addressController,
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'No Handphone',
                ),
                obscureText: false,
                controller: _phoneNumberController,
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                ),
                obscureText: false,
                controller: _dateController,
                onTap: _selectDate,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('Pilih jenis kelamin'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Pria',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const Text('Pria'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Wanita',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const Text('Wanita'),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi password',
                ),
                obscureText: true,
                controller: _confirmPwController,
              ),
              const SizedBox(height: 5),

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
                    'Sudah punya akun? ',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login disini',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D4A86),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8)
            ],
          ),
        ),
      ),
    );
  }
}
