import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/costs_model.dart';

part 'result2_model.freezed.dart';
part 'result2_model.g.dart';

@freezed
class Result2Model with _$Result2Model {
  factory Result2Model({
    @Default("") String code,
    @Default("") String name,
    @Default(<CostsModel>[]) List<CostsModel> costs,
  }) = _Result2Model;

  factory Result2Model.fromJson(Map<String, dynamic> json) =>
      _$Result2ModelFromJson(json);
}
