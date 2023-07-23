import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;

import 'Pict.dart';
import 'Quote.dart';

class NetworkHelp{

  List<String>? quoteTag=["beach"];
  String quoteUrl ="https://api.quotable.io/random";
  late String pictUrl ;
  Quote myRandQoute=Quote(content: "NoContent" ,author: "NoAuthor",tags: ["nothing"]);
  Pict myRandPicture=Pict();


  Future<Quote> getQuoteData()async{
    http.Response response =await http.get(Uri.parse(quoteUrl));

    if(response.statusCode==200){
       myRandQoute =  Quote.fromJson(jsonDecode(response.body) );
      print(myRandQoute.content);
      print(myRandQoute.author);
      print(myRandQoute.tags);
      // quoteTag=myRandQoute.tags;
      return myRandQoute;

    }
    return Future.error("Something wrong with quote api");

  }

  Future<List<dynamic>> getData()async{
    await getQuoteData();
    pictUrl ="https://random.imagecdn.app/v1/image?&category=${quoteTag}&format=json";
    http.Response response =await http.get(Uri.parse(pictUrl));

    if(response.statusCode==200){
      myRandPicture=  Pict.fromJson(jsonDecode(response.body) );
      print("myRaandPictUrl : ${myRandPicture.url}");
      print("pictLic :${myRandPicture.license}");
      print("PictureUrl (API): ${pictUrl}");
      return [myRandQoute,myRandPicture];

    }
    return Future.error("Something wrong with picture api");

  }
}