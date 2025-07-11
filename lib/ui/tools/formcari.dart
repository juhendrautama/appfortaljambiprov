import 'package:appfortaljambiprov/cubit/berita_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormCari extends StatefulWidget {
  const FormCari({super.key});

  @override
  State<FormCari> createState() => _FormCariState();
}

class _FormCariState extends State<FormCari> {
  final TextEditingController _searchController = TextEditingController();

//modal popup
  void _showSearchResultSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return BlocBuilder<BeritaCubitCari, BeritaStateCari>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                if (state.beritaList.isEmpty) {
                  return const Center(child: Text('Tidak ada hasil'));
                }
                return ListView.builder(
                  controller: scrollController,
                  itemCount: state.beritaList.length,
                  itemBuilder: (context, index) {
                    final berita = state.beritaList[index];
                    return ListTile(
                      leading: Image.network(
                        berita.gambar,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                      ),
                      title: Text(berita.judul),
                      subtitle: Text(berita.tanggal),
                      onTap: () {
                        // Bisa tambahkan navigasi ke detail
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
//modal popup

  @override
  void initState() {
    super.initState();
    context.read<BeritaCubitCari>().fetchBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
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
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(213, 5, 43, 116),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: 1,
                        ),
                        onPressed: () {
                          context.read<BeritaCubitCari>().cariBerita(_searchController.text);
                          _showSearchResultSheet(context);
                        },
                        child: const Text(
                          'Cari',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Color.fromARGB(255, 32, 32, 32)),
                  cursorColor: const Color.fromARGB(255, 13, 13, 13),
                  onSubmitted: (value) {
                    context.read<BeritaCubitCari>().cariBerita(value);
                    _showSearchResultSheet(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
