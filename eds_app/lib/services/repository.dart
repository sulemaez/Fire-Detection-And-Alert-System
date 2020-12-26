import 'package:dio/dio.dart';
import 'package:edsapp/models/camera.dart';
import 'package:edsapp/models/county.dart';
import 'package:edsapp/models/location.dart';
import 'http.dart';

class Repository{

  static getAll() async{
     await getCameras();
     await getLocations();
     await getCounties();
  }

  static Future getCameras() async{
    if(!await checkNet())return null;
    Response response = await Http.doGet("${Http.apiUrl}cameras");

    if (response.statusCode == 200){
      response.data["_embedded"]["cameras"].forEach((cam){
        Camera camera = Camera.fromJson(cam);
        Camera.list.add(camera);
      });
      return;
    }else{
      print(response.statusCode);
      return;
    }
  }

  static Future getLocations() async{
    if(!await checkNet())return null;
    Response response = await Http.doGet("${Http.apiUrl}locations");

    if (response.statusCode == 200){
      response.data["_embedded"]["locations"].forEach((loc){
        Location location = Location.fromJson(loc);
        Location.list.add(location);
      });
      return;
    }else{
      print(response.statusCode);
      return;
    }
  }

  static Future getCounties() async{
    if(!await checkNet())return null;
    Response response = await Http.doGet("${Http.apiUrl}counties");

    if (response.statusCode == 200){
      response.data["_embedded"]["counties"].forEach((loc){
        County county= County.fromJson(loc);
        County.list.add(county);
      });
      return;
    }else{
      print(response.statusCode);
      return;
    }
  }



}