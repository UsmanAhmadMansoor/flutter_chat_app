import 'package:chat_app/screens/inbox/inbox_screen.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignupButton({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      title: 'Signup',
      onPressed: () => onPressed(context),
    );
  }

  void onPressed(BuildContext context) async {
    try {
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      final email = userCredentials.user?.email;
      if (email != null) {
        FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'dateTime': DateTime.now(),
      });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InboxScreen(email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not signup, please try again.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The account already exists for that email.')),
        );
      }
    }
  }
}
