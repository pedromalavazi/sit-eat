import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/bills_model.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';

class PaymentRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UtilService _util = UtilService();

  Future<String> getReservationIdByUser(String userId) async {
    try {
      var doc = await _firestore.collection("reservations").where('status', whereIn: [ReservationStatus.ATIVO.toUpper]).where('userId', isEqualTo: userId).get();
      if (doc.docs.length == 0) {
        return null;
      }
      ReservationModel reservation = ReservationModel.fromSnapshot(doc.docs[0]);
      return reservation.id;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Reserva não encontrada.");
      return null;
    }
  }

  Future<BillModel> getBillByReservationId(String reservationId) async {
    try {
      var doc = await _firestore
          .collection("bills")
          //.where('asked', isEqualTo: false)
          .where('paid', isEqualTo: false)
          .where('reservationId', isEqualTo: reservationId)
          .get();
      if (doc.docs.length == 0) {
        return null;
      }
      BillModel bill = BillModel.fromSnapshot(doc.docs[0]);
      return bill;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Conta não encontrada.");
      return null;
    }
  }

  Future<bool> askBill(String id, String paymentType) async {
    try {
      await _firestore.collection("bills").doc(id).update({"asked": true, "paymentType": paymentType});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateReservationStatus(String reservationId, ReservationStatus status) async {
    try {
      await _firestore.collection('reservations').doc(reservationId).update({
        'status': status.toUpper,
      });
    } catch (e) {
      _util.showErrorMessage("Erro", "Erro ao atualizar o status da reserva");
    }
  }
}
