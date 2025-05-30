import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState<T> with _$LoginState<T> {
  const factory LoginState.initial() = _Initial;

  const factory LoginState.loading() = Loading;

  const factory LoginState.success(T data, String role) = Success<T>;

  //const factory LoginState.error({required String error}) = Error;
  const factory LoginState.error(String message) = Error;

  const factory LoginState.passwordVisibilityChanged() =
      PasswordVisibilityChanged;
}
