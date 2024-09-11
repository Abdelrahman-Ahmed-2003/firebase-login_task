import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task/components/buttonauth.dart';
import 'package:firebase_task/components/textfield.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Text("Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Container(height: 10),
            const Text("Login To Continue Using The App",
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
                title: "login",
                onPressed: () async {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    Navigator.of(context).pushReplacementNamed("/home");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No user found for that email.'),
                        ),
                      );
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Wrong password provided for that user.'),
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
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.code),
                        ),
                      );
                    }
                  }
                }),
            Container(height: 20),

            // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("signup");
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Don't Have An Account ? ",
                  ),
                  TextSpan(
                      text: "Register",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
