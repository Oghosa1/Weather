import 'package:WeatherApp/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:unit_conversion/unit_conversion.dart';

class LocationScreen extends StatefulWidget {
  final LocationWeather;
  LocationScreen({this.LocationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int condition;
  int temperature;
  String city;
  double temTocel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.LocationWeather);
  }

  void updateUI(dynamic weatherData) {
    condition = weatherData['weather'][0]['id'];
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    city = weatherData['name'];
    // temTocel = UnitConverter.kelvinToCelsius(temperature);
    // print(temTocel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in ${city.toString()}!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// var longitude = jsonDecode(data)['coord']['lon'];
// var latitude = jsonDecode(data)['coord']['lat'];
// var weatherDescription = jsonDecode(data)['weather'][0]['description'];
// var temperature = jsonDecode(data)['main']['temp'];
// var city = jsonDecode(data)['name'];
