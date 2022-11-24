import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{

  late String location; // location name for the UI
  late String time; // the time in that location
  late String flag; // url to asset flag
  late String  url; // location url for API end point
  late bool isDaytime; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

    Future<void> getTime() async{

      try{
        //make the request
        Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
        Map data = jsonDecode(response.body);

        //get properties from json
        String datetime = data['datetime'];
        String offset = data['utc_offset'].substring(1,3);

        //create DateTime object
        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset)));

        // set the time property
        isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
        time = DateFormat.jm().format(now);

      }
      catch(e){
        print('caught an error: $e');
        time='Could not get a time data';

      }



  }
}

