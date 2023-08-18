
class Weather {
  final String cityName;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final String weatherDescription;
  final String iconUrl;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherDescription,
    required this.iconUrl,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final condition = current['condition'];

    return Weather(
      cityName: json['location']['name'],
    temperature: (current['temp_c'] as num).toDouble(),
    humidity: (current['humidity'] as num).toDouble(),
    windSpeed: (current['wind_kph'] as num).toDouble(),
    weatherDescription: condition['text'],
    iconUrl: condition['icon'],
    );
  }
}

