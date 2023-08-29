abstract class HomeRepositoryI<T> {
  String get url;

  Future<T> execute({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    required String token,
  });
}
