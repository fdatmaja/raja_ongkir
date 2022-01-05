import 'package:get/get.dart';
import 'package:raja_ongkir/domain/raja_ongkir/city/city_data_model.dart';

class RajaongkirController extends GetxController {
  final cityDataModel = CityDataModel().obs;

  void setCityDataModel(CityDataModel data) {
    this.cityDataModel.value = data;
  }

  CityDataModel getCityDataModel() => this.cityDataModel.value;
}
