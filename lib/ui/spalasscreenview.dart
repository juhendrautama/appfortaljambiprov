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
          Text(
            'Portal Provinsi Jambi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[
                    const Color.fromARGB(255, 243, 240, 33),
                    const Color.fromARGB(255, 21, 18, 1),
                  ],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16), // Jarak antara text dan loading
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
