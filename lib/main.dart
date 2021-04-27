import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:get/route_manager.dart';
import 'app/ui/theme/color.grey.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init('sit_eat');
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
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: greyColor,
        ),
        textTheme: GoogleFonts.sourceSansProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
