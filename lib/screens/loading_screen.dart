import 'dart:convert';
import 'package:WeatherApp/screens/location_screen.dart';
import 'package:WeatherApp/services/location.dart';
import 'package:WeatherApp/services/networking.dart';
import 'package:WeatherApp/utilities/constants.dart';
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
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');
    var weatherData = await networkHelper.getData();
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
