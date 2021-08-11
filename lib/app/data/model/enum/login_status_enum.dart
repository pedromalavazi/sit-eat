enum LoginStatus {
  IN,
  OUT,
}

extension LoginStatusExtension on LoginStatus {
  String get description {
    switch (this) {
      case LoginStatus.OUT:
        return 'Out';
      case LoginStatus.IN:
        return 'In';
      default:
        return '';
    }
  }

  String get toUpper {
    switch (this) {
      case LoginStatus.IN:
        return 'IN';
      case LoginStatus.OUT:
        return 'OUT';
      default:
        return '';
    }
  }
}
