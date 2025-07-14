import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inspire_me/screens/home_screen.dart';
import 'package:inspire_me/auth/login_screen.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      //  Load user-specific data
      Provider.of<AppProvider>(context, listen: false).init().then((_) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        });
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const Login()));
      });
    }
  }
}
