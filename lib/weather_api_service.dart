import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApiService {
  static const String apiKey = '386edcca748041c1865131846231508';
  static const String baseUrl = 'https://api.weatherapi.com/v1';

  Future<Map<String, dynamic>> fetchWeatherData(String cityName) async {
     final response = await http.get(Uri.parse('$baseUrl/current.json?key=$apiKey&q=$cityName'));


print('Response Status Code: ${response.statusCode}');
print('Response Body: ${response.body}');


    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
