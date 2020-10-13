import 'package:alquran_app/model/LocationModel.dart';
import 'package:http/http.dart' as http;

class LocationViewModel {
  Future<List<LocationModel>> getLocation() async {
    try {
      http.Response hasil = await http.get(
          Uri.encodeFull(
              "https://api.pray.zone/v2/times/day.json?city=bogor&date=2020-10-07"),
          headers: {"Accept": "Application/json"});
      if (hasil.statusCode == 200) {
        print("Location Successfully Gathered");
        final datas = locationModelFromJson(hasil.body);
        // return datas;
      } else {
        print("Error Status ${hasil.statusCode.toString()}");
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }
  }
}
