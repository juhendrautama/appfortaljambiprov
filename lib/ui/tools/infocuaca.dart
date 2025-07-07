import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import '../../cubit/cuaca_cubit.dart';

class InfoCuacaPage extends StatefulWidget {
  const InfoCuacaPage({super.key});

  @override
  State<InfoCuacaPage> createState() => _InfoCuacaPageState();
}

class _InfoCuacaPageState extends State<InfoCuacaPage> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  Timer? _refreshTimer;
  Timer? _resumeAutoScrollTimer;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onUserScroll);

    _startAutoScroll();
    _startAutoRefresh();
    context.read<CuacaCubit>().getCuaca();
  }

  void _onUserScroll() {
    // Deteksi aktivitas scroll manual oleh user
    if (_scrollController.position.isScrollingNotifier.value) {
      _isUserScrolling = true;
      _scrollTimer?.cancel();

      // Tunggu 3 detik tanpa aktivitas untuk melanjutkan auto-scroll
      _resumeAutoScrollTimer?.cancel();
      _resumeAutoScrollTimer = Timer(const Duration(seconds: 3), () {
        _isUserScrolling = false;
        _startAutoScroll();
      });
    }
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();
    const duration = Duration(milliseconds: 100);

    _scrollTimer = Timer.periodic(duration, (timer) {
      if (_isUserScrolling) return;
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final current = _scrollController.offset;
        double next = current + 1;

        if (next >= maxScroll) {
          _scrollController.jumpTo(0); // Ulang dari awal
        } else {
          _scrollController.jumpTo(next);
        }
      }
    });
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      context.read<CuacaCubit>().getCuaca(); // Update data tiap 5 menit
    });
  }

  IconData getIcon(String? main) {
    if (main == null) return Icons.help_outline;
    final d = main.toLowerCase();

    if (d.contains('clear')) return Icons.wb_sunny; // Cerah
    if (d.contains('cloud')) return Icons.cloud; // Berawan
    if (d.contains('rain') || d.contains('drizzle')) return Icons.beach_access; // Hujan
    if (d.contains('storm') || d.contains('thunder')) return Icons.flash_on; // Badai
    if (d.contains('snow')) return Icons.ac_unit; // Salju
    if (d.contains('fog') || d.contains('mist')) return Icons.blur_on; // Kabut

    return Icons.thermostat; // Default
  }

  Widget buildCuacaMiniCard(Weather cuaca) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(getIcon(cuaca.weatherMain), color: Colors.white, size: 20),
            const SizedBox(width: 5),
            Text(
              "${cuaca.areaName}: ${cuaca.weatherDescription} ${cuaca.temperature?.celsius?.toStringAsFixed(1)}°C",
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _refreshTimer?.cancel();
    _resumeAutoScrollTimer?.cancel();
    _scrollController.removeListener(_onUserScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(15)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(208, 81, 195, 224),
            Color.fromARGB(180, 22, 131, 215), // Biru Tua
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(120, 144, 141, 141),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            BlocBuilder<CuacaCubit, CuacaState>(
              builder: (context, state) {
                if (state is CuacaLoading) {
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                } else if (state is CuacaLoaded) {
                  return SizedBox(
                    height: 20,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.campaign, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "Info Cuaca ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.listKotaCuaca.length * 2,
                            itemBuilder: (context, index) {
                              final cuaca = state.listKotaCuaca[index % state.listKotaCuaca.length];
                              return buildCuacaMiniCard(cuaca);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is CuacaError) {
                  return Text(state.message, style: const TextStyle(color: Colors.white));
                }
                return const Text("Tidak Ada Koneksi", style: TextStyle(color: Colors.white));
              },
            ),
          ],
        ),
      ),
    );
  }
}
