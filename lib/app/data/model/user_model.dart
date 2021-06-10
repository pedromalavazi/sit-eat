import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phoneNumber;
  String tokenMessage;

  UserModel({this.id, this.name, this.email, this.phoneNumber, this.tokenMessage});

  UserModel.fromSnapshot(DocumentSnapshot currentUser)
      : id = currentUser.id,
        name = currentUser.data()["name"],
        email = currentUser.data()["email"],
        phoneNumber = currentUser.data()["phoneNumber"],
        tokenMessage = currentUser.data()["tokenMessage"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "tokenMessage": tokenMessage,
    };
  }
}
