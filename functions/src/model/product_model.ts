export class ProductModel {
    id: string = "";
    price: number = 0;
    restaurantId: number = 0;
  }
  
  export function convertProductsFromDB(products: any) {
    var productList: ProductModel[] = [];
    
    if (products.docs.length > 0) {
      products.docs.forEach((order: any) => {
        var tempProduct: ProductModel = new ProductModel();
        tempProduct.id = order.id;
        tempProduct.price = order.data()["price"];
        tempProduct.restaurantId = order.data()["restaurantId"];
    
        productList.push(tempProduct);
      });
    }
  
    return productList;
  }
  
  export function convertProductFromDB(productFromDB: any) {
    var product: ProductModel = new ProductModel();
  
    if (productFromDB) {
      product.id = productFromDB.id;
      product.price = productFromDB.data()["price"];
      product.restaurantId = productFromDB.data()["restaurantId"];
    }
  
    return product;
  }
  