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
              child: const Text('Save'))
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
        backgroundColor: Colors.grey[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final gender = userData['gender'];

            String avatarUrl = '';
            if (gender == 'male') {
              avatarUrl = 'male';
            } else if (gender == 'male') {
              avatarUrl = 'female';
            } else {
              avatarUrl = 'default';
            }

            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                    Text(userData['name']),
                  ],
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'My Details',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
                MyTextBox(
                  text: userData['email'],
                  sectionName: 'email',
                  onPressed: () => editField('email'),
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['name'],
                  sectionName: 'name',
                  onPressed: () => editField('name'),
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['address'],
                  sectionName: 'alamat',
                  onPressed: () => editField('address'),
                ),
                const SizedBox(height: 5),
                MyTextBox(
                  text: userData['phone number'].toString(),
                  sectionName: 'No HP',
                  onPressed: () => editField('phoneNumber'.toString()),
                ),
                ElevatedButton(
                  child: const Text('Keluar'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
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
