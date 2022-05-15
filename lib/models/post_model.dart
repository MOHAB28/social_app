class PostModel {
  String? name;
  String? image;
  String? uid;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.image,
    this.postImage,
    this.uid,
    this.dateTime,
    this.text,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    image = json['image'];
    postImage = json['postImage'];
    uid = json['uid'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'postImage': postImage,
      'uid': uid,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
