import 'package:appfortaljambiprov/cubit/berita_cubit.dart';
import 'package:appfortaljambiprov/model/berita_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class CustomSliderWidget extends StatefulWidget {
  const CustomSliderWidget({super.key});

  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeritaCubit, BeritaState>(
      builder: (context, state) {
        if (state is BeritaLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BeritaLoaded) {
          if (state.beritaList.isEmpty) {
            return const Center(child: Text('Tidak ada berita tersedia.'));
          }

          return CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.78,
              padEnds: false,
            ),
            items: state.beritaList.map((berita) {
              return _buildSlide(context, berita);
            }).toList(),
          );
        } else if (state is BeritaError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  String formatTanggalIndo(String input) {
    try {
      DateTime parsedDate = DateTime.parse(input);
      return DateFormat("d MMMM yyyy", "id_ID").format(parsedDate);
    } catch (e) {
      return input; // fallback kalau format tidak valid
    }
  }

  /// Membuat widget slide untuk setiap berita
  Widget _buildSlide(BuildContext context, Berita berita) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // GAMBAR DENGAN CACHE + FADE
            CachedNetworkImage(
              imageUrl: berita.gambar,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey,
                child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
              ),
              fadeInDuration: const Duration(milliseconds: 500),
            ),

            // OVERLAY GELAP TRANSPARAN
            Container(
              color: const Color.fromARGB(79, 0, 0, 0),
            ),

            // KONTEN TEKS DAN TOMBOL
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    berita.judul,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatTanggalIndo(berita.tanggal),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke detail menggunakan id
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(197, 255, 255, 255),
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Lihat Selengkapnya'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
