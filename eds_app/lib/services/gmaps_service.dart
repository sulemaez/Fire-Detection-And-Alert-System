import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'http.dart';
const apiKey = "AIzaSyCz4GYEDrnU7yijbztMqZTINQS_4CA3QjU";

class GoogleMapsServices{
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
    print("https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey");
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    Response response = await Http.doGet(url);
    Map values = response.data;
    print("====================>>>>>>>>$values");

    return values["routes"][0]["overview_polyline"]["points"];
  }
}