import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  double latitude;
  double longitude;
  NetworkHelper({required this.url, this.latitude = 0.0, this.longitude = 0.0});

  Future getData() async {
    try {
      print('Fetching data from URL: $url');
      http.Response response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        String data = response.body;
        print('Received successful response with status code: ${response.statusCode}');
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        print('Error response with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        
        // Return a JSON-like map with error information instead of just the status code
        return {
          'error': true,
          'statusCode': response.statusCode,
          'message': 'Failed to load weather data (Status: ${response.statusCode})',
          'body': response.body
        };
      }
    } catch (e) {
      print('Exception in getData: $e');
      return {
        'error': true,
        'message': 'Network error: $e'
      };
    }
  }
}
