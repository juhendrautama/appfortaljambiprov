import 'package:appfortaljambiprov/cubit/berita_cubit.dart';
import 'package:appfortaljambiprov/cubit/cuaca_cubit.dart';
import 'package:appfortaljambiprov/cubit/l_pengaduan_cubit.dart';
import 'package:appfortaljambiprov/ui/tools/formcari.dart';
import 'package:appfortaljambiprov/ui/tools/infocuaca.dart';
import 'package:appfortaljambiprov/ui/tools/mediasosial.dart';
import 'package:appfortaljambiprov/ui/tools/menalainnya.dart';
import 'package:appfortaljambiprov/ui/tools/menutengah.dart';
import 'package:appfortaljambiprov/ui/tools/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<BeritaCubit>().fetchBerita(); //memanggil berita slider
    // Bikin status bar transparan dan hilangkan padding sistem
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Portal Provinsi Jambi',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: <Color>[
                  const Color.fromARGB(255, 243, 187, 33),
                  const Color.fromARGB(255, 206, 206, 204),
                  const Color.fromARGB(255, 248, 251, 251),
                ],
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        ),
        centerTitle: true,
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
        elevation: 0,
        toolbarHeight: 40,
      ),
      body: Stack(
        children: [
          // ===== Sticky Search Bar di atas =====
          FormCari(),
          // ===== Sticky Search Bar di atas =====
          // ===== Konten scrollable =====
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<BeritaCubit>().fetchBerita();
                context.read<LayananPengaduanCubit>().fetchLayanan();
                context.read<CuacaCubit>().getCuaca();
              }, // supaya tidak ketumpuk pencarian
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // === Slider ===
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: CustomSliderWidget(),
                      ),
                    ),
                    // === Slider ===

                    // === Body ===
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MenuLainnya(),
                            const SizedBox(height: 1),
                            InfoCuacaPage(),
                            const SizedBox(height: 8),
                            MenuTengah(),
                            const SizedBox(height: 8),
                            MenuMediasosial(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    // === Body ===
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
