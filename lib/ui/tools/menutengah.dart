import 'package:flutter/material.dart';

class MenuTengah extends StatefulWidget {
  const MenuTengah({super.key});

  @override
  State<MenuTengah> createState() => _MenuTengahState();
}

class _MenuTengahState extends State<MenuTengah> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('https://portal.jambiprov.go.id/img/img_mobile/sekilas_jambi.png'),
          scale: 1.3,
          opacity: 0.1,
          fit: BoxFit.fill,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(15)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(208, 81, 195, 224),
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
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text(
            "Layanan Utama",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 60,
            runSpacing: 10,
            children: [
              _buildMenuButton(Icons.people, "Publik", Colors.orange),
              _buildMenuButton(Icons.business_center, "Pengadaan", Colors.blue),
              _buildMenuButton(Icons.account_balance, "Pemerintah", Colors.green),
              _buildMenuButton(Icons.insert_chart, "Data & Info", Colors.purple),
              _buildMenuButton(Icons.language, "Website", Colors.teal),
              _buildMenuButton(Icons.location_on_outlined, "Jelajah", Colors.redAccent),
            ],
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          onPressed: () {},
          child: Icon(icon, color: color, size: 27),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
