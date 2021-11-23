import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/enum/login_status_enum.dart';
import 'package:sit_eat/app/data/model/enum/qr_code_type_enum.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/model/qr_code_model.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';
import 'package:sit_eat/app/data/model/table_model.dart';
import 'package:sit_eat/app/data/repository/qr_code_repository.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/payment_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';
import 'package:sit_eat/app/data/services/user_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class QrCodeService extends GetxService {
  final QrCodeRepository _qrCodeRepository = QrCodeRepository();

  final ReservationService _reservationService = ReservationService();
  final RestaurantService _restaurantService = RestaurantService();
  final PaymentService _paymentService = PaymentService();
  final UserService _userService = UserService();
  final _util = UtilService();

  Future<QrCodeModel> getByQrCode(String qrCode) async {
    if (qrCode.isBlank) return null;

    QrCodeModel qrCodeModel = await _qrCodeRepository.getByQrCode(qrCode);

    return qrCodeModel;
  }

  void readQrCode(String qrCodeScanned) async {
    if (qrCodeScanned.isBlank) {
      _util.showErrorMessage("Não encontrado", "QR Code não encontrado");
      return null;
    }

    QrCodeModel qrCode = await getByQrCode(qrCodeScanned);

    if (qrCode == null) {
      return null;
    }

    switch (qrCode.type) {
      case QrCodeType.TABLE:
        loadTable(qrCode);
        break;
      case QrCodeType.RESTAURANT:
        loadRestaurant(qrCode);
        break;
      default:
        return null;
        break;
    }
  }

  void loadRestaurant(QrCodeModel qrCode) {
    Get.toNamed(Routes.RESTAURANT, arguments: qrCode.referenceId);
  }

  void loadTable(QrCodeModel qrCode) async {
    // Recupera reserva do usuário logado;
    var reservation = await _reservationService.getActiveReservation(AuthService.to.user.value.id);

    if (!(await isValidTable(reservation, qrCode.referenceId, qrCode.qrCode))) {
      Get.offAllNamed(Routes.NAVIGATION);
      _util.showErrorMessage("Erro", "Mesa escaneada não é válida para esse usuário!");
      return;
    }

    // Change login status;
    _userService.updateLoginStatus(LoginStatus.IN);

    // Update Reservation Status
    _paymentService.updateReservationStatus(reservation.id, ReservationStatus.ATIVO);

    Get.offAllNamed(Routes.NAVIGATION);
    _util.showSuccessMessage("Sucesso", "Mesa validada com sucesso!");
    return;
  }

  Future<bool> isValidTable(ReservationModel reservation, String tableIdScanned, String qrCodeScanned) async {
    if (reservation == null) return false;

    // Recupera a mesa que é esperada que o usuário sente
    TableModel table = await _restaurantService.getTable(reservation.restaurantId, reservation.id);

    // Verifica se o usuário realmente fez uma reserva
    if (table == null || table.id.isEmpty || table.qrCode.isEmpty || table.reservationId.isEmpty) return false;

    // Verifica se a mesa escaneada é a mesma mesa que o usuário devia sentar
    if (tableIdScanned != table.id || qrCodeScanned != table.qrCode || reservation.id != table.reservationId) {
      return false;
    }

    return true;
  }
}
