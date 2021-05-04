import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/controller/restaurant_controller.dart';

class RestaurantPage extends GetView<LoginController> {
  final RestaurantController _restaurantController =
      Get.find<RestaurantController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.red,
              Colors.red[400],
              Colors.red[300],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 200,
                      child: Image.asset("assets/bar-do-alemao.png"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                _restaurantController
                                        .restaurant.value.address ??
                                    "",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                _restaurantController.restaurant.value.name ??
                                    "",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Horário de Funcionamento:",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Text(
                                _restaurantController.openTimeFormat.value,
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      _restaurantController.isOpen.value == true
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      _restaurantController.isOpen.value == true
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              Text(
                                _restaurantController.closeTimeFormat.value,
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      _restaurantController.isOpen.value == true
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
