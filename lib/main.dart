import 'package:appfortaljambiprov/cubit/cuaca_cubit.dart';
import 'package:appfortaljambiprov/repository/cuaca_repository.dart';
import 'package:appfortaljambiprov/ui/Homepage.dart';
import 'package:appfortaljambiprov/ui/spalasscreenview.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CuacaCubit(CuacaRepository())),
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
