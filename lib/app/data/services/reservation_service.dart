import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/bills_model.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';
import 'package:sit_eat/app/data/repository/reservation_repository.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class ReservationService extends GetxService {
  final ReservationRepository _reservationRepository = ReservationRepository();
  final _util = UtilService();

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

  Future<bool> cancelReservation(String reservationId, String restaurantId) async {
    if (reservationId.isBlank || restaurantId.isBlank) {
      _util.showInformationMessage("Erro", "Não foi possível cancelar sua reserva.");
      return false;
    }
    return await _reservationRepository.cancelReservation(reservationId, restaurantId);
  }

  Future<String> getReservationIdByUser(String userId) async {
    if (!GetUtils.isNullOrBlank(userId)) {
      var reservationId = await _reservationRepository.getReservationIdByUser(userId);
      return reservationId;
    } else {
      return null;
    }
  }
}
