import 'package:alquran_app/model/AlQuranModel.dart';
import 'package:http/http.dart' as http;

class AlQuranViewModel {
  Future<List> getAlQuran() async {
    try {
      http.Response hasil = await http.get(
          Uri.encodeFull(
              "https://al-quran-8d642.firebaseio.com/data.json?print=pretty"),
          headers: {"Accept": "Application/json"});
      if (hasil.statusCode == 200) {
        print("data Alquran Sukses");
        final data = alQuranModelFromJson(hasil.body);
        return data;
      } else {
        print("Error Status ${hasil.statusCode.toString()}");
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }
  }
}
