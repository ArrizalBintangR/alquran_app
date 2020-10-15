import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/prayer_time.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position userLocation;
  Placemark userAddress;

  double lat_value = -6.2048;
  double long_value = 106.9883;
  String address = "Kota Bekasi";

  List<String> _prayerTimes = [];
  List<String> _prayerNames = [];
  List initData = [];

  @override
  void initState() {
    super.initState();

    getSP().then((value) {
      initData = value;
      getPrayerTimes(lat_value, long_value);
      getAddress(lat_value, long_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "Waktu Sholat",
                        style: TextStyle(fontSize: 30,fontFamily: 'Montserrat',color: Colors.greenAccent, fontStyle: FontStyle.normal),
                      )),
                  SizedBox(height: 30),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ListView.builder(
                          itemCount: _prayerNames.length,
                          itemBuilder: (context, position) {
                            return Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 80,
                                        child: Text(_prayerNames[position],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold
                                            ))),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                        color: Colors.teal[50],
                                      ),
                                      child: Text(
                                        _prayerTimes[position],
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20,
                                            fontFamily: 'Monserrat',
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ));
                          })),
                  SizedBox(height: 10),
                  FlatButton.icon(
                      onPressed: () {
                        _getLocation().then((value) {
                          setState(() {
                            userLocation = value;
                            getPrayerTimes(
                                userLocation.latitude, userLocation.longitude);
                            getAddress(userLocation.latitude, userLocation.longitude);
                            address = " ${userAddress.subAdministrativeArea} "
                                " ${userAddress.country} ";
                          });

                          setSP();
                        });
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      label: Text(
                        address ?? "Mencari lokasi ...",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 14),
                      ))
                ]),
          )),
    );
  }

  Future<Position> _getLocation() async {
    var currentLocation;

    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  getAddress(double lat, double long) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, long);
      Placemark place = p[0];
      userAddress = place;
      print("future :" + place.subAdministrativeArea);
    } catch (e) {
      userAddress = null;
    }
  }

  getPrayerTimes(double lat, double long) {
    PrayerTime prayers = new PrayerTime();

    prayers.setTimeFormat(prayers.getTime12());
    prayers.setCalcMethod(prayers.getMWL());
    prayers.setAsrJuristic(prayers.getShafii());
    prayers.setAdjustHighLats(prayers.getAdjustHighLats());

    List<int> offsets = [-6, 0, 3, 2, 0, 3, 6];

    String tmx = "${DateTime.now().timeZoneOffset}";

    var currentTime = DateTime.now();
    var timeZone = double.parse(tmx[0]);

    prayers.tune(offsets);

    setState(() {
      _prayerTimes = prayers.getPrayerTimes(currentTime, lat, long, timeZone);
      _prayerNames = prayers.getTimeNames();
    });
  }

  void setSP() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setDouble('key_lat', userLocation.latitude);
    pref.setDouble('key_long', userLocation.longitude);
    pref.setString('key_address',
        " ${userAddress.subAdministrativeArea}" "${userAddress.country} ");
  }

  Future<dynamic> getSP() async {
    List dataPref = [];
    SharedPreferences pref = await SharedPreferences.getInstance();

    lat_value = pref.getDouble('key_lat');
    long_value = pref.getDouble('key_long');
    address = pref.getString('key_address');

    dataPref.add(lat_value);
    dataPref.add(long_value);
    dataPref.add(address);

    return dataPref;
  }
}