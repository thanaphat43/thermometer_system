import 'dart:convert';

import 'package:day14/Weather/constants.dart';
import 'package:day14/Weather/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../credentials.dart';
import '../utils/location.dart';

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  Colors weatherColors;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
}

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  double currentTemperature;
  int currentCondition;

  Future<void> getCurrentTemperature() async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=2f8743cc440ef62aa5b2a8d4d7ec655a&units=metric'));
    // 'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=2f8743cc440ef62aa5b2a8d4d7ec655a&units=metric');
    // 'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=2f8743cc440ef62aa5b2a8d4d7ec655a&units=metric');
    // api.openweathermap.org/data/2.5/weather?lat=14.2092525&lon=100.025635&appid=2f8743cc440ef62aa5b2a8d4d7ec655a&units=metric

    print(response);
    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: AssetImage('assets/cloud.png'),
      );
    } else {
      var now = new DateTime.now();

      if (now.hour >= 15) {
        return WeatherDisplayData(
          weatherImage: AssetImage('assets/night.png'),
          weatherIcon: kMoonIcon,
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: kSunIcon,
          weatherImage: AssetImage('assets/sunny.png'),
        );
      }
    }
  }
}
