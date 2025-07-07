import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSliderWidget extends StatelessWidget {
  const CustomSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar gambar background
    final List<String> imagePaths = [
      'assets/bg.png',
      'assets/bgmedsos.jpeg',
    ];

    final slides = imagePaths.map((image) => _buildSlide(context, image)).toList();

    return Align(
      alignment: Alignment.centerLeft,
      child: CarouselSlider(
        items: slides,
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          viewportFraction: 0.78,
          enableInfiniteScroll: true,
          padEnds: false,
        ),
      ),
    );
  }

  Widget _buildSlide(BuildContext context, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color.fromARGB(84, 0, 0, 0), // Gelapkan gambar biar teks tetap jelas
            BlendMode.darken,
          ),
        ),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('JUDUL BERITA', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text(
            '01 Januari 2025',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol ditekan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(197, 255, 255, 255),
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: const Text('Lihat Selengkapnya'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
