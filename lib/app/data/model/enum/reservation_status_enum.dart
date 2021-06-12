enum ReservationStatus {
  RESERVADO,
  ATIVO,
  FINALIZADO,
  CANCELADO,
}

extension SelectedColorExtension on ReservationStatus {
  String get description {
    switch (this) {
      case ReservationStatus.RESERVADO:
        return 'Reservado';
      case ReservationStatus.ATIVO:
        return 'Ativo';
      case ReservationStatus.FINALIZADO:
        return 'Finalizado';
      case ReservationStatus.CANCELADO:
        return 'Cancelado';
      default:
        return '';
    }
  }
}
