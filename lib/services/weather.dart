import 'package:WeatherApp/services/location.dart';
import 'package:WeatherApp/services/networking.dart';
import 'package:WeatherApp/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$kWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp > 15) {
      return 'Not bad if you have 🧥 on';
    } else if (temp > 10) {
      return 'Time for  🧤🧥';
    } else if (temp <= 9) {
      return 'Time for  🧣🧤🧥';
    }
  }
}

// else if (temp < 10) {
//   return 'You\'ll need 🧣 and 🧤';
// } else {
//   return 'Bring a 🧥 just in case';
// }
