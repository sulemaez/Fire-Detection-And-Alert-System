


import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:edsapp/services/http.dart';

class VideoStream{
  static SocketIOManager manager = SocketIOManager();
  static SocketIO socket;

  static void initialize(action) async{
    try{
      setupSocketIO(action); //else create new socket
    }catch(e){
      print(e);
    }
  }

  static void setupSocketIO(action) async{
    try{
      if(socket == null) {
        socket = await manager.createInstance(SocketOptions(Http.socketUrl,
            enableLogging: true
        )); //TODO change the port  accordingly

        socket.on("image", (data) { //sample event
            action(data);
        });

        socket.onConnect((data) {
          print("CONNECTED");
          socket.emit('join', ['camera']);
        });

        socket.onDisconnect((data) {
           print("DISCONNECTED");
        });

        socket.connect();
      }else{
        print("CHANGING");
      }

    }catch(e){
      print(e);
      print("ERRRROR");
    }
  }


}