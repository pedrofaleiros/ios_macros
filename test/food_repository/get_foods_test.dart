import 'package:ios_macros/src/features/home/data/repository/get_foods_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Foods Repository', () {
    test('testando get foods Repository', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTMxNTg1MDgsImV4cCI6MTY5NTc1MDUwOCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.pC_6QMCAyAGUuuqPWrYufwRI84DUViMRlJYxXdQm0jg';

      final repo = GetFoodsRepository();

      final response = await repo.execute(token: token);

      response.forEach((element) {
        print(element.name);
      });
    });
  });
}
