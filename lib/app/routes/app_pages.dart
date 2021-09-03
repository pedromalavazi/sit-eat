import 'package:get/get.dart';
import 'package:sit_eat/app/binding/edit_profile_binding.dart';
import 'package:sit_eat/app/binding/login_binding.dart';
import 'package:sit_eat/app/binding/menu_binding.dart';
import 'package:sit_eat/app/binding/navigation_binding.dart';
import 'package:sit_eat/app/binding/order_binding.dart';
import 'package:sit_eat/app/binding/product_binding.dart';
import 'package:sit_eat/app/binding/reservation_binding.dart';
import 'package:sit_eat/app/binding/restaurant_binding.dart';
import 'package:sit_eat/app/ui/android/home/home_page.dart';
import 'package:sit_eat/app/ui/android/home/menu/orders_page.dart';
import 'package:sit_eat/app/ui/android/home/menu/product_detail_page.dart';
import 'package:sit_eat/app/ui/android/login/forget-password/forget_password_page.dart';
import 'package:sit_eat/app/ui/android/login/login_page.dart';
import 'package:sit_eat/app/ui/android/login/splash_page.dart';
import 'package:sit_eat/app/ui/android/navigation/navigation_page.dart';
import 'package:sit_eat/app/ui/android/profile/about.dart';
import 'package:sit_eat/app/ui/android/profile/editprofile_page.dart';
import 'package:sit_eat/app/ui/android/profile/profile_page.dart';
import 'package:sit_eat/app/ui/android/register-user/register_page.dart';
import 'package:sit_eat/app/ui/android/reservation/reservation_wait_page.dart';
import 'package:sit_eat/app/ui/android/home/menu/menu_page.dart';
import 'package:sit_eat/app/ui/android/restaurant/restaurant_page.dart';
part './app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: Routes.CHECK_AUTH,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.FORGET_PASSWORD,
      page: () => ForgetPasswordPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.USER_REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.NAVIGATION,
      page: () => NavigationPage(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: Routes.RESTAURANT,
      page: () => RestaurantPage(),
      binding: RestaurantBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.ABOUT,
      page: () => AboutPage(),
      // binding: AboutPage(),
    ),
    GetPage(
      name: Routes.RESTAURANT_WAIT_PAGE,
      page: () => ReservationWaitPage(),
      binding: ReservationBinding(),
    ),
    GetPage(
      name: Routes.RESTAURANT_MENU,
      page: () => MenuPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: Routes.RESTAURANT_MENU_DETAIL,
      page: () => ProductDetailPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.RESTAURANT_ORDERS,
      page: () => OrdersPage(),
      binding: OrderBinding(),
    ),
  ];
}
