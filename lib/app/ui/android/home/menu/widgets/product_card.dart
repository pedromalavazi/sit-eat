import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({this.product});

  RxInt _itemCount = 0.obs;

  void checkDecrease(RxInt itemCount) {
    if (itemCount > 0) {
      _itemCount--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Card Itens
      child: GestureDetector(
        onTap: () {
          //Get.toNamed(Routes.RESTAURANT_MENU, arguments: food.restaurantId);
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
                        crossAxisAlignment: CrossAxisAlignment.end,

                        // Price
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            size: 28,
                            color: Colors.black54,
                          ),
                          Text(
                            product.price.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 35,
                                width: 40,
                              ),
                            ],
                          ),
                          // Item Counter
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                child: InkWell(
                                  onTap: () {
                                    checkDecrease(_itemCount);
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black54,
                                    size: 24,
                                  ),
                                ),
                                visible: true,
                              ),
                              Obx(
                                () => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white),
                                  child: Text(
                                    _itemCount.toString(),
                                    style: TextStyle(color: Colors.black54, fontSize: 24),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _itemCount++;
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black54,
                                  size: 24,
                                ),
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
