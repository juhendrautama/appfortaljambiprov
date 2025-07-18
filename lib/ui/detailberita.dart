import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class DetailBerita extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const DetailBerita({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Berita',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon kembali jadi putih
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(208, 81, 195, 224),
                Color.fromARGB(208, 62, 169, 227),
                Color.fromARGB(208, 62, 169, 227),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 350,
              placeholder: (context, url) => Container(color: Colors.grey[300], height: 220),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey,
                height: 220,
                child: const Center(child: Icon(Icons.broken_image, size: 50)),
              ),
            ),

            // Konten
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getTanggalSekarang(), // Bisa diganti sesuai tanggal berita
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    content
                        .replaceAll(RegExp(r'<[^>]*>'), '') // Hapus semua tag HTML
                        .replaceAll(RegExp(r'&[^;\s]+;'), '') // Hapus entitas HTML seperti &emsp;, &nbsp;, dll
                        .trim(), // Hilangkan spasi awal/akhir
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTanggalSekarang() {
    // Kalau ingin pakai tanggal dari model, tinggal tambahkan parameter tanggal
    return DateFormat("d MMMM yyyy", "id_ID").format(DateTime.now());
  }

  // Helper untuk navigasi
  void navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }
}
