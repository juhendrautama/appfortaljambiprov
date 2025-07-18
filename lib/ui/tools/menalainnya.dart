import 'package:appfortaljambiprov/cubit/l_pengaduan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:url_launcher/url_launcher.dart';

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
              BlocBuilder<LayananPengaduanCubit, LayananPengaduanState>(
                builder: (context, state) {
                  if (state is LayananPengaduanLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LayananPengaduanLoaded) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: menuItem(
                              "Telepon Darurat",
                              'https://img.icons8.com/ios-filled/50/phone.png',
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Telepon Darurat ditekan')),
                                );
                              },
                            ),
                          ),
                          BlocBuilder<LayananPengaduanCubit, LayananPengaduanState>(
                            builder: (context, state) {
                              if (state is LayananPengaduanLoading) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is LayananPengaduanLoaded) {
                                return Row(
                                  children: state.layanan.map((layanan) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: menuItem(
                                        layanan.namaAplikasi,
                                        'https://api-portal.jhu.my.id/img/layanan_pengaduan/${layanan.logo}',
                                        () async {
                                          final packageName = layanan.link;
                                          bool isInstalled = await InstalledApps.isAppInstalled(packageName) ?? false;

                                          if (isInstalled) {
                                            InstalledApps.startApp(packageName);
                                          } else {
                                            if (layanan.kodeTampilan == '1') {
                                              final playStoreUrl = 'https://play.google.com/store/apps/details?id=$packageName';

                                              if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
                                                await launchUrl(
                                                  Uri.parse(playStoreUrl),
                                                  mode: LaunchMode.externalApplication,
                                                );
                                              } else {
                                                if (!context.mounted) return;
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Tidak dapat membuka Play Store untuk ${layanan.namaAplikasi}')),
                                                );
                                              }
                                            } else {
                                              if (!context.mounted) return;
                                              final Uri url = Uri.parse(layanan.link);
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url, mode: LaunchMode.externalApplication);
                                              } else {
                                                debugPrint('Tidak dapat membuka URL: ${layanan.link}');
                                              }
                                            }
                                          }
                                        },
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else if (state is LayananPengaduanError) {
                                return Text(
                                  'Gagal memuat data: ${state.message}',
                                  style: const TextStyle(color: Colors.red),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (state is LayananPengaduanError) {
                    return Text(
                      'Gagal memuat data: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget menuItem(String label, String imageUrl, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
              ),
            ),
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
