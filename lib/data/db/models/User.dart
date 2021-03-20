import 'package:m7db/m7db.dart';

class User extends M7Table{
  String remoteId;
  String name;
  String token;
  String image;
  String email;

  @override
  get primaryKey => 1;

  static String get tableName => 'User';
  static String get fields => 'id INTEGER PRIMARY KEY ,_id TEXT ,name TEXT,image TEXT,token TEXT,email TEXT';

  User({this.remoteId,this.name,this.image,this.token}):super.create();

  User.fromMap(Map map):super.fromMap(map){
    remoteId = map['_id'];
    name = map['name'];
    image = map['image'] ?? null;
    token = map['token'];
    email = map['email'];
  }

  @override
  Map<String, dynamic> toMap() =>{
    "id":1,
    "_id":remoteId,
    "name":name,
    "image":image,
    "token":token,
    "email":email,
  };

  @override
  M7Table copyWith({String name,String image,String token}) {
    return User(remoteId: this.remoteId,name: name ?? this.name,image: image ?? this.image,token: token ?? this.token);
  }


}
