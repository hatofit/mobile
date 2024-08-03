import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hatofit/domain/entities/entities.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    int? id,
    @JsonKey(name: '_id') String? uuid,
    String? name,
    String? description,
    String? address,
    @Default(
        'https://hatofit.com/_ipx/_/images/scene/risen-wang-20jX9b35r_M-unsplash.jpg')
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CompanyModel;

  const CompanyModel._();

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  CompanyEntity toEntity() => CompanyEntity(
        id: id,
        uuid: uuid,
        name: name,
        description: description,
        address: address,
        image: image,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory CompanyModel.fromEntity(CompanyEntity entity) => CompanyModel(
        id: entity.id,
        uuid: entity.uuid,
        name: entity.name,
        description: entity.description,
        address: entity.address,
        image: entity.image,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
