import 'dart:io';
import 'dart:typed_data';

import 'dart:async';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';


import '../Services/Pict.dart';
import '../Services/Quote.dart';
import '../Services/networking.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  late Uint8List _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  NetworkHelp helper = NetworkHelp();

  Pict myImage = Pict(
      url:
          "https://images.unsplash.com/photo-1689085383445-3872d2b0d7be?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=1080&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY5MDExNTY0Nw&ixlib=rb-4.0.3&q=80&w=1920",
      provider:
          "https://images.unsplash.com/photo-1689085383445-3872d2b0d7be?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=1080&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY5MDExNTY0Nw&ixlib=rb-4.0.3&q=80&w=1920",
      license: "Sally",
      terms: "termss");
    Quote myQuote = Quote(
      content:
          "The way you see people is the way you treat them, and the way you treat them is what they become.",
      author: "Johann Wolfgang von Goethe",
      tags: ["nothing"]);

  Future saveAndShare(Uint8List bytes) async{
    final directory =await getApplicationDocumentsDirectory();
    final image =File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  Future<void> refreshScrean() async {
    List result = await helper.getData();
    myQuote = result[0]; //await helper.getQuoteData();
    myImage = result[1];
  }

  @override
  void initState() {
    refreshScrean();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      await refreshScrean();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.change_circle_outlined,
                      color: Colors.tealAccent,
                    ),
                  ),
                  Stack(


                    children: [
                      Container(
                        width: 150,
                        height: 150,

                        child: Image(
                          color: Colors.grey.shade800,
                          width: 40,
                          height: 40,
                          image: AssetImage("assets/qoutaion.png"),
                          fit: BoxFit.fill,
                        ),
                        // child:SvgPicture.asset(
                        //     "SVGRepo_iconCarrier.png",
                        //     colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                        //     semanticsLabel: 'A red up arrow'
                        // ),
                      ),
                      Column(

                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 80, right: 20),
                            width: double.infinity,
                            child: Text(
                              myQuote.content!,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 4,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            // padding: EdgeInsets.only(top: 20),
                            color: Colors.greenAccent,
                            child: Text(
                              myQuote.author!,
                              style: TextStyle(fontSize: 18, letterSpacing: 2),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.greenAccent,
                    onPressed: ()async{
                     final image = await screenshotController.capture();
                     saveAndShare(image!);

                    },
                    label: const Text('Take screenshot',style: TextStyle(color: Colors.black),),
                    icon: const Icon(Icons.share_rounded,color: Colors.black,),
                  ),

                  // Container(
                  //   width: 180,
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Colors.tealAccent),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text("Take Screan shoot"),
                  //       Icon(Icons.share),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    myImage.url!), //ImageFilter.erode(radiusX: 0.5,radiusY: 0.2),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.7), BlendMode.dstATop),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
