import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({this.product});
  final UtilService _util = UtilService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.RESTAURANT_MENU_DETAIL, arguments: product.id);
        },
        child: Card(
          shadowColor: Colors.grey,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Imagem Prato
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Nome Prato
                      Row(
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      // Measure
                      Row(
                        children: [
                          Text(
                            product.measure ?? "",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // Price
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "R\$ ",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _util.setCurrencyPattern(product.price) ?? "",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
