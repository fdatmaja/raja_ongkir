import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raja_ongkir/application/cubit/raja_ongkir_controller.dart';
import 'package:raja_ongkir/domain/raja_ongkir/city/city_data_model.dart';

class CityDropdown extends StatelessWidget {
  CityDropdown({Key? key, required this.data}) : super(key: key);

  final List<CityDataModel> data;
  final roController = Get.put(RajaongkirController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: DropdownButtonFormField<CityDataModel>(
        items: data
            .map((e) => DropdownMenuItem(
                  child: Text(e.type + " " + e.cityName),
                  value: e,
                ))
            .toList(),
        value: null,
        onChanged: (e) {
          roController.setCityDataModel(e!);
        },
        decoration: InputDecoration(
          hintText: "City",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
