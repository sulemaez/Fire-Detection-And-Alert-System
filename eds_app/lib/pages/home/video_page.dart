
import 'dart:convert';

import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/services/vide_stream.dart';
import 'package:edsapp/widgets/globals.dart';
import 'package:flutter/material.dart';


class VideoPage extends StatefulWidget {
  Function setPageState;

  VideoPage({setPageState }):this.setPageState = setPageState;

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  String imageUrl;
  Image image;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VideoStream.initialize((img){
      var data = base64.decode(img);


      setState(() {
        image = Image.memory(data);
       });
    });
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