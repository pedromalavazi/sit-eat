import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';
import 'package:sit_eat/app/data/repository/reservation_repository.dart';

class ReservationService extends GetxService {
  final ReservationRepository _reservationRepository = ReservationRepository();

  Future<ReservationModel> get(String id) async {
    if (!GetUtils.isNullOrBlank(id)) {
      return await _reservationRepository.getReservation(id);
    } else {
      return null;
    }
  }

  Future<ReservationModel> getActiveReservation(String userId) async {
    if (!GetUtils.isNullOrBlank(userId)) {
      return await _reservationRepository.getActiveReservation(userId);
    } else {
      return null;
    }
  }

  Future<String> insert(String userId, String restaurantId, int occupationQty) async {
    return await _reservationRepository.insert(userId, restaurantId, occupationQty);
  }

  Future<bool> insertIdReservation(String reservationId, String restaurantId) async {
    return await _reservationRepository.insertIdReservation(reservationId, restaurantId);
  }

  Future<int> getPositionInQueue(List<String> restaurantsId, String userId) async {
    int position = 0;
    List<ReservationModel> reservations = <ReservationModel>[];
    restaurantsId.removeWhere((id) => id == null);
    if (restaurantsId.length > 0) {
      for (var reservationId in restaurantsId) {
        ReservationModel reservation = await get(reservationId);
        reservations.add(reservation);
      }

      position = findUserPosition(sortReservationsByCheckIn(reservations), userId);

      return position;
    } else {
      return 0;
    }
  }

  Stream<List<String>> listenerReservationsFromQueue(String restaurantId, String userId) {
    return _reservationRepository.listenerReservationsFromQueue(restaurantId);
  }

  Stream<List<ReservationModel>> listenerReservations(String userId) {
    return _reservationRepository.listenerReservations(userId);
  }

  int findUserPosition(List<ReservationModel> reservations, String userId) {
    int position = 0;

    var userReservation = reservations.where((reservation) => reservation.userId == userId);
    if (userReservation.isNotEmpty) {
      position = reservations.indexOf(userReservation.first) + 1;
    }

    return position;
  }

  List<ReservationModel> sortReservationsByCheckIn(List<ReservationModel> reservations) {
    // Ordenar por data
    if (reservations.length == 1) {
      return reservations;
    }
    reservations.sort((a, b) {
      var checkInA = a == null ? 0 : a.checkIn.millisecondsSinceEpoch;
      var checkInB = b == null ? 0 : b.checkIn.millisecondsSinceEpoch;
      var dataA = DateTime.fromMillisecondsSinceEpoch(checkInA);
      var dataB = DateTime.fromMillisecondsSinceEpoch(checkInB);
      if (dataA.isAfter(dataB)) return 1;
      if (dataA.isBefore(dataB))
        return -1;
      else
        return 0;
    });

    return reservations;
  }

  List<ReservationModel> sortReservationsByActive(List<ReservationModel> reservations) {
    // Ordenar por data
    if (reservations.length == 1) {
      return reservations;
    }
    reservations.sort((a, b) {
      if (!a.active && b.active)
        return 1;
      else if (a.active && !b.active)
        return -1;
      else
        return 0;
    });

    return reservations;
  }
}
