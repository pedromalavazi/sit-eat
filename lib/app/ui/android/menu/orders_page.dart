import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/order_controller.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/ui/android/menu/widgets/order_card.dart';

class OrdersPage extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    final OrderController _orderController = Get.put(OrderController());
    final UtilService _util = UtilService();

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
                      //return OrderCard(
                      //order: _orderController.orders[index],
                      return Dismissible(
                        key: ValueKey(_orderController.orders[index]),
                        background: Container(
                          color: Colors.redAccent,
                          child:
                              Icon(Icons.delete, color: Colors.white, size: 40),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.all(8.0),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) {
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Confirmar cancelamento"),
                              content: Text(
                                  "Tem certeza que deseja cancelar o pedido?"),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red[500]),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: Text("Cancelar")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red[500]),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                    child: Text("Confirmar")),
                              ],
                            ),
                          );
                        },
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.endToStart) {
                            _orderController.orders.removeAt(index);
                            _util.showSuccessMessage("Pedido cancelado",
                                "O restaurante será notificado sobre o cancelamento!");
                          }
                        },
                        child: OrderCard(order: _orderController.orders[index]),
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
          style: ElevatedButton.styleFrom(
              primary: Colors.red[500],
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fechar Conta'),
              Obx(
                () => Text(
                    'R\$ ${_util.setCurrencyPattern(_orderController.total.value)}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
