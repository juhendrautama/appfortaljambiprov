import 'package:weather/weather.dart';

class CuacaRepository {
  final WeatherFactory _wf = WeatherFactory("e1ea8b6edf2dac6c78231ace85ebc80f", language: Language.INDONESIAN);

  Future<List<Weather>> fetchCuacaKota() async {
    List<String> kotaJambi = ["Jambi,ID", "Muaro Jambi,ID", "Batanghari,ID", "Tebo,ID", "Bungo,ID", "Tanjung Jabung Timur,ID", "Tanjung Jabung Barat,ID", "Sarolangun,ID", "Merangin,ID", "Kerinci,ID", "Sungai Penuh,ID"];

    List<Weather> results = [];
    for (var kota in kotaJambi) {
      try {
        final weather = await _wf.currentWeatherByCityName(kota);
        results.add(weather);
      } catch (e) {
        // ignore: avoid_print
        print("Gagal ambil cuaca untuk $kota: $e");
      }
    }
    return results;
  }
}
