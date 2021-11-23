import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/bills_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/payment_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class PaymentController extends GetxController {
  final PaymentService _paymentService = PaymentService();
  final UtilService _util = UtilService();

  Rx<UserModel> user = UserModel().obs;
  RxString paymentType = "".obs;
  RxBool billAsked = false.obs;

  @override
  void onInit() {
    user = AuthService.to.user;
    super.onInit();
  }

  Future<void> askBill() async {
    var billId = await getUserBill();

    if (billId == "asked") {
      Get.back();
      _util.showErrorMessage("Erro", "Você já solicitou o fechamento da conta!");
    } else if (paymentType.value.isBlank) {
      Get.back();
      _util.showErrorMessage("Erro", "Selecione uma forma de pagamento.");
    } else {
      this.billAsked.value = await _paymentService.askBill(billId, paymentType.value);
      Get.back();
      _util.showSuccessMessage("Solicitação de fechamento", "Sua conta está a caminho!");
    }
  }

  Future<String> getUserBill() async {
    var reservationId = await _paymentService.getReservationIdByUser(AuthService.to.user.value.id);
    BillModel currentBill = await _paymentService.getBillByReservationId(reservationId);

    if (currentBill.isBlank) {
      return null;
    } else if (currentBill.asked == true) {
      Get.back();
      return "asked";
    }

    var billId = currentBill.id;
    return billId;
  }
}
