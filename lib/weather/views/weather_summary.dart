import 'package:flutter/material.dart';
import 'package:weather/config/size-config.dart';
import 'package:weather/media/images.dart';
import 'package:weather/media/strings.dart';
import 'package:weather/models/weather.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;

  WeatherSummary(
      {Key key,
      @required this.condition,
      @required this.temp,
      @required this.feelsLike,
      @required this.isdayTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.hightMultiplier_;
    double width = SizeConfig.widthMultiplier_;
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Text(
              '${Strings.formatTemperature(this.temp)}°ᶜ',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${Strings.formatTemperature(this.feelsLike)}°ᶜ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Container(
          width: 100,
          height: 100,
          child: _mapWeatherConditionToImage(this.condition, this.isdayTime),
        )
      ]),
    );
  }



  Widget _mapWeatherConditionToImage(
      WeatherCondition condition, bool isDayTime) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset(
          Images.thunderStorm,
          color: Colors.white,
        );
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset(Images.heavyCloud);
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? image = Image.asset(Images.lightCloud)
            : image = Image.asset(Images.lightCloudNight);
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset(Images.rain);
        break;
      case WeatherCondition.clear:
        isDayTime
            ? image = Image.asset(
                Images.clear,
              )
            : image = Image.asset(
                Images.clearNight,
                color: Colors.white,
              );
        break;
      case WeatherCondition.fog:
        image = Image.asset(Images.fog);
        break;
      case WeatherCondition.snow:
        image = Image.asset(
          Images.snow,
          color: Colors.white,
        );
        break;
      case WeatherCondition.rain:
        image = Image.asset(
          Images.rain,
          color: Colors.white,
        );
        break;
      case WeatherCondition.atmosphere:
        image = Image.asset(Images.fog);
        break;

      default:
        image = Image.asset(Images.unKnown);
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
