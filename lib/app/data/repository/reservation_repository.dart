import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/bills_model.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';

class ReservationRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UtilService _util = UtilService();

  // Retorna lista de reservas
  Future<List<ReservationModel>> getAllReservations(String userId) async {
    try {
      var reservation = <ReservationModel>[];
      await _firestore
          .collection('reservations')
          .where('userId', isEqualTo: userId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((restaurant) {
          reservation.add(ReservationModel.fromSnapshot(restaurant));
        });
      });
      return reservation;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Não foi possível recuperar as reservas.");
      return <ReservationModel>[];
    }
  }

  // Retorna reserva única pelo ID
  Future<ReservationModel> getReservation(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("reservations").doc(id).get();
      ReservationModel reservation = ReservationModel.fromSnapshot(doc);
      reservation.id = id;
      return reservation;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Reserva não encontrada.");
      return ReservationModel();
    }
  }

  // Cria reserva
  Future<String> insert(
      String userId, String restaurantId, int occupationQty) async {
    try {
      var reservationId = await _firestore.collection("reservations").add(
        {
          "userId": userId,
          "restaurantId": restaurantId,
          "occupationQty": occupationQty,
          "checkin": DateTime.now(),
          "status": ReservationStatus.RESERVADO.toUpper
        },
      );
      return reservationId.id;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Não foi possível fazer sua reserva.");
      return "";
    }
  }

  Future<bool> insertIdReservation(
      String reservationId, String restaurantId) async {
    try {
      await _firestore.collection("restaurants/$restaurantId/queue").add(
        {
          "reservationId": reservationId,
        },
      );
      return true;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage(
        "ERROR",
        "Não foi possível fazer sua reserva.",
      );
      return false;
    }
  }

  Stream<List<String>> listenerReservationsFromQueue(String restaurantId) {
    return _firestore
        .collection('restaurants/$restaurantId/queue')
        .snapshots()
        .map((doc) {
      if (doc.docs.length > 0) {
        return queueFromFirebase(doc);
      }
      return <String>[];
    });
  }

  Stream<List<ReservationModel>> listenerReservations(String userId) {
    return _firestore
        .collection('reservations')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((doc) {
      if (doc.docs.length == 0) {
        return <ReservationModel>[];
      }
      return convertReservationsFromDB(doc);
    });
  }

  List<String> queueFromFirebase(QuerySnapshot queuesFromDB) {
    List<String> queues = <String>[];
    for (var i = 0; i < queuesFromDB.docs.length; i++) {
      QueryDocumentSnapshot doc = queuesFromDB.docs[i];
      String reservationId = doc.data()["reservationId"];
      queues.add(reservationId);
    }
    return queues;
  }

  Future<ReservationModel> getActiveReservation(String userId) async {
    try {
      var doc = await _firestore
          .collection("reservations")
          .where('status', whereIn: [
            ReservationStatus.ATIVO.toUpper,
            ReservationStatus.AGUARDANDO.toUpper,
            ReservationStatus.RESERVADO.toUpper
          ])
          .where('userId', isEqualTo: userId)
          .get();
      if (doc.docs.length == 0) {
        return null;
      }
      ReservationModel reservation = ReservationModel.fromSnapshot(doc.docs[0]);
      return reservation;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Reserva não encontrado.");
      return ReservationModel();
    }
  }

  Future<bool> cancelReservation(
      String reservationId, String restaurantId) async {
    try {
      var batch = _firestore.batch();

      var reservationToCancel = _firestore.doc('reservations/$reservationId');
      var reservation =
          ReservationModel.fromSnapshot(await reservationToCancel.get());

      if (reservation.status == ReservationStatus.RESERVADO) {
        var queueIdToDelete = (await _firestore
                .collection('restaurants/$restaurantId/queue')
                .where("reservationId", isEqualTo: reservationId)
                .get())
            .docs
            .first
            .id;
        var queue =
            _firestore.doc('restaurants/$restaurantId/queue/$queueIdToDelete');
        batch.delete(queue);
      } else if (reservation.status == ReservationStatus.AGUARDANDO) {
        var tableIdToDelete = (await _firestore
                .collection('restaurants/$restaurantId/tables')
                .where("reservationid", isEqualTo: reservationId)
                .get())
            .docs
            .first
            .id;
        var table =
            _firestore.doc('restaurants/$restaurantId/tables/$tableIdToDelete');
        batch.update(table, {"busy": false});
      }

      batch.update(
          reservationToCancel, {"status": ReservationStatus.CANCELADO.toUpper});
      await batch.commit();
      return true;
    } catch (e) {
      _util.showErrorMessage("Erro", "Não foi possível cancelar sua reserva.");
      return false;
    }
  }

  Future<String> getReservationIdByUser(String userId) async {
    try {
      var doc = await _firestore
          .collection("reservations")
          .where('status', whereIn: [ReservationStatus.ATIVO.toUpper])
          .where('userId', isEqualTo: userId)
          .get();
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

  //getBillByReservationId()
  Future<BillModel> getBillByReservationId(String reservationId) async {
    try {
      var doc = await _firestore
          .collection("bills")
          .where('asked', isEqualTo: false)
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
      _util.showErrorMessage("Erro", "Bill não encontrada.");
      return null;
    }
  }

  Future<void> askBill(String id) async {
    try {
      await _firestore.collection("bills").doc(id).update({"asked": true});
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Bill não encontrada.");
      return null;
    }
  }

  Future<void> updateReservationStatus(
      String reservationId, ReservationStatus status) async {
    try {
      await _firestore.collection('reservations').doc(reservationId).update({
        'status': status.toUpper,
      });
    } catch (e) {
      _util.showErrorMessage("Erro", "Erro ao atualizar o status da reserva");
    }
  }
}
