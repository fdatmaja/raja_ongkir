// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'result2_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Result2Model _$Result2ModelFromJson(Map<String, dynamic> json) {
  return _Result2Model.fromJson(json);
}

/// @nodoc
class _$Result2ModelTearOff {
  const _$Result2ModelTearOff();

  _Result2Model call(
      {String code = "",
      String name = "",
      List<CostsModel> costs = const <CostsModel>[]}) {
    return _Result2Model(
      code: code,
      name: name,
      costs: costs,
    );
  }

  Result2Model fromJson(Map<String, Object?> json) {
    return Result2Model.fromJson(json);
  }
}

/// @nodoc
const $Result2Model = _$Result2ModelTearOff();

/// @nodoc
mixin _$Result2Model {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<CostsModel> get costs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Result2ModelCopyWith<Result2Model> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Result2ModelCopyWith<$Res> {
  factory $Result2ModelCopyWith(
          Result2Model value, $Res Function(Result2Model) then) =
      _$Result2ModelCopyWithImpl<$Res>;
  $Res call({String code, String name, List<CostsModel> costs});
}

/// @nodoc
class _$Result2ModelCopyWithImpl<$Res> implements $Result2ModelCopyWith<$Res> {
  _$Result2ModelCopyWithImpl(this._value, this._then);

  final Result2Model _value;
  // ignore: unused_field
  final $Res Function(Result2Model) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? costs = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      costs: costs == freezed
          ? _value.costs
          : costs // ignore: cast_nullable_to_non_nullable
              as List<CostsModel>,
    ));
  }
}

/// @nodoc
abstract class _$Result2ModelCopyWith<$Res>
    implements $Result2ModelCopyWith<$Res> {
  factory _$Result2ModelCopyWith(
          _Result2Model value, $Res Function(_Result2Model) then) =
      __$Result2ModelCopyWithImpl<$Res>;
  @override
  $Res call({String code, String name, List<CostsModel> costs});
}

/// @nodoc
class __$Result2ModelCopyWithImpl<$Res> extends _$Result2ModelCopyWithImpl<$Res>
    implements _$Result2ModelCopyWith<$Res> {
  __$Result2ModelCopyWithImpl(
      _Result2Model _value, $Res Function(_Result2Model) _then)
      : super(_value, (v) => _then(v as _Result2Model));

  @override
  _Result2Model get _value => super._value as _Result2Model;

  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? costs = freezed,
  }) {
    return _then(_Result2Model(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      costs: costs == freezed
          ? _value.costs
          : costs // ignore: cast_nullable_to_non_nullable
              as List<CostsModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Result2Model implements _Result2Model {
  _$_Result2Model(
      {this.code = "", this.name = "", this.costs = const <CostsModel>[]});

  factory _$_Result2Model.fromJson(Map<String, dynamic> json) =>
      _$$_Result2ModelFromJson(json);

  @JsonKey(defaultValue: "")
  @override
  final String code;
  @JsonKey(defaultValue: "")
  @override
  final String name;
  @JsonKey(defaultValue: const <CostsModel>[])
  @override
  final List<CostsModel> costs;

  @override
  String toString() {
    return 'Result2Model(code: $code, name: $name, costs: $costs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Result2Model &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.costs, costs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, code, name, const DeepCollectionEquality().hash(costs));

  @JsonKey(ignore: true)
  @override
  _$Result2ModelCopyWith<_Result2Model> get copyWith =>
      __$Result2ModelCopyWithImpl<_Result2Model>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_Result2ModelToJson(this);
  }
}

abstract class _Result2Model implements Result2Model {
  factory _Result2Model({String code, String name, List<CostsModel> costs}) =
      _$_Result2Model;

  factory _Result2Model.fromJson(Map<String, dynamic> json) =
      _$_Result2Model.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  List<CostsModel> get costs;
  @override
  @JsonKey(ignore: true)
  _$Result2ModelCopyWith<_Result2Model> get copyWith =>
      throw _privateConstructorUsedError;
}
