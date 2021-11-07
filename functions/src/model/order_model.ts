export class OrderModel {
    id: string = "";
    orderTime: Date = new Date();
    productId: string = "";
    reservationId: string = "";
    quantity: number = 0;
    userId: string = "";
    total: number = 0;
  }
  
  export function convertOrdersFromDB(orders: any) {
    var orderList: OrderModel[] = [];
    
    if (orders.docs.length > 0) {
      orders.docs.forEach((order: any) => {
        var tempOrder: OrderModel = new OrderModel();
        tempOrder.id = order.id;
        tempOrder.orderTime = order.data()["orderTime"];
        tempOrder.productId = order.data()["productId"];
        tempOrder.quantity = order.data()["quantity"];
        tempOrder.reservationId = order.data()["reservationId"];
        tempOrder.userId = order.data()["userId"];
    
        orderList.push(tempOrder);
      });
    }
  
    return orderList;
  }
  
  export function convertOrderFromDB(orderFromDB: any) {
    var order: OrderModel = new OrderModel();
  
    if (orderFromDB) {
      order.id = orderFromDB.id;
      order.orderTime = orderFromDB.data()["orderTime"];
      order.productId = orderFromDB.data()["productId"];
      order.quantity = orderFromDB.data()["quantity"];
      order.reservationId = orderFromDB.data()["reservationId"];
      order.userId = orderFromDB.data()["userId"];
    }
  
    return order;
  }
  