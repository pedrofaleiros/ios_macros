import 'package:ios_macros/src/features/home/data/repository/get_foods_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Meal Repository', () {
    test('testando crud mealRepository', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTMxNTg1MDgsImV4cCI6MTY5NTc1MDUwOCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.pC_6QMCAyAGUuuqPWrYufwRI84DUViMRlJYxXdQm0jg';

      final repo = GetFoodsRepository();

      for (var i = 0; i < 1000; i++) {
        // await Future.delayed(const Duration(seconds: 1));
        var startTime = DateTime.now();
        await repo.execute(token: token);
        var endTime = DateTime.now();
        var elapsedTime = endTime.difference(startTime);
        print('Time: ${elapsedTime.inMilliseconds} ms');
      }
    });
  });
}
