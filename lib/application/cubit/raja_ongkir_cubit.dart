import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:raja_ongkir/domain/raja_ongkir/city/city_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/cost_request_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/cost_response_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/province/province_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/raja_ongkir_failed.dart';
import 'package:raja_ongkir/domain/raja_ongkir/raja_ongkir_repository.dart';

part 'raja_ongkir_state.dart';
part 'raja_ongkir_cubit.freezed.dart';

@injectable
class RajaOngkirCubit extends Cubit<RajaOngkirState> {
  RajaOngkirCubit(this._iRajaOngkir) : super(RajaOngkirState.initial());

  IRajaOngkir _iRajaOngkir;

  void getProvinceDataFromInternet() async {
    emit(RajaOngkirState.loading());
    try {
      final _result = await _iRajaOngkir.getProvinceData();
      _result.fold(
        (l) => emit(RajaOngkirState.error(l)),
        (r) => emit(RajaOngkirState.onGetProvinceData(r)),
      );
    } catch (e) {
      emit(RajaOngkirState.error(
          RajaOngkirFailed().copyWith(description: e.toString())));
    }
  }

  void getCityDataFromInternet(String provinceID) async {
    emit(RajaOngkirState.loading());
    try {
      final _result = await _iRajaOngkir.getCityData(provinceID);
      _result.fold(
        (l) => emit(RajaOngkirState.error(l)),
        (r) => emit(RajaOngkirState.onGetCityData(r)),
      );
    } catch (e) {
      emit(RajaOngkirState.error(
          RajaOngkirFailed().copyWith(description: e.toString())));
    }
  }

  void getCostDataFromInternet(CostRequestDataModel request) async {
    emit(RajaOngkirState.loading());
    try {
      final _result = await _iRajaOngkir.getCost(request);
      _result.fold(
        (l) => emit(RajaOngkirState.error(l)),
        (r) => emit(RajaOngkirState.onGetCostData(r)),
      );
    } catch (e) {
      emit(RajaOngkirState.error(
          RajaOngkirFailed().copyWith(description: e.toString())));
    }
  }
}
