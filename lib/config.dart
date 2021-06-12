import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('sit_eat');

  // Firebase
  await Firebase.initializeApp();
}
