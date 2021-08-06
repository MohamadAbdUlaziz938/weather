import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather.dart';
import 'file:///C:/Users/PC/AndroidStudioProjects/weather/lib/media/temperature_convert.dart';
import 'file:///C:/Users/PC/AndroidStudioProjects/weather/lib/weather/screens/upcoming_day.dart';
import 'package:weather/media/date.dart';
class DailySummaryView extends StatelessWidget {
  final Weather weather;

  DailySummaryView({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
    toBeginningOfSentenceCase(DateFormat('MMMEd').format(this.weather.date));
    return Padding(
        padding: EdgeInsets.only(left: 25,right: 25),

        child:
        Column(
          children: [
            InkWell(
              onTap:
            (){Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return UpComingDay(weather: this.weather,);
          }));},
              child:
              Row(
              children: [
                Expanded(
                  flex: 2,
                  child:
                Text(this.weather.date.isTomorrow()?"Tomorrow,${DateFormat('MMMd').format(this.weather.date)}":dayOfWeek,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                ),
                Expanded(child:
                Text(
                    "${TemperatureConvert.kelvinToCelsius(this.weather.temp).round().toString()}°ᶜ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                ),
                Expanded(child:
                Icon(Icons.arrow_forward_ios_outlined,size: 25,),
                ),


              ],
              ),
            ),
            Divider(),
          ],
        )
    //     Row(
    //       children: [
    //         InkWell(
    //           onTap: (){Navigator.of(context)
    //               .push(MaterialPageRoute(builder: (context) {
    //             return UpComingDay(weather: this.weather,);
    //           }));},
    //           child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //             Text(dayOfWeek ?? '',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w300)),
    //             Text(
    //                 "${TemperatureConvert.kelvinToCelsius(this.weather.temp).round().toString()}°",
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w500)),
    //           ]),
    //         ),
    //         Padding(
    //             padding: EdgeInsets.only(left: 5),
    //             child: Container(
    //                 alignment: Alignment.center,
    //                 child: _mapWeatherConditionToImage(this.weather.condition)))
    //       ],
    //     )
    );
  }
//// add icon to upcoming days in home screen.
  Widget _mapWeatherConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        //image = Image.asset('assets/images/thunder_storm_small.png');
        break;
      case WeatherCondition.heavyCloud:
        //image = Image.asset('assets/images/cloudy_small.png');
        //image = Image.asset('assets/images/images.png');
        break;
      case WeatherCondition.lightCloud:
        //image = Image.asset('assets/images/light_cloud_small.png');
        //image = Image.asset('assets/images/images.png');
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        //image = Image.asset('assets/images/drizzle_small.png');
      //image = Image.asset('assets/images/images.png');
        break;
      case WeatherCondition.clear:
        //image = Image.asset('assets/images/clear_small.png');
        //image = Image.asset('assets/images/images.png');
        break;
      case WeatherCondition.fog:
        //image = Image.asset('assets/images/fog_small.png');
        //image = Image.asset('assets/images/images.png');
        break;
      case WeatherCondition.snow:
        //image = Image.asset('assets/images/snow_small.png');
        //image = Image.asset('assets/images/images.png');
        break;
      case WeatherCondition.rain:
        //image = Image.asset('assets/images/rain_small.png');
        //image = Image.asset('assets/images/images.png');
        break;
      case WeatherCondition.atmosphere:
        //image = Image.asset('assets/images/atmosphere_small.png');
        //image = Image.asset('assets/images/images.png');
        break;

      default:
        //image = Image.asset('assets/images/light_cloud_small.png');
        //image = Image.asset('assets/images/images.png');
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
