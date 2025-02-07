// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthResponseEntity {
  UserEntity? get user => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

  /// Create a copy of AuthResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResponseEntityCopyWith<AuthResponseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponseEntityCopyWith<$Res> {
  factory $AuthResponseEntityCopyWith(
          AuthResponseEntity value, $Res Function(AuthResponseEntity) then) =
      _$AuthResponseEntityCopyWithImpl<$Res, AuthResponseEntity>;
  @useResult
  $Res call({UserEntity? user, String? token});

  $UserEntityCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuthResponseEntityCopyWithImpl<$Res, $Val extends AuthResponseEntity>
    implements $AuthResponseEntityCopyWith<$Res> {
  _$AuthResponseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of AuthResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserEntityCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthResponseEntityImplCopyWith<$Res>
    implements $AuthResponseEntityCopyWith<$Res> {
  factory _$$AuthResponseEntityImplCopyWith(_$AuthResponseEntityImpl value,
          $Res Function(_$AuthResponseEntityImpl) then) =
      __$$AuthResponseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserEntity? user, String? token});

  @override
  $UserEntityCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AuthResponseEntityImplCopyWithImpl<$Res>
    extends _$AuthResponseEntityCopyWithImpl<$Res, _$AuthResponseEntityImpl>
    implements _$$AuthResponseEntityImplCopyWith<$Res> {
  __$$AuthResponseEntityImplCopyWithImpl(_$AuthResponseEntityImpl _value,
      $Res Function(_$AuthResponseEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? token = freezed,
  }) {
    return _then(_$AuthResponseEntityImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthResponseEntityImpl implements _AuthResponseEntity {
  const _$AuthResponseEntityImpl({this.user, this.token});

  @override
  final UserEntity? user;
  @override
  final String? token;

  @override
  String toString() {
    return 'AuthResponseEntity(user: $user, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResponseEntityImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, token);

  /// Create a copy of AuthResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResponseEntityImplCopyWith<_$AuthResponseEntityImpl> get copyWith =>
      __$$AuthResponseEntityImplCopyWithImpl<_$AuthResponseEntityImpl>(
          this, _$identity);
}

abstract class _AuthResponseEntity implements AuthResponseEntity {
  const factory _AuthResponseEntity(
      {final UserEntity? user, final String? token}) = _$AuthResponseEntityImpl;

  @override
  UserEntity? get user;
  @override
  String? get token;

  /// Create a copy of AuthResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResponseEntityImplCopyWith<_$AuthResponseEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
