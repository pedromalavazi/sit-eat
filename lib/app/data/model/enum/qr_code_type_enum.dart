enum QrCodeType {
  RESTAURANT,
  TABLE,
}

extension SelectedColorExtension on QrCodeType {
  String get description {
    switch (this) {
      case QrCodeType.RESTAURANT:
        return 'RESTAURANT';
      case QrCodeType.TABLE:
        return 'TABLE';
      default:
        return '';
    }
  }

  String get toUpper {
    switch (this) {
      case QrCodeType.RESTAURANT:
        return 'RESTAURANT';
      case QrCodeType.TABLE:
        return 'TABLE';
      default:
        return '';
    }
  }
}
