import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/restaurant_controller.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';

class RestaurantPage extends GetView<RestaurantController> {
  final RestaurantController _restaurantController =
      Get.find<RestaurantController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      title: Text(
        'Realizar reserva',
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Source Code Pro",
        ),
      ),
      content: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value.length > 1) {
                    return "O valor digitado é inválido!";
                  } else if (GetUtils.isNullOrBlank(value)) {
                    return "Preencha o campo!";
                  }
                  return null;
                },
                controller: _restaurantController.qtdMesaTextController,
                autofocus: true,
                keyboardType: TextInputType.number,
                style: TextStyle(fontFamily: "Source Code Pro"),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Nº de pessoas na mesa",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: "Source Code Pro",
                  ),
                  prefixIcon: Icon(
                    Icons.group_add_rounded,
                    color: Colors.black,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancelar",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Source Code Pro",
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _restaurantController.registerReservation();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Reserva realizada com sucesso..."),
                  duration: Duration(milliseconds: 3000),
                  action: SnackBarAction(
                    label: "Ok",
                    onPressed: () {
                      Duration(milliseconds: 0);
                    },
                  ),
                ),
              );
            }
          },
          child: Text(
            "Reservar",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Source Code Pro",
            ),
          ),
        ),
      ],
    );
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
                  Obx(
                    () => Center(
                      child: SizedBox(
                        width: 220,
                        height: 200,
                        child: _restaurantController.setRestaurantImage(
                            _restaurantController.restaurant.value.image),
                      ),
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
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonWidget(
                              isWhiteTheme: false,
                              onPressed: () {
                                _restaurantController.launchURLBrowser(
                                    _restaurantController
                                        .restaurant.value.menu);
                              },
                              text: "Menu",
                              height: 60,
                              width: 180,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonWidget(
                              isWhiteTheme: false,
                              onPressed: () {
                                showDialog<void>(
                                    context: context,
                                    builder: (context) => dialog);
                              },
                              text: "Realizar reserva",
                              height: 60,
                              width: 180,
                            ),
                          ],
                        ),
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
