import 'dart:convert';
import 'package:appfortaljambiprov/model/berita_model.dart';
import 'package:http/http.dart' as http;

class BeritaRepository {
  final String _url = 'https://api-portal.jhu.my.id/ApiJambiprov';
  final String _token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTE4NzQ1MzYsImRhdGEiOnsibmFtYV9hcGxpa2FzaSI6IkFQSSBKYW1iaSIsImFrc2VzIjoicHVibGlrIn19.4FyrCbDC7bA7vmrd3OKzh-qHXBDnMeMfPuQkrY2mEE4';

  Future<List<Berita>> fetchBerita() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var request = http.Request('POST', Uri.parse(_url));
    request.bodyFields = {'token': _token};
    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final List<dynamic> jsonList = json.decode(responseBody);
      return jsonList.map((item) => Berita.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data berita: ${response.reasonPhrase}');
    }
  }
}
