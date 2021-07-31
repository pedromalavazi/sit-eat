import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/enum/qr_code_type_enum.dart';
import 'package:sit_eat/app/data/model/qr_code_model.dart';
import 'package:sit_eat/app/data/repository/qr_code_repository.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class QrCodeService extends GetxService {
  final QrCodeRepository _qrCodeRepository = QrCodeRepository();
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

  void loadTable(QrCodeModel qrCode) {
    _util.showSuccessMessage("Sucesso", "Mesa validada com sucesso!");
  }
}
