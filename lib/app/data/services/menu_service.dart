import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/repository/menu_repository.dart';

class MenuService extends GetxService {
  final MenuRepository _menuRepository = MenuRepository();

  Future<List<ProductModel>> getProducts(String restaurantId) {
    return _menuRepository.getProducts(restaurantId);
  }
}
