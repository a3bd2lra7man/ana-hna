class Category {
  String id;
  String arName;
  String enName;
  String image;

  Category.fromMap(Map map):
        id = map['id'],
        arName = map['arName'],
        enName = map['enName'],
        image = map['image'];

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==( other) {
    return this.id == other.placerId;
  }

}