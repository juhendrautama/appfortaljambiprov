class LayananPengaduan {
  final String id;
  final String namaAplikasi;
  final String logo;
  final String link;
  final String ket;
  final String kodeTampilan;
  final String tgl;

  LayananPengaduan({
    required this.id,
    required this.namaAplikasi,
    required this.logo,
    required this.link,
    required this.ket,
    required this.kodeTampilan,
    required this.tgl,
  });

  factory LayananPengaduan.fromJson(Map<String, dynamic> json) {
    return LayananPengaduan(
      id: json['idLayananPengaduan'],
      namaAplikasi: json['namaAplikasi'],
      logo: json['logo'],
      link: json['link'],
      ket: json['Ket'],
      kodeTampilan: json['kodeTampilan'],
      tgl: json['tgl'],
    );
  }
}
