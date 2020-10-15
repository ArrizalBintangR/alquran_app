import 'package:alquran_app/WaktuAdzan.dart';
import 'package:flutter/material.dart';
import 'package:alquran_app/MainMenu.dart';

void main(){
  runApp(MaterialApp(
    title: "AlQuran XII RPL",
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AlQuran XII RPL",
      home: MainMenu(),
    );
  }
}