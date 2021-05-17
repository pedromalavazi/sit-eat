import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservationController extends GetxController {
  final RestaurantService _restaurantService = RestaurantService();

  String restaurantId = Get.arguments;
  Rx<RestaurantModel> restaurant = RestaurantModel().obs;

  @override
  void onReady() async {
    getRestaurant();
    super.onReady();
  }

  void getRestaurant() async {
    RestaurantModel currentRestaurant = await _restaurantService.get(restaurantId);
    restaurant.value = currentRestaurant;
  }

  Widget setRestaurantImage(String image) {
    if (GetUtils.isNullOrBlank(image)) {
      return Container(
        child: Image.asset("assets/logo-only.png"),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  void launchURLBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nao foi possivel abrir $url';
    }
  }
}
