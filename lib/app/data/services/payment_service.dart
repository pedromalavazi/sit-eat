import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/bills_model.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/repository/payment_repository.dart';

class PaymentService extends GetxService {
  final PaymentRepository _paymentRepository = PaymentRepository();

  Future<String> getReservationIdByUser(String userId) async {
    if (!GetUtils.isNullOrBlank(userId)) {
      var reservationId = await _paymentRepository.getReservationIdByUser(userId);
      return reservationId;
    } else {
      return null;
    }
  }

  Future<BillModel> getBillByReservationId(String reservationId) async {
    if (!GetUtils.isNullOrBlank(reservationId)) {
      var bill = await _paymentRepository.getBillByReservationId(reservationId);

      if (bill.isBlank) return null;
      return bill;
    } else {
      return null;
    }
  }

  Future<bool> askBill(String id, String paymentType) async {
    try {
      return await _paymentRepository.askBill(id, paymentType);
    } catch (e) {
      return false;
    }
  }

  void updateReservationStatus(
    String reservationId,
    ReservationStatus status,
  ) async {
    await _paymentRepository.updateReservationStatus(reservationId, status);
  }
}
