import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task/components/buttonauth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child :CustomButtonAuth(
          title: "Logout",
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed("/");
          },
        ),
      ),  
    );
  }
}