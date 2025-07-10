import 'package:appfortaljambiprov/model/berita_model.dart';
import 'package:appfortaljambiprov/repository/berita_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeritaState {
  const BeritaState();
}

class BeritaLoading extends BeritaState {}

class BeritaLoaded extends BeritaState {
  final List<Berita> beritaList;

  BeritaLoaded(this.beritaList);
}

class BeritaError extends BeritaState {
  final String message;

  BeritaError(this.message);
}

class BeritaCubit extends Cubit<BeritaState> {
  final BeritaRepository repository;

  BeritaCubit(this.repository) : super(BeritaLoading());

  void fetchBerita() async {
    try {
      emit(BeritaLoading());
      final beritaList = await repository.fetchBerita();
      emit(BeritaLoaded(beritaList));
    } catch (e) {
      emit(BeritaError('Gagal mengambil data: $e'));
    }
  }
}
