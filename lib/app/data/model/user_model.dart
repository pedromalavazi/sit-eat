import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phoneNumber;

  UserModel({this.id, this.name, this.email, this.phoneNumber});

  UserModel.fromSnapshot(DocumentSnapshot currentUser)
      : id = currentUser.data()["id"],
        name = currentUser.data()["name"],
        email = currentUser.data()["email"],
        phoneNumber = currentUser.data()["phoneNumber"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
    };
  }
}
