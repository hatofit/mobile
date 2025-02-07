// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'by_id_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ByIdParams _$ByIdParamsFromJson(Map<String, dynamic> json) {
  return _ByIdParams.fromJson(json);
}

/// @nodoc
mixin _$ByIdParams {
  String get id => throw _privateConstructorUsedError;

  /// Serializes this ByIdParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ByIdParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ByIdParamsCopyWith<ByIdParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ByIdParamsCopyWith<$Res> {
  factory $ByIdParamsCopyWith(
          ByIdParams value, $Res Function(ByIdParams) then) =
      _$ByIdParamsCopyWithImpl<$Res, ByIdParams>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$ByIdParamsCopyWithImpl<$Res, $Val extends ByIdParams>
    implements $ByIdParamsCopyWith<$Res> {
  _$ByIdParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ByIdParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ByIdParamsImplCopyWith<$Res>
    implements $ByIdParamsCopyWith<$Res> {
  factory _$$ByIdParamsImplCopyWith(
          _$ByIdParamsImpl value, $Res Function(_$ByIdParamsImpl) then) =
      __$$ByIdParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$ByIdParamsImplCopyWithImpl<$Res>
    extends _$ByIdParamsCopyWithImpl<$Res, _$ByIdParamsImpl>
    implements _$$ByIdParamsImplCopyWith<$Res> {
  __$$ByIdParamsImplCopyWithImpl(
      _$ByIdParamsImpl _value, $Res Function(_$ByIdParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ByIdParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ByIdParamsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ByIdParamsImpl implements _ByIdParams {
  const _$ByIdParamsImpl({this.id = ""});

  factory _$ByIdParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ByIdParamsImplFromJson(json);

  @override
  @JsonKey()
  final String id;

  @override
  String toString() {
    return 'ByIdParams(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ByIdParamsImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ByIdParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ByIdParamsImplCopyWith<_$ByIdParamsImpl> get copyWith =>
      __$$ByIdParamsImplCopyWithImpl<_$ByIdParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ByIdParamsImplToJson(
      this,
    );
  }
}

abstract class _ByIdParams implements ByIdParams {
  const factory _ByIdParams({final String id}) = _$ByIdParamsImpl;

  factory _ByIdParams.fromJson(Map<String, dynamic> json) =
      _$ByIdParamsImpl.fromJson;

  @override
  String get id;

  /// Create a copy of ByIdParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ByIdParamsImplCopyWith<_$ByIdParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
