import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:get/route_manager.dart';
import 'package:sit_eat/app/ui/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Sit & Eat',
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        initialRoute: Routes.SPLASH,
        theme: appThemeData);
  }
}
