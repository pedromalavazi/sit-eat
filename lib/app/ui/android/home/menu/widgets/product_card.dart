import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProductCard extends StatelessWidget {
  final ProductModel food;
  ProductCard({this.food});

  int _itemCount = 0;

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
                        food.image.isEmpty ? 'https://static.thenounproject.com/png/2393016-200.png' : food.image,
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
                        food.name,
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
                            size: 24,
                            color: Colors.black,
                          ),
                          Text(
                            food.price.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                              ),
                            ],
                          ),

                          // Item Counter
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white),
                                child: Text(
                                  _itemCount.toString(),
                                  // PENSAR COMO MANIPULAR ESSA PORRA
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 20,
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
