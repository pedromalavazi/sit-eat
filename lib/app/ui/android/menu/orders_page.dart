import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/order_controller.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
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
                    itemCount: _orderController.allOrders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: ValueKey(_orderController.allOrders[index]),
                        background: Container(
                          color: Colors.redAccent,
                          child: Icon(Icons.delete, color: Colors.white, size: 40),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.all(8.0),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) {
                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Confirmar cancelamento"),
                              content: Text("Tem certeza que deseja cancelar o pedido?"),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.red[500]),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: Text("Cancelar")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.red[500]),
                                    onPressed: () {
                                      _orderController.cancelOrder(index);
                                    },
                                    child: Text("Confirmar")),
                              ],
                            ),
                          );
                        },
                        onDismissed: (DismissDirection direction) {},
                        child: OrderCard(order: _orderController.allOrders[index]),
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
          onPressed: () {
            if (_orderController.totalPedidoText.value != null) {
              Get.toNamed(Routes.RESTAURANT_PAYMENT);
            } else {
              _util.showErrorMessage("Erro", "Lista de pedidos vazia!");
            }
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.red[500],
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fechar conta'),
              Obx(
                () => Text(_orderController.totalPedidoText.value ?? "R\$ 0,00"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
