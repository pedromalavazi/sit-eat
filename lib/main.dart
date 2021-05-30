import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:get/route_manager.dart';
import 'config.dart';

Future<void> main() async {
  await initConfigurations();
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
        primaryColor: Colors.red[500],
        accentColor: Colors.white,
        brightness: Brightness.light,
        primaryColorLight: Colors.red[500],
        buttonColor: Colors.red[500],
        textTheme: GoogleFonts.sourceSansProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
