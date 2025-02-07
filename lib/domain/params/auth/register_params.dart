import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hatofit/domain/domain.dart';

part 'register_params.freezed.dart';

@freezed
class RegisterParams with _$RegisterParams {
  const factory RegisterParams({
    @Default(true) bool forLocal,
    @JsonKey(name: '_id') String? id,
    @Default("") String firstName,
    @Default("") String lastName,
    @Default("") String gender,
    @Default("") String email,
    @Default("") String password,
    @Default("") String confirmPassword,
    @Default("") String dateOfBirth,
    @Default(null) File? photo,
    @Default(0) int height,
    @Default(0) int weight,
    @Default(null) Map<String, String>? metricUnits,
  }) = _RegisterParams;

  const RegisterParams._();

  factory RegisterParams.fromUser(UserEntity user) => RegisterParams(
        id: user.id,
        firstName: user.firstName ?? "",
        lastName: user.lastName ?? "",
        gender: user.gender ?? "",
        email: user.email ?? "",
        dateOfBirth: user.dateOfBirth.toString(),
        photo: File(user.photo ?? ""),
        height: user.height ?? 150,
        weight: user.weight ?? 125,
        metricUnits: {
          "energyUnits": user.metricUnits?.energyUnits ?? "kcal",
          "heightUnits": user.metricUnits?.heightUnits ?? "cm",
          "weightUnits": user.metricUnits?.weightUnits ?? "kg",
        },
      );

  FormData toFormData() => FormData.fromMap({
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "dateOfBirth": dateOfBirth,
        "photo": photo != null ? MultipartFile.fromFileSync(photo!.path) : null,
        "height": height,
        "weight": weight,
        "metricUnits": metricUnits,
      });

  UserEntity toUserEntity() => UserEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        email: email,
        dateOfBirth: DateTime.parse(dateOfBirth),
        photo: photo?.path,
        height: height,
        weight: weight,
        metricUnits: UserMetricUnitsEntity(
          energyUnits: metricUnits?["energyUnits"],
          heightUnits: metricUnits?["heightUnits"],
          weightUnits: metricUnits?["weightUnits"],
        ),
      );
}
