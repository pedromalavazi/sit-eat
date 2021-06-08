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
      reservation.sort((a, b) {
        var dataA = DateTime.fromMillisecondsSinceEpoch(a.checkIn.millisecondsSinceEpoch);
        var dataB = DateTime.fromMillisecondsSinceEpoch(b.checkIn.millisecondsSinceEpoch);
        return -dataA.compareTo(dataB);
      });
      return reservation;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(title: "ERROR", content: Text("Lista de restaurantes não encontrada."));
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
      Get.defaultDialog(title: "ERROR", content: Text("Restaurante não encontrado."));
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
      Get.defaultDialog(title: "ERROR", content: Text("Reserva não encontrada."));
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
}