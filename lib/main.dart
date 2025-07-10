import 'package:appfortaljambiprov/cubit/berita_cubit.dart';
import 'package:appfortaljambiprov/cubit/cuaca_cubit.dart';
import 'package:appfortaljambiprov/repository/berita_repository.dart';
import 'package:appfortaljambiprov/repository/cuaca_repository.dart';
import 'package:appfortaljambiprov/ui/Homepage.dart';
import 'package:appfortaljambiprov/ui/spalasscreenview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID', null); // ⬅️ ini penting!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CuacaCubit(CuacaRepository())),
        BlocProvider(create: (_) => BeritaCubit(BeritaRepository())),
      ],
      child: MaterialApp(
        title: 'Portal Provinsi Jambi',
        initialRoute: '/',
        routes: {
          // Menu utama
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          // Menu utama
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
