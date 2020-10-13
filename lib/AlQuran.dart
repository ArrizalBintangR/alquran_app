import 'package:flutter/material.dart';
import 'package:alquran_app/viewModel/AlQuranViewModel.dart';
import 'DetailAlQuran.dart';

class AlQuran extends StatefulWidget {
  @override
  _AlQuranState createState() => _AlQuranState();
}

class _AlQuranState extends State<AlQuran> {
  List detailQuran = List();
  void getListSurat() {
    AlQuranViewModel().getAlQuran().then((value) {
      setState(() {
        detailQuran = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getListSurat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AlQuran"),
        ),
        body: detailQuran == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: detailQuran.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(detailQuran[i].nama),
                    subtitle: Text("${detailQuran[i].type.toString().split('.').last} | ${detailQuran[i].ayat} Ayat"),
                    trailing: Text(detailQuran[i].asma),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DetailAlQuran(
                              nomor: detailQuran[i].nomor,
                              nama: detailQuran[i].nama);
                        }),
                      );
                    },
                  );
                }));
  }
}
