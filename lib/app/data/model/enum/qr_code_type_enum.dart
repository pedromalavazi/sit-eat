enum QrCodeType {
  RESTAURANT,
  TABLE,
}

extension SelectedColorExtension on QrCodeType {
  String get description {
    switch (this) {
      case QrCodeType.RESTAURANT:
        return 'Reservado';
      case QrCodeType.TABLE:
        return 'Aguardando';
      default:
        return '';
    }
  }

  String get toUpper {
    switch (this) {
      case QrCodeType.RESTAURANT:
        return 'Reservado';
      case QrCodeType.TABLE:
        return 'Aguardando';
      default:
        return '';
    }
  }
}
