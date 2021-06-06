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

  RxList<ReservationCardModel> allReservations = RxList<ReservationCardModel>();
  Rx<UserModel> user = UserModel().obs;

  RxBool active = false.obs;
  RxBool canceled = false.obs;
  RxString status = "".obs;

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
      active.value = reservationFromBase.active;
      canceled.value = reservationFromBase.canceled;
      setStatus();
      cardTemp.status = status.value;
      allReservations.add(cardTemp);
    });
  }

  void setStatus() {
    if (active.isTrue && canceled.isFalse) {
      status.value = "Reservado";
    } else if (active.isFalse && canceled.isTrue) {
      status.value = "Cancelado";
    } else if (active.isFalse && canceled.isFalse) {
      status.value = "Finalizado";
    } else
      status.value = "error";
  }
}
