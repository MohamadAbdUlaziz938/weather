import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/utils/container.dart';
import 'file:///C:/Users/PC/AndroidStudioProjects/weather/lib/media/strings.dart';
import 'file:///C:/Users/PC/AndroidStudioProjects/weather/lib/media/temperature_convert.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:weather/viewModels/show-more-details.dart';

enum showCondition { tempreture, sunRiseSet,more }

class WeatherDetails extends StatelessWidget {
  final Weather weather;

  WeatherDetails({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);
  Widget sunRiseSetView(BuildContext context) {
    return Column(
      key: ValueKey(4),
      children: [
        container(context,
            feature: Strings.sunRise,

            details:
            DateFormat('jm').format(this.weather.sunrise).toString(),

            padding: 10,
            marginLeft: 20,
            marginRight: 20),
        Divider(),
        container(context,
            feature: Strings.sunSet,
            details: DateFormat('jm').format(this.weather.sunset).toString(),
            padding: 10,
            marginLeft: 20,
            marginRight: 20),
      ],
    );
  }

  Widget tempretureDetails(BuildContext context) {
    return Column(
      key: ValueKey(1),
      children: [
        container(context,
            feature: Strings.TempMax,
            details:
                " ${Strings.formatTemperature(TemperatureConvert.kelvinToCelsius(this.weather.tempMax))}°ᶜ",
            padding: 10,
            marginLeft: 20,
            marginRight: 20),
        Divider(),
        container(context,
            feature: Strings.TempMin,
            details:
                "${Strings.formatTemperature(TemperatureConvert.kelvinToCelsius(this.weather.tempMin))}°ᶜ",
            padding: 10,
            marginLeft: 20,
            marginRight: 20),
        Divider(),
        container(context,
            feature: Strings.TemMorning,
            details:
                "${Strings.formatTemperature(TemperatureConvert.kelvinToCelsius(this.weather.tempMorning))}°ᶜ",
            padding: 15,
            marginLeft: 20,
            marginRight: 20),
        Divider(),
        container(context,
            feature: Strings.TempEvening,
            details:
                "${Strings.formatTemperature(TemperatureConvert.kelvinToCelsius(this.weather.tempEvening))}°ᶜ",
            padding: 10,
            marginLeft: 20,
            marginRight: 20),
        Divider(),
        container(context,
            feature: Strings.TempNight,
            details:
                "${Strings.formatTemperature(TemperatureConvert.kelvinToCelsius(this.weather.tempNight))}°ᶜ",
            padding: 10,
            marginLeft: 20,
            marginRight: 20),
      ],
    );
  }
Widget moreDetails(BuildContext context){
    return Column(
      key: ValueKey(6),
      children: [
        container(context,
            feature: Strings.Humidity,
            details: "${Strings.formatTemperature(this.weather.humidity)}%",
            padding: 10,
            marginRight: 20,
            marginLeft: 20),
        Divider(),
        container(context,
            feature: Strings.WindSpeed,
            details: "${Strings.formatTemperature(this.weather.windSpeed)}Km/h",
            padding: 10,
            marginRight: 20,
            marginLeft: 20),
      ],
    );
}
  Widget animatedIcon(
      ShowMoreDetails showMoreDetials, showCondition condition) {
    return AnimatedIconButton(
      size: 25,
      onPressed: () {},
      duration: const Duration(milliseconds: 500),
      splashColor: Colors.transparent,
      icons: <AnimatedIconItem>[
        AnimatedIconItem(
          icon: Icon(Icons.expand_less_rounded, color: Colors.black87),
          onPressed: () {
            condition == showCondition.tempreture
                ? showMoreDetials.updateshowMoreDetailsTempreture(
                    !showMoreDetials.showMoreDetailsTempreture)
                : condition == showCondition.sunRiseSet? showMoreDetials.updateshowMoreDetailsSunRiseSet(
                !showMoreDetials.showMoreDetailsSunRiseSet):showMoreDetials.updateshowMoreDetailsHami_(
                !showMoreDetials.showMoreDetailsHami_);
          },
        ),
        AnimatedIconItem(
          icon: Icon(Icons.expand_more_outlined, color: Colors.black87),
          onPressed: () {
            condition == showCondition.tempreture
                ? showMoreDetials.updateshowMoreDetailsTempreture(
                    !showMoreDetials.showMoreDetailsTempreture)
                :condition == showCondition.sunRiseSet? showMoreDetials.updateshowMoreDetailsSunRiseSet(
                    !showMoreDetials.showMoreDetailsSunRiseSet):showMoreDetials.updateshowMoreDetailsHami_(
                !showMoreDetials.showMoreDetailsHami_);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final showMoreDetials = Provider.of<ShowMoreDetails>(context);
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                Strings.sunRiseSet,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            animatedIcon(showMoreDetials, showCondition.sunRiseSet),
          ],
        ),

        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              child: child,
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: 2,
            );
          },
          child: showMoreDetials.showMoreDetailsSunRiseSet
              ? sunRiseSetView(context)
              : Container(
                  key: ValueKey(3),
                ),
        ),
        Divider(
          thickness: 2,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                Strings.Tempreture,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            animatedIcon(showMoreDetials, showCondition.tempreture),
          ],
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              child: child,
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: 2,
            );
          },
          child: showMoreDetials.showMoreDetailsTempreture
              ? tempretureDetails(context)
              : Container(
                  key: ValueKey(2),
                ),
        ),
        Divider(
          thickness: 2,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                Strings.More,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            animatedIcon(showMoreDetials, showCondition.more),
          ],
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              child: child,
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: 2,
            );
          },
          child: showMoreDetials.showMoreDetailsHami_
              ? moreDetails(context)
              : Container(
            key: ValueKey(5),
          ),
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
