import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:edsapp/models/camera.dart';
import 'package:edsapp/models/location.dart';
import 'package:edsapp/pages/cameras.dart';
import 'package:edsapp/services/http.dart';
import 'package:edsapp/services/notifications.dart';
import 'auth.dart';

class VideoStream{
  static SocketIOManager manager = SocketIOManager();
  static SocketIO socket;
  static Function action;
  static String nameVideo;

  static void initialize() async{
    try{
      setupSocketIO(); //else create new socket

    }catch(e){
      print(e);
    }
  }

  static void setupSocketIO() async{
    try{
      if(socket == null) {
        socket = await manager.createInstance(SocketOptions(Http.socketUrl,
            enableLogging: true
        )); //TODO change the port  accordingly

        socket.on("image", (data) { //sample event
            print("YES");
            if(action != null)action(data);
        });

        socket.on('alert',(data){
          print("HERERE");
          Camera cam =  Camera.list.where((c) => c.name == data).toList()[0];
          Location location = Location.getById(cam.locationId);
          camerasPageStateMain.save(cam);
          print(cam.name);
          Notifications.showNotification({ 'camera' : cam.name ,'location' : location.name},cam);
        });

        socket.onConnect((data) {
           print("CONNECTED");
           socket.emit('setuser', [Auth.user.username]);
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

  static destroy(){
    manager.clearInstance(socket);
  }

  static void joinVideo(send, name) {
    print("JOINING");
    action = send;
    nameVideo  = name;
    socket.emit('join', [name]);
  }

  static void leaveVideo() {
    print("POPOPOPOPOPOPOPO");
    action = null;
    if(socket != null){
      socket.emit('leave', [nameVideo]);
    }
  }

}