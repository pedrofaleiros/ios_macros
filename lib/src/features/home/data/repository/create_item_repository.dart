import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/domain/repository/home_repository_interface.dart';
import 'package:ios_macros/src/utils/dio_client.dart';

class CreateItemRepository implements HomeRepositoryI<ItemModel> {
  @override
  Future<ItemModel> execute({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);
    final response = await dio.post(url, data: body);

    if (response.statusCode == 200) {
      ItemModel newItem = ItemModel.fromMap(response.data);
      return newItem;
    }

    throw Exception('Erro desconhecido createItem');
  }

  @override
  String get url => '${DioClient.baseUrl}/item';
}
