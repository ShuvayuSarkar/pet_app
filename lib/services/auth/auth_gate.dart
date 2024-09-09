//to check if user is logged in or not
//if logged in -> go to home page
//if not logged in -> go to login or register page

import 'package:pet_app/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/pages/home_page.dart';
import 'package:pet_app/pages/registerpage.dart';
import 'package:pet_app/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return const HomePage();
          }

          //if user is nit logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
