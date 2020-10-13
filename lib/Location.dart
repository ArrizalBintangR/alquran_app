import 'package:flutter/material.dart';
import 'package:alquran_app/viewModel/LocationViewModel.dart';
// import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // Position _currentPosition;
  // String _currentAddress;
  List userLocation = List();
  void getUserLocation() {
    LocationViewModel().getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waktu Sholat")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: userLocation.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(userLocation[i].nama),
                    subtitle: Text("${userLocation[i].type.toString().split('.').last} | ${userLocation[i].ayat} Ayat"),
                    trailing: Text(userLocation[i].asma),
                    onTap: () {
                    },
                  );
                })
          ],
        ),
      ),
    );
  }

  // _getCurrentLocation() {
  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //
  //     _getAddressFromLatLng();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  //
  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //
  //     Placemark place = p[0];
  //
  //     setState(() {
  //       _currentAddress =
  //       "${place.subAdministrativeArea}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}


// if (_currentPosition != null)
// Text(_currentAddress),
// // Text(),
// // Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
// FlatButton(
// color: Colors.blue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// ),
// child:
// Text("Get location", style: TextStyle(color: Colors.white)),
// onPressed: () {
// _getCurrentLocation();
// },
// ),