import 'package:flutter/material.dart';

class MenuLainnya extends StatefulWidget {
  const MenuLainnya({super.key});

  @override
  State<MenuLainnya> createState() => _MenuLainnyaState();
}

class _MenuLainnyaState extends State<MenuLainnya> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('https://portal.jambiprov.go.id/img/img_mobile/sekilas_jambi.png'),
          scale: 1.3,
          opacity: 0.1,
          fit: BoxFit.fill,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(208, 224, 177, 81),
            Color.fromARGB(208, 62, 169, 227),
            Color.fromARGB(255, 16, 99, 163),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
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
            "Layanan Pengaduan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 50, // Jarak antar item horizontal
            runSpacing: 15, // Jarak antar item vertikal jika pindah baris
            children: [
              menuItem(Icons.report_problem, "Span Lapor", Colors.orange),
              menuItem(Icons.phone_in_talk, "Telepon Darurat", Colors.red),
              // Tambahkan menu lain di sini jika perlu
              // menuItem(Icons.mail, "Email", Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String label, Color iconColor) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika ditekan
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 125,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
