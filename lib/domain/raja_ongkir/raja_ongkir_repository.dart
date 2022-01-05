import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:raja_ongkir/domain/raja_ongkir/city/city_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/cost_request_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/cost_response_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/result_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/province/province_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/raja_ongkir_failed.dart';
import 'package:raja_ongkir/utils/constants.dart';

abstract class IRajaOngkir {
  Future<Either<RajaOngkirFailed, List<ProvinceDataModel>>> getProvinceData();
  Future<Either<RajaOngkirFailed, List<CityDataModel>>> getCityData(
      String provinceId);
  Future<Either<RajaOngkirFailed, CostResponseDataModel>> getCost(
      CostRequestDataModel costRequest);
}

@LazySingleton(as: IRajaOngkir)
class RajaOngkirRepository extends IRajaOngkir {
  Dio _dio = Dio();

  @override
  Future<Either<RajaOngkirFailed, List<ProvinceDataModel>>>
      getProvinceData() async {
    Response response;
    _dio = Dio(BaseOptions(headers: {"key": Constants.rajaOngkirKey}));
    try {
      response =
          await _dio.get(Constants.rajaOngkirBaseUrl + "starter/province");
      List<dynamic> _listData = response.data['rajaongkir']['results'];

      var _listResult = _listData
          .map((result) => ProvinceDataModel.fromJson(result))
          .toList();

      return right(_listResult);
    } on DioError catch (err) {
      return left(checkResponseError(err));
    }
  }

  @override
  Future<Either<RajaOngkirFailed, List<CityDataModel>>> getCityData(
      String provinceId) async {
    Response response;
    _dio = Dio(BaseOptions(headers: {"key": Constants.rajaOngkirKey}));
    try {
      response = await _dio.get(
        Constants.rajaOngkirBaseUrl + "starter/city",
        queryParameters: {'province': provinceId},
      );
      List<dynamic> _listData = response.data['rajaongkir']['results'];

      var _listResult =
          _listData.map((result) => CityDataModel.fromJson(result)).toList();

      return right(_listResult);
    } on DioError catch (err) {
      return left(checkResponseError(err));
    }
  }

  RajaOngkirFailed checkResponseError(DioError err) {
    if (err.type == DioErrorType.response) {
      var _errorData = err.response!.data['rajaongkir']['status'];
      var _erroerModel = RajaOngkirFailed.fromJson(_errorData);
      return _erroerModel;
    } else {
      return RajaOngkirFailed();
    }
  }

  @override
  Future<Either<RajaOngkirFailed, CostResponseDataModel>> getCost(
      CostRequestDataModel costRequest) async {
    List<Response> response;
    List<CostResponseDataModel> listResponseDataModel =
        <CostResponseDataModel>[];

    _dio = Dio(BaseOptions(headers: {"key": Constants.rajaOngkirKey}));

    List<String> _courierList = costRequest.courier.split(",");

    final _dioList = _courierList
        .map((e) => _dio.post(
              Constants.rajaOngkirBaseUrl + "starter/cost",
              data: costRequest.copyWith(courier: e),
            ))
        .toList();
    try {
      response = await Future.wait(_dioList);

      response.forEach((element) {
        dynamic _listData = element.data['rajaongkir'];
        final _result = CostResponseDataModel.fromJson(_listData);
        listResponseDataModel.add(_result);
      });

      List<ResultModel> temporary = <ResultModel>[];
      CostResponseDataModel _newData = CostResponseDataModel(
        destinationDetails: listResponseDataModel.first.destinationDetails,
        originDetails: listResponseDataModel.first.originDetails,
      );
      listResponseDataModel.forEach((element) {
        temporary.addAll(element.results);
      });

      final _endResult = _newData.copyWith(results: temporary);

      return right(_endResult);
    } on DioError catch (err) {
      return left(checkResponseError(err));
    }
  }
}
