// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CompanyEntity {
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get uuid => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get address => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get image => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompanyEntityCopyWith<CompanyEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyEntityCopyWith<$Res> {
  factory $CompanyEntityCopyWith(
          CompanyEntity value, $Res Function(CompanyEntity) then) =
      _$CompanyEntityCopyWithImpl<$Res, CompanyEntity>;
  @useResult
  $Res call(
      {@HiveField(0) int? id,
      @HiveField(1) String? uuid,
      @HiveField(2) String? name,
      @HiveField(3) String? description,
      @HiveField(4) String? address,
      @HiveField(5) String? image,
      @HiveField(6) DateTime? createdAt,
      @HiveField(7) DateTime? updatedAt});
}

/// @nodoc
class _$CompanyEntityCopyWithImpl<$Res, $Val extends CompanyEntity>
    implements $CompanyEntityCopyWith<$Res> {
  _$CompanyEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanyEntityImplCopyWith<$Res>
    implements $CompanyEntityCopyWith<$Res> {
  factory _$$CompanyEntityImplCopyWith(
          _$CompanyEntityImpl value, $Res Function(_$CompanyEntityImpl) then) =
      __$$CompanyEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int? id,
      @HiveField(1) String? uuid,
      @HiveField(2) String? name,
      @HiveField(3) String? description,
      @HiveField(4) String? address,
      @HiveField(5) String? image,
      @HiveField(6) DateTime? createdAt,
      @HiveField(7) DateTime? updatedAt});
}

/// @nodoc
class __$$CompanyEntityImplCopyWithImpl<$Res>
    extends _$CompanyEntityCopyWithImpl<$Res, _$CompanyEntityImpl>
    implements _$$CompanyEntityImplCopyWith<$Res> {
  __$$CompanyEntityImplCopyWithImpl(
      _$CompanyEntityImpl _value, $Res Function(_$CompanyEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CompanyEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@HiveType(
    typeId: BoxTypeId.companyEntityIndex,
    adapterName: BoxTypeId.companyEntityAdapterName)
class _$CompanyEntityImpl implements _CompanyEntity {
  const _$CompanyEntityImpl(
      {@HiveField(0) this.id,
      @HiveField(1) this.uuid,
      @HiveField(2) this.name,
      @HiveField(3) this.description,
      @HiveField(4) this.address,
      @HiveField(5) this.image,
      @HiveField(6) this.createdAt,
      @HiveField(7) this.updatedAt});

  @override
  @HiveField(0)
  final int? id;
  @override
  @HiveField(1)
  final String? uuid;
  @override
  @HiveField(2)
  final String? name;
  @override
  @HiveField(3)
  final String? description;
  @override
  @HiveField(4)
  final String? address;
  @override
  @HiveField(5)
  final String? image;
  @override
  @HiveField(6)
  final DateTime? createdAt;
  @override
  @HiveField(7)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CompanyEntity(id: $id, uuid: $uuid, name: $name, description: $description, address: $address, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, uuid, name, description,
      address, image, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyEntityImplCopyWith<_$CompanyEntityImpl> get copyWith =>
      __$$CompanyEntityImplCopyWithImpl<_$CompanyEntityImpl>(this, _$identity);
}

abstract class _CompanyEntity implements CompanyEntity {
  const factory _CompanyEntity(
      {@HiveField(0) final int? id,
      @HiveField(1) final String? uuid,
      @HiveField(2) final String? name,
      @HiveField(3) final String? description,
      @HiveField(4) final String? address,
      @HiveField(5) final String? image,
      @HiveField(6) final DateTime? createdAt,
      @HiveField(7) final DateTime? updatedAt}) = _$CompanyEntityImpl;

  @override
  @HiveField(0)
  int? get id;
  @override
  @HiveField(1)
  String? get uuid;
  @override
  @HiveField(2)
  String? get name;
  @override
  @HiveField(3)
  String? get description;
  @override
  @HiveField(4)
  String? get address;
  @override
  @HiveField(5)
  String? get image;
  @override
  @HiveField(6)
  DateTime? get createdAt;
  @override
  @HiveField(7)
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$CompanyEntityImplCopyWith<_$CompanyEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
