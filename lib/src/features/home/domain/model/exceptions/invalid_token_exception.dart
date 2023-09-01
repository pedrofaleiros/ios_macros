class InvalidTokenException implements Exception {
  final String? message;

  InvalidTokenException({this.message});

  @override
  String toString() => message ?? 'token null';
}
