import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:raja_ongkir/domain/raja_ongkir/city/city_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/cost_response_data_model.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  static final String TAG = '/result_page';

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late CostResponseDataModel response;
  late int weight;

  @override
  void initState() {
    response = Get.arguments["data"] as CostResponseDataModel;
    weight = Get.arguments["weight"] as int;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Column(
        children: [
          cityListTile(
            response.originDetails,
            Colors.green[300],
            "Kota Asal",
          ),
          cityListTile(
            response.destinationDetails,
            Colors.amber[400],
            "Kota Tujuan",
          ),
          ListTile(
            tileColor: Colors.blue,
            title: Text("Berat"),
            subtitle: Text(weight.toString()),
          ),
          /*Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: response.results
                  .map((e) => Text(
                        e.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))
                  .toList(),
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                response.results.first.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),*/
          Expanded(
            child: ListView.builder(
                itemCount: response.results.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            response.results[index].name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Column(
                        children: response.results[index].costs
                            .map(
                              (_cost) => ListTile(
                                title: Text(_cost.service),
                                subtitle: Text(_cost.description),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      NumberFormat.decimalPattern()
                                          .format(_cost.cost.first.value),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(_cost.cost.first.etd.toString() +
                                        " Hari"),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  ListTile cityListTile(CityDataModel? city, Color? color, String title) {
    return ListTile(
      tileColor: color,
      title: Text(title),
      subtitle: Text(city!.cityName),
    );
  }
}
