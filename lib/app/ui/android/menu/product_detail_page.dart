import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/product_controller.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';

class ProductDetailPage extends GetView<ProductController> {
  final ProductController _productController = Get.find<ProductController>();
  final UtilService _util = UtilService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        elevation: 0,
      ),
      body: Container(
        //width: double.infinity,
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
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Obx(
                    () => Center(
                      child: SizedBox(
                        width: 180,
                        height: 160,
                        child: _productController.setProductImage(_productController.product.value.image),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Obx(
                                  () => Container(
                                    constraints: BoxConstraints(maxWidth: 350.0),
                                    child: Text(
                                      _productController.product.value.name ?? "",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Obx(
                                  () => Container(
                                    child: Text(
                                      //"R\$ " + _productController.product.value.price.toString().replaceFirst(".", ",") ?? "",
                                      "R\$ " + _util.setCurrencyPattern(_productController.product.value.price) ?? "",
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Container(
                                      constraints: BoxConstraints(maxWidth: 350.0),
                                      child: Text(
                                        _productController.product.value.description ?? "",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Item Counter
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      if (_productController.itemCount > 0) {
                                        _productController.itemCount--;
                                        _productController.productCount--;
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black54,
                                      size: 26,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white),
                                  child: Obx(
                                    () => Text(
                                      _productController.itemCount.toString() ?? "null",
                                      style: TextStyle(color: Colors.black54, fontSize: 26),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      _productController.itemCount++;
                                      _productController.productCount++;
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black54,
                                      size: 26,
                                    ),
                                  ),
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
                                    _productController.createOrder();
                                  },
                                  text: "Realizar pedido",
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
