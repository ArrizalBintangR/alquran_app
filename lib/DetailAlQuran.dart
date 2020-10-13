import 'package:flutter/material.dart';
import 'package:alquran_app/viewModel/AyatViewModel.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailAlQuran extends StatefulWidget {
  final String nomor;
  final String nama;

  DetailAlQuran({this.nomor, this.nama});
  @override
  _DetailAlQuranState createState() => _DetailAlQuranState();
}

class _DetailAlQuranState extends State<DetailAlQuran> {
  List detailAyat = List();
  void getAyat() {
    AyatViewModel().getAyat(int.parse(widget.nomor)).then((value) {
      setState(() {
        detailAyat = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAyat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.nama}"),
        ),
        body: detailAyat == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: detailAyat.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("${detailAyat[i].ar}" , style: TextStyle(fontSize: 20),),
                      Html(data: "${detailAyat[i].tr}"),
                      Text("${detailAyat[i].id}")
                    ],
                  ),
                )
              );
            }));
  }
}

