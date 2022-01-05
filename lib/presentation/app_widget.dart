import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raja_ongkir/presentation/home/home_page.dart';
import 'package:raja_ongkir/routes/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Raja Ongkir',
      getPages: Routes.getPages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
