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

class BeritaCari {
  final String id;
  final String judul;
  final String kategori;
  final String tanggal;
  final String konten;
  final String url;
  final String gambar;

  BeritaCari({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.tanggal,
    required this.konten,
    required this.url,
    required this.gambar,
  });

  factory BeritaCari.fromJson(Map<String, dynamic> json) {
    return BeritaCari(
      id: json['id'] ?? '',
      judul: json['judul'] ?? '-',
      kategori: json['kategori'] ?? '-',
      tanggal: json['tanggal'] ?? '-',
      konten: json['konten'] ?? '-',
      url: json['url_berita'] ?? '-',
      gambar: json['galeri_gambar'] ?? 'https://via.placeholder.com/400x200.png?text=No+Image',
    );
  }
}
