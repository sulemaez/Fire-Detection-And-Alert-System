class User{
  String username;
  String uid;
  String name;
  String token;

  User({this.username,this.name,this.token,this.uid});

  User.fromJson(Map<String,dynamic> map):
        username = map["username"] ?? "",
        name = map["name"] ?? "",
        token = map["token"] ?? "",
        uid = map["uid"] ?? "";

  Map<String, dynamic>  toJson() =>{
    "username" : username,"name" : name, "token" : token
  };

}