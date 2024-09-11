import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task/components/buttonauth.dart';
import 'package:firebase_task/components/textfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Text("SignUp",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Container(height: 10),
            const Text("SignUp To Continue Using The App",
                style: TextStyle(color: Colors.grey)),
            const Spacer(),
            
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(height: 10),
            CustomTextForm(hinttext: "ُEnter Your Email", mycontroller: email),
            Container(height: 10),
            const Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(height: 10),
            CustomTextForm(
                hinttext: "ُEnter Your Password", mycontroller: password),
            const Spacer(),
            CustomButtonAuth(
                title: "SignUp",
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    
                    Navigator.pushReplacementNamed(context, "/home") ;
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('The password provided is too weak.'),
                        ),
                      );
                    } else if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'The account already exists for that email.'),
                        ),
                      );
                    }
                    else if(e.code == 'channel-error')
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('please enter all data'),
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.code),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                }),
          ]),
        ),
      ),
    );
  }
}
