import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String name;
  String email;
  String urlImage;

  UserModel({this.id, this.name, this.email, this.urlImage});

  UserModel.fromSnapshot(User currentUser)
      : id = currentUser.uid,
        name = currentUser.displayName,
        email = currentUser.email,
        urlImage = currentUser.photoURL;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "urlImage": urlImage,
    };
  }
}
