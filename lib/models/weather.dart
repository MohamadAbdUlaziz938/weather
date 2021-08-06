import 'file:///C:/Users/PC/AndroidStudioProjects/weather/lib/media/strings.dart';

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere, // dust, ash, fog, sand etc.
  mist,
  fog,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}

class Weather {
  final WeatherCondition condition;
  final String description;
  final double temp;
  final double feelLikeTemp;
  final DateTime sunrise;
  final DateTime sunset;
  final double tempMin;
  final double tempMax;
  final double tempNight;
  final double tempEvening;
  final double tempMorning;
  final double humidity;
  final double windSpeed;
  final int cloudiness;
  final DateTime date;

  Weather(
      {this.condition,
        this.description,
        this.temp,
        this.feelLikeTemp,
        this.cloudiness,
        this.date,
        this.sunrise,
        this.sunset,
        this.tempMax,
        this.tempEvening,
        this.tempMin,
        this.tempMorning,
        this.tempNight,
        this.humidity,
        this.windSpeed,

      });

  static Weather fromDailyJson(dynamic daily) {
    var cloudiness = daily['clouds'];
    var weather = daily['weather'][0];

    return Weather(
        condition: mapStringToWeatherCondition(weather['main'], cloudiness),
        //description: Strings.toTitleCase(weather['description']),
        description: weather['description'],
        cloudiness: cloudiness,
        temp: daily['temp']['day'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000,
            isUtc: true),
        feelLikeTemp: daily['feels_like']['day'].toDouble(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(daily['sunrise'] * 1000,),
      // sunset: DateTime.fromMillisecondsSinceEpoch(daily['sunset'] * 1000,
      //     isUtc: true),
      sunset: DateTime.fromMillisecondsSinceEpoch(daily['sunset'] * 1000,),
      tempMax: daily['temp']['max'].toDouble(),
      tempMin: daily['temp']['min'].toDouble(),
      tempMorning: daily['temp']['morn'].toDouble(),
      tempEvening: daily['temp']['eve'].toDouble(),
      tempNight: daily['temp']['night'].toDouble(),
      humidity: daily['humidity'].toDouble(),
      windSpeed:daily['wind_speed'].toDouble(),

    );
  }

  static WeatherCondition mapStringToWeatherCondition(
      String input, int cloudiness) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = (cloudiness >= 85)
            ? WeatherCondition.heavyCloud
            : WeatherCondition.lightCloud;
        break;
      case 'Mist':
        condition = WeatherCondition.mist;
        break;
      case 'fog':
        condition = WeatherCondition.fog;
        break;
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        condition = WeatherCondition.atmosphere;
        break;
      default:
        condition = WeatherCondition.unknown;
    }

    return condition;
  }
}