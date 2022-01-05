// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result2_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Result2Model _$$_Result2ModelFromJson(Map<String, dynamic> json) =>
    _$_Result2Model(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      costs: (json['costs'] as List<dynamic>?)
              ?.map((e) => CostsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_Result2ModelToJson(_$_Result2Model instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'costs': instance.costs,
    };
