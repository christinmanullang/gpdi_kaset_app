import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_textbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // USER
  final currentUser = FirebaseAuth.instance.currentUser!;

  // ALL USERS
  final userCollection = FirebaseFirestore.instance.collection('users');

  // EDIT
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Edit $field',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Masukkan $field baru",
              hintStyle: const TextStyle(color: Colors.grey)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final gender = userData['Jenis Kelamin'];

            String avatarUrl = '';
            if (gender == 'Pria') {
              avatarUrl = 'assets/images/man.png';
            } else if (gender == 'Wanita') {
              avatarUrl = 'assets/images/woman.png';
            } else {
              avatarUrl = 'default';
            }

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(avatarUrl),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        userData['Nama'].toString().toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'Profil Saya',
                    style: TextStyle(
                      color: Color(0xFF1D4A86),
                    ),
                  ),
                ),
                MyTextBox(
                  text: userData['Email'],
                  sectionName: 'Email',
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['Nama'],
                  sectionName: 'Nama',
                  onPressed: () => editField('Nama'),
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['Alamat'],
                  sectionName: 'Alamat',
                  onPressed: () => editField('Alamat'),
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['No HP'].toString(),
                  sectionName: 'No HP',
                  onPressed: () => editField('No HP'.toString()),
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['Tanggal Lahir'],
                  sectionName: "Tanggal Lahir",
                  onPressed: () => editField('Tanggal Lahir'),
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['Jenis Kelamin'],
                  sectionName: "Jenis Kelamin",
                  onPressed: () => editField('Jenis Kelamin'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: ElevatedButton(
                    child: const Text('Keluar'),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('data ${snapshot.error}'),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
