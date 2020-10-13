import 'package:alquran_app/model/AyatModel.dart';
import 'package:http/http.dart' as http;

class AyatViewModel{
  Future<List> getAyat(int nomor) async{
    try{
      http.Response hasil = await http.get(
          Uri.encodeFull("https://al-quran-8d642.firebaseio.com/surat/${nomor}.json?print=pretty"),
          headers: {"Accept": "Application/json"}
      );
      if(hasil.statusCode == 200){
        print("data Ayat Sukses");
        final data = ayatModelFromJson(hasil.body);
        return data;
      } else{
        print("Error Status ${hasil.statusCode.toString()}");
      }
    } catch(e){
      print("error catch $e");
      return null;
    }
  }
}