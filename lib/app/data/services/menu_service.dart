import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/repository/menu_repository.dart';
import 'package:sit_eat/app/data/services/image_service.dart';

class ProductService extends GetxService {
  final ProductRepository _productRepository = ProductRepository();
  final ImageService _imageService = ImageService();

  Future<List<ProductModel>> getProducts(String restaurantId) async {
    var products = await _productRepository.getProducts(restaurantId);

    for (var product in products) {
      await getProductImage(product);
    }

    return products;
  }

  Future<ProductModel> get(String id) async {
    if (GetUtils.isNullOrBlank(id)) {
      return null;
    }
    var product = await _productRepository.getProduct(id);
    await getProductImage(product);
    return product;
  }

  Future<void> getProductImage(ProductModel product) async {
    product.image = await _imageService.downloadProductUrl(
        product.image, product.restaurantId);
  }
}
