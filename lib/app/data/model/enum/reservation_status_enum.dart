enum ReservationStatus {
  RESERVADO,
  AGUARDANDO,
  ATIVO,
  FINALIZADO,
  CANCELADO,
}

extension ReservationStatusExtension on ReservationStatus {
  String get description {
    switch (this) {
      case ReservationStatus.RESERVADO:
        return 'Reservado';
      case ReservationStatus.AGUARDANDO:
        return 'Aguardando';
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

  String get toUpper {
    switch (this) {
      case ReservationStatus.RESERVADO:
        return 'RESERVADO';
      case ReservationStatus.AGUARDANDO:
        return 'AGUARDANDO';
      case ReservationStatus.ATIVO:
        return 'ATIVO';
      case ReservationStatus.FINALIZADO:
        return 'FINALIZADO';
      case ReservationStatus.CANCELADO:
        return 'CANCELADO';
      default:
        return '';
    }
  }
}
