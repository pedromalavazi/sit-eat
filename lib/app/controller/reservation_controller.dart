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
    _reservationService.listenerReservations(userId).listen((reservations) async {
      allReservations.clear();
      reservations = _reservationService.sortReservationsByCheckIn(reservations).reversed.toList();

      for (var i = 0; i < reservations.length; i++) {
        var reservation = reservations[i];
        ReservationCardModel cardTemp = ReservationCardModel();
        var restaurantTemp = await getRestaurantProps(reservation.restaurantId);
        cardTemp.id = reservation.id;
        cardTemp.active = reservation.active;
        cardTemp.canceled = reservation.canceled;
        cardTemp.checkIn = reservation.checkIn;
        cardTemp.occupationQty = reservation.occupationQty;
        cardTemp.restaurantId = reservation.restaurantId;
        cardTemp.restaurantImage = restaurantTemp.image;
        cardTemp.restaurantName = restaurantTemp.name;
        cardTemp.userId = reservation.userId;
        cardTemp.address = restaurantTemp.address;
        cardTemp.menu = restaurantTemp.menu;
        cardTemp.status = setStatus(reservation.active, reservation.canceled);
        allReservations.add(cardTemp);
      }
    });
  }

  String setStatus(bool active, bool canceled) {
    if (canceled) {
      return "Cancelado";
    } else if (active) {
      return "Reservado";
    } else if (!active) {
      return "Finalizado";
    } else
      return "error";
  }
}
