// File: cubit/cuaca_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import '../repository/cuaca_repository.dart';

// Cuaca State
abstract class CuacaState {}

class CuacaInitial extends CuacaState {}

class CuacaLoading extends CuacaState {}

class CuacaLoaded extends CuacaState {
  final List<Weather> listKotaCuaca;
  CuacaLoaded(this.listKotaCuaca);
}

class CuacaError extends CuacaState {
  final String message;
  CuacaError(this.message);
}

// Cuaca Cubit
class CuacaCubit extends Cubit<CuacaState> {
  final CuacaRepository repository;

  CuacaCubit(this.repository) : super(CuacaInitial());

  void getCuaca() async {
    emit(CuacaLoading());
    try {
      final result = await repository.fetchCuacaKota();
      emit(CuacaLoaded(result));
    } catch (e) {
      emit(CuacaError("Gagal memuat cuaca: $e"));
    }
  }
}
