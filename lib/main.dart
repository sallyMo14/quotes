import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quates/Screans/HomeScrean.dart';
import 'package:quates/Services/Quote.dart';
import 'package:quates/Services/networking.dart';

import 'Screans/loadingScrean.dart';
import 'Services/Pict.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScrean();
  }
}


// late int temp;
// late String cityName;
// late String icon;
// late String description;
// @override
// void initState() {
//   temp = widget.weatherData.temp.toInt();
//   cityName = widget.weatherData.name;
//   icon = widget.weatherData.getWeatherIcon();
//   description = widget.weatherData.getMessage();
//   super.initState();
// }
