import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'tokenType')
  final String? tokenType;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'centerId')
  final int? centerId;

  LoginResponse({
    this.token,
    this.tokenType,
    this.userName,
    this.role,
    this.userId,
    this.centerId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
