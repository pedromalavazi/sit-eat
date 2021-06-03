import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';

class ReservationController extends GetxController {
  final ReservationService _reservationService = ReservationService();
  final RestaurantService _restaurantService = RestaurantService();

  String restaurantId = Get.arguments;
  RxList<ReservationCardModel> allReservations = RxList<ReservationCardModel>();
  Rx<UserModel> user = UserModel().obs;

  Rx<RestaurantModel> restaurant = RestaurantModel().obs;

  RxString checkIn = "".obs;
  RxInt occupationQty = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setUser();
    getAllReservations(user.value.id);
  }

  setUser() {
    user = AuthService.to.user;
  }

  Future<RestaurantModel> getRestaurantProps(String restaurantId) async {
    RestaurantModel currentRestaurant = await _restaurantService.get(restaurantId);
    return currentRestaurant;
  }

  void getAllReservations(String userId) async {
    var reservationsFromBase = await _reservationService.getAll(userId);
    reservationsFromBase.forEach((reservationFromBase) async {
      ReservationCardModel cardTemp = ReservationCardModel();
      var restaurantTemp = await getRestaurantProps(reservationFromBase.restaurantId);
      cardTemp.id = reservationFromBase.id;
      cardTemp.active = reservationFromBase.active;
      cardTemp.canceled = reservationFromBase.canceled;
      cardTemp.checkIn = reservationFromBase.checkIn;
      cardTemp.occupationQty = reservationFromBase.occupationQty;
      cardTemp.restaurantId = reservationFromBase.restaurantId;
      cardTemp.restaurantImage = restaurantTemp.image;
      cardTemp.restaurantName = restaurantTemp.name;
      cardTemp.userId = reservationFromBase.userId;
      cardTemp.address = restaurantTemp.address;
      cardTemp.menu = restaurantTemp.menu;
      allReservations.add(cardTemp);
    });
  }
}
