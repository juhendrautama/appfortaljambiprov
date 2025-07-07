import 'package:appfortaljambiprov/ui/tools/infocuaca.dart';
import 'package:appfortaljambiprov/ui/tools/mediasosial.dart';
import 'package:appfortaljambiprov/ui/tools/menalainnya.dart';
import 'package:appfortaljambiprov/ui/tools/menutengah.dart';
import 'package:appfortaljambiprov/ui/tools/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

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
        title: const Text(
          'Portal Provinsi Jambi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
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
          // ===== Konten scrollable =====
          Padding(
            padding: const EdgeInsets.only(top: 60), // supaya tidak ketumpuk pencarian
            child: SingleChildScrollView(
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

          // ===== Sticky Search Bar di atas =====
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 55,
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
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari...',
                  hintStyle: const TextStyle(color: Color.fromARGB(179, 44, 44, 44)),
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 40, 39, 39)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 246, 247, 248),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Color.fromARGB(255, 32, 32, 32)),
                cursorColor: const Color.fromARGB(255, 13, 13, 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
