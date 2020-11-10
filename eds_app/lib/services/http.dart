


import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth.dart';

class Http{
  static String baseUrl = "https://805ba1dc0e3d.ngrok.io/";
  static String apiUrl = "${baseUrl}api/";
  static String socketUrl = "http://192.168.43.227:5000";

  static Dio _dio = Dio();

  static Future<Response> doPost({data,url,}) async{

    Response response = await _dio.post(url, data: data ,options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) { return status < 500; },
        headers: {
          'Content-type':'application/json',
          'Accept': 'application/json',
          'Authorization' : Auth.user == null ? '': "Bearer ${Auth.user.token}"
        }
    ));
    if(response.statusCode == 401){
//      navigatorKey.currentState..pushAndRemoveUntil(
//          MaterialPageRoute(
//            builder: (context) => LoginRegister(),
//          ),
//              (Route<dynamic> r) => false
//      );
//      Auth.logout();
    }

    return response;
  }

  static Future<Response> doGet(url) async{
    Response response = await _dio.get(url,options: Options(
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) { return status < 500; },
        headers: {
          'Content-type':'application/json',
          'Accept': 'application/json',
          'Authorization' : Auth.user == null ? '': "Bearer ${Auth.user.token}"
        }
    ));



//          MaterialPageRoute(
//            builder: (context) => LoginRegister(),
//          ),
//              (Route<dynamic> r) => false
//      );
//      Auth.logout();
    return response;
  }

  static doPut(data,url) async{
    Response response = await _dio.put(url, data: data,options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) { return status < 500; },
        headers: {
          'Content-type':'application/json',
          'Accept': 'application/json',
          'Authorization' : Auth.user == null ? '': "Bearer ${Auth.user.token}"
        }
    ));


    if(response.statusCode == 401){
//      navigatorKey.currentState..pushAndRemoveUntil(
//          MaterialPageRoute(
//            builder: (context) => LoginRegister(),
//          ),
//              (Route<dynamic> r) => false
//      );
//      Auth.logout();
    }

    return response;
  }

}



//checks the internet
Future<bool> checkNet() async{
  try{
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  }catch(e){
    print("ERROR $e");
  }

  Fluttertoast.showToast(
      msg: "There is not internet access !",
      textColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 67, 37,111)
  );
  return false;
}