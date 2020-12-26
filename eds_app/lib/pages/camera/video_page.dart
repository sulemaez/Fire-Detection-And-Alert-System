
import 'dart:convert';
import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/services/video_stream.dart';
import 'package:edsapp/widgets/globals.dart';
import 'package:flutter/material.dart';


class VideoPage extends StatefulWidget {

  Function setPageState;
  var name;

  VideoPage({this.setPageState,this.name });

  @override
  VideoPageState createState(){
   VideoPageState videoPageState =  VideoPageState();
   setPageState(videoPageState);
   return videoPageState;
  }
}

class VideoPageState extends State<VideoPage> {
  String imageUrl;
  Image image;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("MEMEBR");
    VideoStream.joinVideo((img){
      var data = base64.decode(img);

      setState(() {
        image = Image.memory(data);
       });
    },widget.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    VideoStream.leaveVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      child: Center(
        child: image ?? buildLoader(context),
      ),
    );
  }
}