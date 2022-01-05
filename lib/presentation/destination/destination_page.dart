import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:raja_ongkir/application/cubit/raja_ongkir_controller.dart';
import 'package:raja_ongkir/application/cubit/raja_ongkir_cubit.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/cost_request_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/raja_ongkir_failed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raja_ongkir/injection.dart';
import 'package:raja_ongkir/presentation/home/components/city_dropdown.dart';
import 'package:raja_ongkir/presentation/home/components/province_dropdown.dart';
import 'package:raja_ongkir/presentation/result/result_page.dart';
import 'package:raja_ongkir/presentation/shimmer_widget.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key}) : super(key: key);

  static final String TAG = '/destination';

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  final rajaOngkirProvinceCubit = getIt<RajaOngkirCubit>();
  final rajaOngkirCityCubit = getIt<RajaOngkirCubit>();
  final rajaOngkirCostCubit = getIt<RajaOngkirCubit>();
  final weightController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(RajaongkirController());
  static List<String> listCourier = ["JNE", "TIKI", "POS"];
  String dropdownValue = "JNE";
  late int origin;
  late int weight;

  @override
  void initState() {
    rajaOngkirProvinceCubit.getProvinceDataFromInternet();

    origin = Get.arguments["origin"] as int;
    weight = Get.arguments["weight"] as int;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Destination")),
      body: BlocProvider(
        create: (context) => rajaOngkirCostCubit,
        child: BlocConsumer<RajaOngkirCubit, RajaOngkirState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              loading: (e) {
                print("on loading get cost");
              },
              error: (e) {
                print(e.failed);
              },
              onGetCostData: (e) {
                Get.toNamed(ResultPage.TAG, arguments: {
                  "data": e.responseDataModel,
                  "weight": weight,
                });
              },
            );
          },
          builder: (context, state) {
            return BlocProvider(
              create: (context2) => rajaOngkirProvinceCubit,
              child: BlocConsumer<RajaOngkirCubit, RajaOngkirState>(
                listener: (context2, state2) {
                  // TODO: implement listener
                },
                builder: (context2, state2) => state2.maybeMap(
                  orElse: () {
                    return Column(
                      children: [
                        BlocProvider(
                          create: (context) => rajaOngkirProvinceCubit,
                          child: BlocConsumer<RajaOngkirCubit, RajaOngkirState>(
                            listener: rajaOngkirCubitListener,
                            builder: (context, state) =>
                                provinceCubitBuilder(context, state),
                          ),
                        ),
                        BlocProvider(
                          create: (context) => rajaOngkirCityCubit,
                          child: BlocConsumer<RajaOngkirCubit, RajaOngkirState>(
                            listener: rajaOngkirCubitListener,
                            builder: (context, state) =>
                                cityCubitBuilder(context, state),
                          ),
                        ),
                        state.maybeMap(
                          orElse: () => defaultButton(),
                          loading: (e) => loadingButton(),
                        ),
                      ],
                    );
                  },
                  loading: (e) => destinationLoad(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Column destinationLoad() {
    return Column(
      children: [
        ShimmerWidget.circular(
          width: double.infinity,
          height: 60,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        ShimmerWidget.circular(
          width: double.infinity,
          height: 60,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        ShimmerWidget.circular(
          width: double.infinity,
          height: 45,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  Container defaultButton() {
    return Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Text("Cek Ongkir"),
        onPressed: () {
          final roController = Get.put(RajaongkirController());

          var _request = CostRequestDataModel(
            courier: "jne,tiki,pos",
            origin: origin,
            destination: int.parse(roController.getCityDataModel().cityId),
            weight: weight,
          );

          rajaOngkirCostCubit.getCostDataFromInternet(_request);
        },
      ),
    );
  }

  Container loadingButton() {
    return Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        child: CircularProgressIndicator(),
        onPressed: null,
      ),
    );
  }

  provinceCubitBuilder(BuildContext context, RajaOngkirState state) {
    return state.maybeMap(
      orElse: () => defaultDropDown(),
      loading: (e) => loadingDropDown(),
      error: (e) => defaultDropDown(),
      onGetProvinceData: (value) => ProvinceDropdown(
        data: value.dataModel,
        cubit: rajaOngkirCityCubit,
      ),
    );
  }

  cityCubitBuilder(BuildContext context, RajaOngkirState state) {
    return state.maybeMap(
      orElse: () => defaultDropDown(),
      loading: (e) => loadingDropDown(),
      error: (e) => defaultDropDown(),
      onGetCityData: (value) => CityDropdown(data: value.dataModel),
    );
  }

  Container loadingDropDown() {
    return Container(
      padding: EdgeInsets.all(10),
      child: DropdownButtonFormField<String>(
        onChanged: (_) {},
        items: [],
        value: null,
        decoration: InputDecoration(
          hintText: "Getting Data ...",
          border: OutlineInputBorder(),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Container defaultDropDown() {
    return Container(
      padding: EdgeInsets.all(10),
      child: DropdownButtonFormField<String>(
        onChanged: (_) {},
        items: [],
        value: null,
        decoration: InputDecoration(
          hintText: "No Data",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void rajaOngkirCubitListener(BuildContext context, RajaOngkirState state) {
    state.maybeMap(
      orElse: () {},
      loading: (e) {
        print("IS LOADING");
      },
      error: (e) {
        print(e.failed);
        Get.showSnackbar(GetBar(
          message: e.failed.description,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        ));
      },
      onGetProvinceData: (e) {
        //print(e.dataModel);
      },
      onGetCityData: (e) {
        //print(e.dataModel);
      },
    );
  }
}

Widget errorWidget(RajaOngkirFailed failed) => Center(
        child: Text(
      failed.description,
      style: TextStyle(fontSize: 29),
    ));
