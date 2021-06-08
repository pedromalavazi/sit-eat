import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('sit_eat');

  // Firebase
  await Firebase.initializeApp();

  // Para executar o Firebase no Emulador Local do Firebase descomentar a seguir
  FirebaseFirestore.instance.settings =
      Settings(host: 'localhost:8080', sslEnabled: false);
}