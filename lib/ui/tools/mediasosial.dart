import 'package:flutter/material.dart';

class MenuMediasosial extends StatefulWidget {
  const MenuMediasosial({super.key});

  @override
  State<MenuMediasosial> createState() => _MenuMediasosialState();
}

class _MenuMediasosialState extends State<MenuMediasosial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/bgmedsos.jpeg'),
          scale: 1.3,
          opacity: 0.2,
          fit: BoxFit.fill,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25), bottom: Radius.circular(25)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(208, 81, 195, 224),
            Color.fromARGB(208, 62, 169, 227),
            Color.fromARGB(255, 16, 99, 163),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(120, 144, 141, 141),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Media Sosial",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 1),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 70,
            runSpacing: 5, // Jarak antar item vertikal jika pindah baris
            children: [
              medsosIcon("assets/instagram.png", "Instagram", () {
                // launchUrl(Uri.parse('https://instagram.com/yourprofile'));
              }),
              medsosIcon("assets/youtube.png", "YouTube", () {
                // launchUrl(Uri.parse('https://youtube.com/yourchannel'));
              }),
              medsosIcon("assets/tiktok.png", "TikTok", () {
                // launchUrl(Uri.parse('https://tiktok.com/@yourprofile'));
              }),
              // Tambahkan medsos lainnya jika perlu
              // medsosIcon("assets/facebook.png", "Facebook", () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget medsosIcon(String assetPath, String tooltip, VoidCallback onTap) {
    return IconButton(
      icon: Image.asset(assetPath, width: 32, height: 32),
      onPressed: onTap,
      tooltip: tooltip,
    );
  }
}
