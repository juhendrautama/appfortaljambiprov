class Berita {
  final String id;
  final String judul;
  final String tanggal;
  final String gambar;

  Berita({
    required this.id,
    required this.judul,
    required this.tanggal,
    required this.gambar,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'] ?? '',
      judul: json['judul'] ?? '-',
      tanggal: json['tanggal'] ?? '-', // atau json['created_at']?
      gambar: json['galeri_gambar'] ?? 'https://via.placeholder.com/400x200.png?text=No+Image',
    );
  }
}
