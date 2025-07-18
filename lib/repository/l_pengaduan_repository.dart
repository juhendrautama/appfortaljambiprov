import 'dart:convert';
import 'package:appfortaljambiprov/model/l_pengaduan_model.dart';
import 'package:http/http.dart' as http;

class LayananPengaduanRepository {
  final String _url = 'https://api-portal.jhu.my.id/ApiLayananPengaduan/GetData';
  final String _token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTE4NzQ1MzYsImRhdGEiOnsibmFtYV9hcGxpa2FzaSI6IkFQSSBKYW1iaSIsImFrc2VzIjoicHVibGlrIn19.4FyrCbDC7bA7vmrd3OKzh-qHXBDnMeMfPuQkrY2mEE4';

  Future<List<LayananPengaduan>> fetchLayanan() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var request = http.Request('POST', Uri.parse(_url));
    request.bodyFields = {
      'token': _token,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = json.decode(responseBody);

      if (jsonData['status']) {
        List data = jsonData['data'];
        return data.map((e) => LayananPengaduan.fromJson(e)).toList();
      } else {
        throw Exception('Status false');
      }
    } else {
      throw Exception('Failed with status: ${response.statusCode}');
    }
  }
}
