import 'dart:convert';

import 'package:WeatherApp/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:unit_conversion/unit_conversion.dart';
import '../services/location.dart';

class NetworkHelper {
  double latitude;
  double longitude;
  final String url;
  NetworkHelper({this.url});

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      // print(response.statusCode);
      return response.statusCode;
    }
  }
}
