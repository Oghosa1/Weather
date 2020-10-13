import 'dart:convert';
import 'package:WeatherApp/screens/location_screen.dart';
import 'package:WeatherApp/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var latitude;
  var longitude;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          LocationWeather: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDoubleBounce(
            color: Color(0xFFffffff),
            size: 100,
          ),
          Text(
            'Getting Your Current Location',
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'Spartan MB',
                fontSize: 20),
          ),
        ],
      )),
    );
  }
}
