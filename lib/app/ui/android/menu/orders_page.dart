import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/order_controller.dart';

class OrdersPage extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    final OrderController _orderController = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
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

              // Lista de pedidos realizados
              /*
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
              */
            ],
          ),
        ),
      ),
    );
  }
}
