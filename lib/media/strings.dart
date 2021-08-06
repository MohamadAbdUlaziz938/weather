extension Strings on String {
  static String toTitleCase(String city) {
    return "${city.toUpperCase()}";
  }
  static String formatTemperature(double t) {
    var temp = (t == null ? '' : t.round().toString());
    return temp;
  }
  static const sunRiseSet="Sunrise and sunset";
  static const sunRise="sun-rise";
  static const sunSet="sun-set";
  static const Tempreture="Tempreture";
  static const TempMax="TempMax";
  static const TempMin="TempMin";
  static const TemMorning="TemMorning";
  static const TempEvening="TempEvening";
  static const TempNight="TempNight";
  static const Humidity="Humidity";
  static const WindSpeed="Wind-Speed";
  static const backEndError='Ooops...something went wrong';
  static const More='More';
}
