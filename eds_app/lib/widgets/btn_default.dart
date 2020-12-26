
import 'package:edsapp/config/size_config.dart';
import 'package:flutter/material.dart';


class DefaultButton extends StatelessWidget {

  String text;
  bool light = false;
  Function callback;

  DefaultButton({this.text,this.light,this.callback});

  @override
  Widget build(BuildContext context) {

    return   MaterialButton(
        minWidth: SizeConfig.blockSizeHorizontal * 60,
        height: SizeConfig.blockSizeVertical * 6.5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 10)),
        color: Theme.of(context).accentColor,
        child: Text(
          text,
          style: TextStyle(
              color:  Colors.white , fontSize: SizeConfig.blockSizeHorizontal * 4.5,fontWeight: FontWeight.bold
          ),
        ),
        onPressed: () => callback()

    );
  }
}
