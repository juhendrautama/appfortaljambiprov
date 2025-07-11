import 'package:appfortaljambiprov/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:splash_view/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashView(
      backgroundColor: Colors.white,
      loadingIndicator: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/logo.png',
          ),
          const SizedBox(height: 24), // Jarak antara logo dan loading
          const CircularProgressIndicator(),
        ],
      ),
      duration: const Duration(seconds: 2),
      done: Done(
        const HomePage(),
      ),
    );
  }
}
