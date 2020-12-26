class County{
  String id;
  String name;
  static List list = [];

  County({this.id,this.name});

  County.fromJson(Map<String,dynamic> map):
        id = map["id"] ?? "",
        name = map["name"] ?? "";

  Map<String, dynamic>  toJson() =>{
    "id" : id, "name" : name
  };

  static getById(id){
     list.firstWhere((element) => element.id == id);
  }


}