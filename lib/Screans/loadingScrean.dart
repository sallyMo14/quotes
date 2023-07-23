import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quates/Screans/HomeScrean.dart';
import 'package:quates/Services/Quote.dart';
import 'package:quates/Services/networking.dart';

import '../Services/Pict.dart';

class LoadingScrean extends StatefulWidget {
  const LoadingScrean({super.key});

  @override
  State<LoadingScrean> createState() => _LoadingScreanState();
}

class _LoadingScreanState extends State<LoadingScrean> {
  NetworkHelp helper=NetworkHelp();
  late Quote initialQuote;
  late Pict initialPict;
  @override
  void initState() {

    getInitialData();


    super.initState();
  }
  // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return LocationScreen(
  //         weatherData: weatherInfo,
  //       );
  void getInitialData() async{
    List initialResult=  await helper.getData();
    initialQuote=initialResult[0];
    initialPict=initialResult[1];
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return HomeScrean();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
