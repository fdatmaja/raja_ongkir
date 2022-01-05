import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:raja_ongkir/application/cubit/raja_ongkir_controller.dart';
import 'package:raja_ongkir/application/cubit/raja_ongkir_cubit.dart';
import 'package:raja_ongkir/domain/raja_ongkir/city/city_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/cost/cost_request_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/province/province_data_model.dart';
import 'package:raja_ongkir/domain/raja_ongkir/raja_ongkir_failed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raja_ongkir/injection.dart';
import 'package:raja_ongkir/presentation/destination/destination_page.dart';
import 'package:raja_ongkir/presentation/home/components/city_dropdown.dart';
import 'package:raja_ongkir/presentation/home/components/province_dropdown.dart';
import 'package:raja_ongkir/presentation/result/result_page.dart';
import 'package:raja_ongkir/presentation/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static final String TAG = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final rajaOngkirProvinceCubit = getIt<RajaOngkirCubit>();
  final rajaOngkirCityCubit = getIt<RajaOngkirCubit>();
  final rajaOngkirCostCubit = getIt<RajaOngkirCubit>();
  final weightController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(RajaongkirController());
  static List<String> listCourier = ["JNE", "TIKI", "POS"];
  String dropdownValue = "JNE";

  @override
  void initState() {
    rajaOngkirProvinceCubit.getProvinceDataFromInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Raja Ongkir")),
      //body: homeLoad(),
      body: BlocProvider(
        create: (context) => rajaOngkirProvinceCubit,
        child: BlocConsumer<RajaOngkirCubit, RajaOngkirState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              loading: (e) {
                print("on loading province");
              },
              error: (e) {
                print(e.failed);
              },
            );
          },
          builder: (context, state) => state.maybeMap(
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
                  /*Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField<String>(
                    items: listCourier.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Courier",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),*/
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Field can't be null";
                          } else {
                            return null;
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          hintText: "Weight",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  state.maybeMap(
                    orElse: () => defaultButton(),
                    loading: (e) => loadingButton(),
                  ),
                ],
              );
            },
            loading: (e) => homeLoad(),
          ),
        ),
      ),
    );
  }

  Column homeLoad() {
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
        child: Text("Next"),
        onPressed: () {
          final roController = Get.put(RajaongkirController());

          // var _request = CostRequestDataModel(
          //   courier: "jne,tiki,pos",
          //   origin: 151,
          //   destination: int.parse(roController.getCityDataModel().cityId),
          //   weight: int.parse(weightController.text),
          // );

          //rajaOngkirCostCubit.getCostDataFromInternet(_request);

          Get.toNamed(DestinationPage.TAG, arguments: {
            "origin": int.parse(roController.getCityDataModel().cityId),
            "weight": int.parse(weightController.text),
          });
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
