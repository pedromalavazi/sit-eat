import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/repository/menu_repository.dart';

class ProductService extends GetxService {
  final ProductRepository _productRepository = ProductRepository();

  Future<List<ProductModel>> getProducts(String restaurantId) {
    return _productRepository.getProducts(restaurantId);
  }

  Future<ProductModel> get(String id) async {
    if (GetUtils.isNullOrBlank(id)) {
      return null;
    }
    return await _productRepository.getProduct(id);
  }
}
