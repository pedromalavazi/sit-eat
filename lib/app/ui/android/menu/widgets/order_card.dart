import 'package:flutter/material.dart';
import 'package:sit_eat/app/data/model/order_card_model.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class OrderCard extends StatelessWidget {
  final OrderCardModel order;
  OrderCard({this.order});
  final UtilService _util = UtilService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {},
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
                      image: NetworkImage(order.image),
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
                          Container(
                            constraints: BoxConstraints(maxWidth: 220.0),
                            child: Text(
                              order.name,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "Quantidade: ",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            order.quantity.toString() ?? "",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
                            _util.setCurrencyPattern(order.price) ?? "",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
