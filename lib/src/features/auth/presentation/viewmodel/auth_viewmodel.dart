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

  @computed
  bool get isAuth => sessionUser != null;

  @observable
  bool isLoading = false;

  @action
  Future<void> login(UserDTO user) async {
    isLoading = true;

    await Future.delayed(const Duration(milliseconds: 900));

    try {
      final response = await _usecase.login(user);

      sessionUser = response;
    } on DioException catch (e) {
      print(e.response!);
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

    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final response = await _usecase.autoLogin();

      sessionUser = response;
    } on SPException catch (e) {
      // print(e.toString());
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
