
import 'dart:convert';
import 'dart:ui';
import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/models/user.dart';
import 'package:edsapp/pages/home_base.dart';
import 'package:edsapp/services/auth.dart';
import 'package:edsapp/services/repository.dart';
import 'package:edsapp/widgets/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget{
  LoginPage();

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  GlobalKey<FormState> _formKey = new GlobalKey();
  _LoginData _loginData = new _LoginData();
  var _errors = {
     "usernameError" : "",
     "passwordError" : ""
  };

  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    checkLogin(context);
  }

  @override
  Widget build(BuildContext contextMain) {
    SizeConfig().init(contextMain);
    return Scaffold(
       body: Container(
         padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
         color: Colors.white,
         child: Stack(
           children: <Widget>[
             ListView(
               shrinkWrap: true,
               children: <Widget>[
                 Column(
                     children: <Widget>[
                       Container(height: SizeConfig.blockSizeVertical * 10,),
                       Text("EDAS",style: TextStyle( color: Theme.of(context).accentColor , fontSize: SizeConfig.blockSizeVertical * 5)),
                       Container(height: SizeConfig.blockSizeVertical * 10,),
                       Card(
                           color: Color.fromARGB(255,244, 244, 244),
                           elevation: 0.5,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Container(
                             child: Padding(
                               padding: EdgeInsets.only(
                                 top: SizeConfig.blockSizeVertical * 3,
                                     left: SizeConfig.blockSizeHorizontal * 4,
                                     bottom: SizeConfig.blockSizeVertical * 8,
                                     right: SizeConfig.blockSizeHorizontal * 4
                                 ),
                                 child:  Form(
                                   key: _formKey,
                                   child: Column(
                                     children: <Widget>[
                                       Row(
                                         children: <Widget>[
                                           Icon(Icons.person,color: Colors.orangeAccent,size: SizeConfig.blockSizeHorizontal * 4,),
                                           Padding( padding: EdgeInsets.only(left: 5),),
                                           Text("Email",style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Proxima Nova',color: Theme.of(context).accentColor , fontSize: SizeConfig.blockSizeHorizontal * 4),),
                                         ],
                                       ),

                                       Container(
                                         width: SizeConfig.blockSizeHorizontal * 80,

                                         child: TextFormField(
                                               decoration:  InputDecoration(
                                               errorText: _errors["usernameError"] == "" ? null : _errors["usernameError"] ,
                                               errorStyle: TextStyle(
                                                   fontSize: SizeConfig.blockSizeHorizontal * 2.8
                                               ),

                                               errorMaxLines: 2,
                                               enabledBorder: UnderlineInputBorder(
                                                   borderSide: BorderSide(color: Colors.grey)
                                               ),
                                               focusedBorder: UnderlineInputBorder(
                                                   borderSide: BorderSide(color: Colors.grey)
                                               ),
//                                               hintText:"0723434512",
                                               fillColor: Colors.white,
                                               contentPadding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4.5,top: SizeConfig.blockSizeVertical * 1.5,bottom: SizeConfig.blockSizeVertical * 1.5)
                                           ),
                                           validator: (String val){
                                             if(val != "")return null;
                                             return "Please enter username number or username";
                                           },
                                           onSaved: (String username) => {
                                             _loginData.username = username
                                           },
                                         ),
                                       ),
                                       Container(height: SizeConfig.blockSizeVertical * 2,),
                                       Row(
                                         children: <Widget>[
                                           Icon(Icons.lock,color: Colors.orangeAccent,size: SizeConfig.blockSizeHorizontal * 4,),
                                           Padding( padding: EdgeInsets.only(left: 5),),
                                           Text("Password",style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Proxima Nova',color: Theme.of(context).accentColor , fontSize: SizeConfig.blockSizeHorizontal * 4),),
                                         ],
                                       ),

                                       Container(
                                         width: SizeConfig.blockSizeHorizontal * 80,
                                         child: TextFormField(
                                           obscureText: true,
                                           decoration:  InputDecoration(
                                               errorText: _errors["passwordError"] == "" ? null : _errors["passwordError"] ,
                                               errorStyle: TextStyle(
                                                   fontSize: SizeConfig.blockSizeHorizontal * 2.8
                                               ),
                                               errorMaxLines: 2,
                                               enabledBorder: UnderlineInputBorder(
                                                   borderSide: BorderSide(color: Colors.grey)
                                               ),
                                               focusedBorder: UnderlineInputBorder(
                                                   borderSide: BorderSide(color: Colors.grey)
                                               ),

                                               fillColor: Colors.white,
                                               contentPadding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4.5,top: SizeConfig.blockSizeVertical * 1.5,bottom: SizeConfig.blockSizeVertical * 1.5)
                                           ),
                                           validator: (String val){
                                             if(val != "")return null;
                                             return "Please enter password";
                                           },
                                           onSaved: (String password) => {
                                             _loginData.password= password
                                           },
                                         ),
                                       ),
                                       Container(height: SizeConfig.blockSizeVertical * 3,),
                                       MaterialButton(
                                         minWidth: SizeConfig.blockSizeHorizontal * 50,
                                         height: SizeConfig.blockSizeVertical * 6,
                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                         color: Theme.of(context).accentColor,
                                         child: Text(
                                           "LOGIN",
                                           style: TextStyle(fontFamily: 'Proxima Nova',color: Colors.white,fontSize: SizeConfig.blockSizeHorizontal * 4.5),
                                         ),
                                         onPressed: () async{
                                           setState(() {
                                             isLoading = true;
                                           });
                                           if(_formKey.currentState.validate()){

                                              _formKey.currentState.save();
                                               var res = await  Auth.signIn(_loginData.username, _loginData.password);

                                               if(res){

                                                   SharedPreferences.getInstance().then((value)async{
                                                      value.setString("user", jsonEncode(Auth.user));
                                                      await Repository.getAll();
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeBase()), (route) => false);
                                                   });

                                               }else{
                                                  setState(() {
                                                     _errors['passwordError'] = "Invalid Credentials";
                                                     _errors['usernameError'] = "Invalid Credentials";
                                                  });
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                               }
                                           }else{
                                             setState(() {
                                               isLoading = false;
                                             });
                                           }


                                         },
                                       )
                                     ]
                                   )
                                ),
                             ),
                           )
                       )
                     ]
                 )
               ],
             ),
             isLoading ? buildLoader(context) : Container()
           ],
         ),
       ),
    );
  }
}


checkLogin(context) async{
   SharedPreferences.getInstance().then((value) async{
       String user = await value.get("user");
       if(user != null){
          Auth.user = User.fromJson(jsonDecode(user));
          Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (BuildContext context) => HomeBase()), (route) => false);
       }
   });
}



class _LoginData{

  String username;
  String password;

}

