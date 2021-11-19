import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class PaymentsPage extends GetView<ReservationController> {
  final ReservationController _reservationController =
      Get.find<ReservationController>();
  final UtilService _util = UtilService();

  final List<Item> items = <Item>[
    Item('Dinheiro'),
    Item('Cartão'),
    Item('Vale Refeição')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _reservationController.billAsked.value
          ? Center(
              child: Text(
                "Pedido de conta já realizado",
                style: TextStyle(fontSize: 15),
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
              children: List.generate(
                items.length,
                (index) {
                  return Obx(
                    () => ListTile(
                      onTap: () {
                        resetItems(index);
                        items[index].selected.value =
                            !items[index].selected.value;
                        _reservationController.paymentType.value =
                            items[index].title;
                      },
                      selected: items[index].selected.value,
                      leading: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 48,
                          height: 48,
                        ),
                      ),
                      selectedTileColor: Colors.grey,
                      title: Text(
                        items[index].title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      contentPadding: EdgeInsets.only(right: 50),
                      trailing: (items[index].selected.value)
                          ? Icon(
                              Icons.radio_button_checked,
                              color: Colors.red[500],
                            )
                          : Icon(Icons.radio_button_off),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: _reservationController.billAsked.value
          ? Container()
          : Padding(
              padding: EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  try {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Fechamento de conta"),
                        content: Text("Tem certeza que deseja fechar a conta?"),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red[500],
                                  padding: EdgeInsets.all(15)),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: Text("Não")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red[500],
                                  padding: EdgeInsets.all(15)),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                                _reservationController.askBill();
                              },
                              child: Text("Sim")),
                        ],
                      ),
                    );
                  } catch (e) {
                    _util.showErrorMessage(
                        "Erro", "Selecione uma forma de pagamento.");
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[500],
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Finalizar'),
                  ],
                ),
              ),
            ),
    );
  }

  void resetItems(int index) {
    List<int> indexes = <int>[0, 1, 2];
    indexes.removeWhere((element) => element == index);
    indexes.forEach(
      (element) {
        items[element].selected.value = false;
      },
    );
  }
}

class Item {
  final String title;
  RxBool selected = false.obs;
  Item(this.title);
}
