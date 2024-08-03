import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hatofit/core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'company_entity.freezed.dart';
part 'company_entity.g.dart';

@freezed
class CompanyEntity with _$CompanyEntity {
  @HiveType(
    typeId: BoxTypeId.companyEntityIndex,
    adapterName: BoxTypeId.companyEntityAdapterName,
  )
  const factory CompanyEntity({
    @HiveField(0) int? id,
    @HiveField(1) String? uuid,
    @HiveField(2) String? name,
    @HiveField(3) String? description,
    @HiveField(4) String? address,
    @HiveField(5) String? image,
    @HiveField(6) DateTime? createdAt,
    @HiveField(7) DateTime? updatedAt,
  }) = _CompanyEntity;
}

void regisCompany() {
  if (!Hive.isAdapterRegistered(BoxTypeId.companyEntityIndex)) {
    Hive.registerAdapter(CompanyEntityAdapter());
  }
}