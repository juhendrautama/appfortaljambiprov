import 'package:appfortaljambiprov/model/l_pengaduan_model.dart';
import 'package:appfortaljambiprov/repository/l_pengaduan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LayananPengaduanState {}

class LayananPengaduanInitial extends LayananPengaduanState {}

class LayananPengaduanLoading extends LayananPengaduanState {}

class LayananPengaduanLoaded extends LayananPengaduanState {
  final List<LayananPengaduan> layanan;
  LayananPengaduanLoaded(this.layanan);
}

class LayananPengaduanError extends LayananPengaduanState {
  final String message;
  LayananPengaduanError(this.message);
}

class LayananPengaduanCubit extends Cubit<LayananPengaduanState> {
  final LayananPengaduanRepository repository;

  LayananPengaduanCubit(this.repository) : super(LayananPengaduanInitial());

  void fetchLayanan() async {
    emit(LayananPengaduanLoading());
    try {
      final data = await repository.fetchLayanan();
      emit(LayananPengaduanLoaded(data));
    } catch (e) {
      emit(LayananPengaduanError(e.toString()));
    }
  }
}
