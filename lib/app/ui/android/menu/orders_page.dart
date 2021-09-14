import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/order_controller.dart';
import 'package:sit_eat/app/ui/android/menu/widgets/order_card.dart';

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
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _orderController.orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderCard(
                        order: _orderController.orders[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Colors.red[500], padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          child: Text('Fechar Conta'),
        ),
      ),
    );
  }
}
