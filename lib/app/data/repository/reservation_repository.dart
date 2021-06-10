import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';

class ReservationRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Retorna lista de reservas
  Future<List<ReservationModel>> getAllReservations(String userId) async {
    try {
      var reservation = <ReservationModel>[];
      await _firestore.collection('reservations').where('userId', isEqualTo: userId).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((restaurant) {
          reservation.add(ReservationModel.fromSnapshot(restaurant));
        });
      });
      return reservation;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(title: "ERROR", content: Text("Reservas não encontradas."));
      return <ReservationModel>[];
    }
  }

  // Retorna reserva única pelo ID
  Future<ReservationModel> getReservation(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection("reservations").doc(id).get();
      ReservationModel reservation = ReservationModel.fromSnapshot(doc);
      reservation.id = id;
      return reservation;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(title: "ERROR", content: Text("Reserva não encontrada."));
      return ReservationModel();
    }
  }

  // Cria reserva
  Future<String> insert(String userId, String restaurantId, int occupationQty) async {
    try {
      String reservationId;
      await _firestore.collection("reservations").add(
        {
          "userId": userId,
          "restaurantId": restaurantId,
          "occupationQty": occupationQty,
          "checkin": DateTime.now(),
          "active": true,
          "canceled": false,
        },
      ).then(
        (doc) => {
          doc.update({"id": doc.id}),
          reservationId = doc.id,
        },
      );
      return reservationId;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(title: "ERROR", content: Text("Não foi possível fazer a reserva."));
      return "";
    }
  }

  Future<bool> insertIdReservation(String reservationId, String restaurantId) async {
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
      Get.defaultDialog(
        title: "ERROR",
        content: Text("Erro na reserva."),
      );
      return false;
    }
  }

  Stream<List<String>> listenerReservationsFromQueue(String restaurantId) {
    return _firestore.collection('restaurants/$restaurantId/queue').snapshots().map((doc) {
      if (doc.docs.length > 0) {
        return queueFromFirebase(doc);
      }
      return <String>[];
    });
  }

  Stream<List<ReservationModel>> listenerReservations(String userId) {
    return _firestore.collection('reservations').where('userId', isEqualTo: userId).snapshots().map((doc) {
      if (doc.docs.length > 0) {
        return convertReservationsFromDB(doc);
      }
      return <ReservationModel>[];
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
      var doc = await _firestore.collection("reservations").where('active', isEqualTo: true).where('userId', isEqualTo: userId).get();
      if (doc.docs.length == 0) {
        return null;
      }
      ReservationModel reservation = ReservationModel.fromSnapshot(doc.docs[0]);
      return reservation;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(title: "ERROR", content: Text("Reserva não encontrado."));
      return ReservationModel();
    }
  }
}
