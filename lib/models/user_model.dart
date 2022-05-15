class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? cover;
  String? bio;
  String? image;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.cover,
    this.bio,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    cover = json['cover'];
    bio = json['bio'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'cover': cover,
      'bio': bio,
      'image': image,
    };
  }
}
