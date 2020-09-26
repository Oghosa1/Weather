import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print('Latitude ${location.latitude.toString()}');
    print('Longitude' + location.longitude.toString());
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=6.486486486486487&lon=3.04652930019801&appid=52978192364d8851a6026420f272d67d');
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
