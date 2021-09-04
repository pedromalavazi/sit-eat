import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/menu_controller.dart';
import 'package:sit_eat/app/ui/android/menu/widgets/product_card.dart';

class MenuPage extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    final MenuController _menuController = Get.find<MenuController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              // Header
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ),

              // Lista de produtos
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _menuController.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        product: _menuController.products[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
