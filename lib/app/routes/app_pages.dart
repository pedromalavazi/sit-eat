import 'package:get/get.dart';
import 'package:sit_eat/app/binding/login_binding.dart';
import 'package:sit_eat/app/binding/navigation_binding.dart';
import 'package:sit_eat/app/ui/android/home/home_page.dart';
import 'package:sit_eat/app/ui/android/login/login_page.dart';
import 'package:sit_eat/app/ui/android/login/splash_page.dart';
import 'package:sit_eat/app/ui/android/navigation/navigation_page.dart';
import 'package:sit_eat/app/ui/android/register-user/register_page.dart';
part './app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashPage()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(name: Routes.HOME, page: () => HomePage()),
    GetPage(name: Routes.USER_REGISTER, page: () => RegisterPage()),
    GetPage(
      name: Routes.NAVIGATION,
      page: () => NavigationPage(),
      binding: NavigationBinding(),
    ),
  ];
}
