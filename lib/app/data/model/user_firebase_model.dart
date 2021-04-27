import 'package:firebase_auth/firebase_auth.dart';

class UserFirebaseModel {
  String id;
  String name;
  String email;

  UserFirebaseModel({this.id, this.name, this.email});

  UserFirebaseModel.fromSnapshot(User currentUser)
      : id = currentUser.uid,
        name = currentUser.displayName,
        email = currentUser.email;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
