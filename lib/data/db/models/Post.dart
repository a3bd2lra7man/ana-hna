import 'package:m7db/m7db.dart';

class Post extends M7Table{

  static const String tableName = 'Post';
  static const String fields = '_id TEXT PRIMARY KEY ,text TEXT,image TEXT,date TEXT,placerId TEXT';

  @override
  get primaryKey => id;

  String id;
  DateTime dateTime;
  String placerId;
  String text;
  String image;

  Post.fromMap(Map data):super.fromMap(data){
    id = data['_id'];
    placerId = data['placerId'];
    text = data['text'] ?? null;
    image = data['image'] ?? null;
    dateTime = DateTime.parse(data['date']);

  }

  @override
  Map<String, dynamic> toMap() =>{
    "_id":id,
    "placerId":placerId,
    "text":text,
    "image":image,
    "date":dateTime.toString()
  };

  @override
  M7Table copyWith()=> null;

  @override
  bool operator ==(other)  => this.id == other.senderId;

  @override
  int get hashCode => this.id.hashCode;




}