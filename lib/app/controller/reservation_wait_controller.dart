import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservationWaitController extends GetxController {
  ReservationCardModel reservationModel = Get.arguments;
  Rx<ReservationCardModel> reservation = ReservationCardModel().obs;

  final RestaurantService _restaurantService = RestaurantService();

  RxString restaurantName = "".obs;
  RxString address = "".obs;
  RxString checkIn = "".obs;
  RxString image = "".obs;
  RxInt occupationQty = 0.obs;

  @override
  void onInit() async {
    reservation.value = reservationModel;
    getReservationDetails(reservation.value);
    super.onInit();
  }

  void getReservationDetails(ReservationCardModel reservation) async {
    address.value = reservation.address;
    restaurantName.value = reservation.restaurantName;
    checkIn.value = reservation.checkIn.toString();
    occupationQty.value = reservation.occupationQty;
    image.value = reservation.restaurantImage;
    setCheckin();
  }

  void setCheckin() {
    var checkInConverted = DateTime.fromMillisecondsSinceEpoch(reservation.value.checkIn.millisecondsSinceEpoch);
    checkIn.value = _restaurantService.convertDateTimeToHourFormat(checkInConverted);
  }

  void launchURLBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nao foi possivel abrir $url';
    }
  }
}
