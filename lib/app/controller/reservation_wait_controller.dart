import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservationWaitController extends GetxController {
  ReservationCardModel reservationModel = Get.arguments;
  Rx<ReservationCardModel> reservation = ReservationCardModel().obs;

  @override
  void onInit() async {
    reservation.value = reservationModel;
    super.onInit();
  }

  void launchURLBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nao foi possivel abrir $url';
    }
  }
}
