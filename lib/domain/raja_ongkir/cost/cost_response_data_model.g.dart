// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_response_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CostResponseDataModel _$$_CostResponseDataModelFromJson(
        Map<String, dynamic> json) =>
    _$_CostResponseDataModel(
      originDetails: json['origin_details'] == null
          ? null
          : CityDataModel.fromJson(
              json['origin_details'] as Map<String, dynamic>),
      destinationDetails: json['destination_details'] == null
          ? null
          : CityDataModel.fromJson(
              json['destination_details'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ResultModel>[],
    );

Map<String, dynamic> _$$_CostResponseDataModelToJson(
        _$_CostResponseDataModel instance) =>
    <String, dynamic>{
      'origin_details': instance.originDetails,
      'destination_details': instance.destinationDetails,
      'results': instance.results,
    };
