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

// proses berita cari

class BeritaStateCari {
  final List<BeritaCari> beritaList;
  final bool isLoading;
  final String? error;

  BeritaStateCari({required this.beritaList, this.isLoading = false, this.error});

  BeritaStateCari copyWith({
    List<BeritaCari>? beritaList,
    bool? isLoading,
    String? error,
  }) {
    return BeritaStateCari(
      beritaList: beritaList ?? this.beritaList,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class BeritaCubitCari extends Cubit<BeritaStateCari> {
  final BeritaRepositoryCari repository;

  BeritaCubitCari(this.repository) : super(BeritaStateCari(beritaList: []));

  void fetchBerita() async {
    emit(state.copyWith(isLoading: true));
    try {
      final berita = await repository.fetchBerita();
      emit(state.copyWith(beritaList: berita, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void cariBerita(String query) {
    final filtered = state.beritaList.where((b) => b.judul.toLowerCase().contains(query.toLowerCase())).toList();
    emit(state.copyWith(beritaList: filtered));
  }
}
