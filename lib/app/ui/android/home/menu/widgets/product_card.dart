import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Card Itens
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
                      image: NetworkImage(
                        product.image.isEmpty ? 'https://static.thenounproject.com/png/2393016-200.png' : product.image,
                      ),
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
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Price
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "R\$ ",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                product.price.toString().replaceFirst(".", ",") ?? "",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 35,
                                width: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
