import 'package:appfortaljambiprov/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:splash_view/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashView(
      backgroundColor: Colors.white,
      loadingIndicator: const CircularProgressIndicator(),
      logo: Image.asset(
        'assets/logo.png', // Ganti dengan logo kamu
      ),
      duration: const Duration(seconds: 3),
      done: Done(
        const HomePage(),
      ),
    );
  }
}
