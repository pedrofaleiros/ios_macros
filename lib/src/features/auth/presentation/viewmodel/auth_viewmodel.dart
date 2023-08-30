import 'package:dio/dio.dart';
import 'package:ios_macros/src/features/auth/data/dto/user_dto.dart';
import 'package:ios_macros/src/features/auth/data/repository/shared_preferences_repository.dart';
import 'package:ios_macros/src/features/auth/domain/model/user_model.dart';
import 'package:ios_macros/src/features/auth/domain/usecase/auth_usecase.dart';
import 'package:mobx/mobx.dart';
part 'auth_viewmodel.g.dart';

class AuthViewmodel = _AuthViewmodelBase with _$AuthViewmodel;

abstract class _AuthViewmodelBase with Store {
  final AuthUsecase _usecase = AuthUsecase();

  @observable
  UserModel? sessionUser;
  @observable
  bool isLoading = false;

  @computed
  bool get isAuth => sessionUser != null;

  @action
  Future<void> login(UserDTO user) async {
    isLoading = true;

    try {
      final response = await _usecase.login(user);

      sessionUser = response;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response);
      } else {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signup(UserDTO user) async {
    isLoading = true;

    try {
      await _usecase.signup(user);
    } on DioException catch (e) {
      print(e.response!);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> autologin() async {
    isLoading = true;

    try {
      final response = await _usecase.autoLogin();

      sessionUser = response;
    } on SPException catch (e) {
      print('erro no shared preferences $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> logout() async {
    try {
      await _usecase.logout();
      sessionUser = null;
    } catch (e) {
      print(e.toString());
    }
  }
}
