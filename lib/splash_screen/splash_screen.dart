import 'package:flutter/material.dart';
import 'package:inspire_me/splash_screen/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices _splashServices =SplashServices();
  @override
  void initState() {
    _splashServices.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Inspire ME",
        style: TextStyle(color: Colors.indigo,
            fontSize: 31,
            fontWeight: FontWeight.bold),),),
    );
  }
}