import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'gradient_container.dart';

GradientContainer buildGradientContainer(
    WeatherCondition condition, bool isDayTime, Widget child) {
  GradientContainer container;
  if (isDayTime != null && !isDayTime)
    container = GradientContainer(color: Colors.blueGrey, child: child);
  else {
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        container = GradientContainer(color: Colors.yellow, child: child);
        break;
      case WeatherCondition.fog:
      case WeatherCondition.atmosphere:
      case WeatherCondition.rain:
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
      case WeatherCondition.heavyCloud:
        container = GradientContainer(color: Colors.indigo, child: child);
        break;
      case WeatherCondition.snow:
        container = GradientContainer(color: Colors.lightBlue, child: child);
        break;
      case WeatherCondition.thunderstorm:
        container = GradientContainer(color: Colors.deepPurple, child: child);
        break;
      default:
        container = GradientContainer(color: Colors.lightBlue, child: child);
    }
  }

  return container;
}