import 'weather_model.dart'; 
import 'weather_api_service.dart'; 
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final String cityName;

  WeatherDetailsScreen({required this.cityName});

  @override
  _WeatherDetailsScreenState createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  final WeatherApiService apiService = WeatherApiService();
  Weather? weather;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      final data = await apiService.fetchWeatherData(widget.cityName);
      setState(() {
        weather = Weather.fromJson(data);
      });
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  WeatherType getWeatherType() {
    if (weather == null) {
      return WeatherType.Default;
    }
    
    final temperature = weather!.temperature;
    final humidity = weather!.humidity;

    if (temperature > 25.0 && humidity > 60.0) {
      return WeatherType.Sunny;
    } else if (temperature < 10.0 && humidity < 50.0) {
      return WeatherType.Snowy;
    } else {
      return WeatherType.Rainy;
    }
  }

  String getAnimationAsset() {
    switch (getWeatherType()) {
      case WeatherType.Sunny:
        return 'assets/sun_animation.json'; 
      case WeatherType.Snowy:
        return 'assets/snow_animation.json';
      case WeatherType.Rainy:
        return 'assets/rain_animation.json';
      default:
        return 'assets/animation1.json'; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              getAnimationAsset(),
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            Text(
              'Weather Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            if (weather != null)
              Column(
                children: [
                  Text('City: ${weather!.cityName}'),
                  Text('Temperature: ${weather!.temperature}°C'),
                  Text('Humidity: ${weather!.humidity}%'),
                  Text('Wind Speed: ${weather!.windSpeed} km/h'),
                ],
              )
            else
              Text('Fetching weather data...'),
          ],
        ),
      ),
    );
  }
}

enum WeatherType {
  Sunny,
  Snowy,
  Rainy,
  Default,
}
