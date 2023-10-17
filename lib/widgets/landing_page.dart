import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gym/forms/exercises_form.dart';
import 'package:flutter_gym/forms/sign_in_form.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            // Пользователь не аутентифицирован, перейдите на страницу входа
            return SignInForm();
          } else {
            // Пользователь аутентифицирован, перейдите на домашнюю страницу
            return ExercisesForm();
          }
        } else {
          // Во время загрузки показать индикатор загрузки
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
