import 'package:weather/screens/city_screen.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;
  const LocationScreen({super.key, required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;
  String? _errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      // Reset error message at the beginning
      _errorMessage = null;
      
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = 'your location';
        weatherMessage = 'Unable to get weather data';
        _errorMessage = "Error: Unable to get weather data";
        return;
      }
      
      // Check if there's an error in the response
      if (weatherData is Map && weatherData.containsKey('error') && weatherData['error'] == true) {
        temperature = 0;
        weatherIcon = '⚠️';
        cityName = '';
        weatherMessage = weatherData['message'] ?? 'Failed to get weather data';
        
        // Override the display message for errors
        _errorMessage = "Error: ${weatherData['message'] ?? 'Failed to get weather data'}";
        
        // Add detailed logging
        print("Weather API error: $weatherData");
        if (weatherData.containsKey('statusCode')) {
          print("Status code: ${weatherData['statusCode']}");
        }
        return;
      }
      
      try {
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition);
        weatherMessage = weather.getMessage(temperature);
        cityName = weatherData['name'];
        print(temp);
        // temTocel = UnitConverter.kelvinToCelsius(temperature);
        // print(temTocel);
      } catch (e) {
        print('Error parsing weather data: $e');
        print('Weather data received: $weatherData');
        temperature = 0;
        weatherIcon = '❓';
        cityName = 'Unknown';
        weatherMessage = 'Error parsing weather data';
        _errorMessage = "Error parsing weather data: $e";
      }
    });
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
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //Changing screen
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: _errorMessage != null
                    ? Text(
                        _errorMessage!,
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle.copyWith(color: Colors.red),
                      )
                    : Text(
                        "It's $weatherMessage time in $cityName!",
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
