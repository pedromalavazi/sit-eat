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

  Future<List<ReservationModel>> getAll(userId) async {
    var reservations = await _reservationRepository.getAllReservations(userId);

    reservations = sortReservationsByCheckIn(reservations);

    // Ordenar por reservas abertas primeiro
    reservations.sort((a, b) {
      if (a.active && !b.active)
        return -1;
      else if (!a.active && b.active)
        return 1;
      else
        return 0;
    });
    return reservations;
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
    reservations.sort((a, b) {
      var dataA = DateTime.fromMillisecondsSinceEpoch(a.checkIn.millisecondsSinceEpoch);
      var dataB = DateTime.fromMillisecondsSinceEpoch(b.checkIn.millisecondsSinceEpoch);
      if (dataA.isAfter(dataB)) return 1;
      if (dataA.isBefore(dataB))
        return -1;
      else
        return 0;
    });

    return reservations;
  }
}
