import 'dart:async';

import 'package:dio/dio.dart';
import 'package:edsapp/services/auth.dart';
import 'package:edsapp/services/http.dart';

import 'package:location/location.dart' as loc0;

class LocationService{

  static sendLocation()async{
    send();
    Timer.periodic(new Duration(seconds: 20), (timer) async{
       send();
    });
  }

  static void send() async{
    loc0.LocationData location = await loc0.Location.instance.getLocation();
    print(location.latitude);
    print(location.longitude);

    try{
      Response response = await Http.doPost(data : "${location.latitude},${location.longitude}" ,url: "${Http.baseUrl}location?username=${Auth.user.username}");

    }catch(e){}
  }
}