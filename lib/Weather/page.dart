import 'package:day14/Animation/FadeAnimation.dart';
import 'package:day14/Weather/utils/weather.dart';
import 'package:day14/pageUser/LoginUser.dart';
import 'package:day14/pageUser/home.dart';
import 'package:day14/pageUser/screens/launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/Weather/constants.dart';
import '/Weather/utils/weather.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({@required this.weatherData});

  final WeatherData weatherData;

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomePage2> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FadeAnimation(
          1,
          Text(
            ' $temperature°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              letterSpacing: -5,
            ),
          ),
        ),
      ),
    );
  }
}
