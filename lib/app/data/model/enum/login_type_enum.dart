enum LoginType {
  CLIENT,
  RESTAURANT,
  ADMIN,
}

extension LoginTypeExtension on LoginType {
  String get description {
    switch (this) {
      case LoginType.CLIENT:
        return 'Cliente';
      case LoginType.RESTAURANT:
        return 'Restaurante';
      case LoginType.ADMIN:
        return 'Admin';
      default:
        return '';
    }
  }

  String get toUpper {
    switch (this) {
      case LoginType.CLIENT:
        return 'CLIENT';
      case LoginType.RESTAURANT:
        return 'RESTAURANT';
      case LoginType.ADMIN:
        return 'ADMIN';
      default:
        return '';
    }
  }
}
