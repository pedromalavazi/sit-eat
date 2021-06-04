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

  Future<List<ReservationModel>> getAll() async {
    return await _reservationRepository.getAllReservations();
  }

  Future<String> insert(
      String userId, String restaurantId, int occupationQty) async {
    return await _reservationRepository.insert(
        userId, restaurantId, occupationQty);
  }

  Future<bool> insertIdReservation(
      String reservationId, String restaurantId) async {
    return await _reservationRepository.insertIdReservation(
        reservationId, restaurantId);
  }
}
