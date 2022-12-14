import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0,right: 10,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'User ID: $uid',
            style: const TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Your Email: $email',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              user!.emailVerified
                  ? const Text(
                'Verified',
                style: TextStyle(fontSize: 18.0, color: Colors.deepPurple,fontWeight: FontWeight.bold),
              )
                  : TextButton(
                  onPressed: () => {verifyEmail()},
                  child: const Text(' Verify Email'))
            ],
          ),
          Text(
            'Created: $creationTime',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
