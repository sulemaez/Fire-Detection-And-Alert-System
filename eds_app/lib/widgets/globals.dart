import 'package:edsapp/config/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildLoader(context){
  return Container(
    width: SizeConfig.blockSizeHorizontal * 100,
    height: SizeConfig.blockSizeVertical * 100,
    color: Colors.grey.withOpacity(0.1),
    child: Center(
      child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
    ),
  );
}