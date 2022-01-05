import 'package:flutter/material.dart';
import 'package:raja_ongkir/injection.dart';
import 'package:raja_ongkir/presentation/app_widget.dart';

void main() {
  configureDependencies();
  runApp(const AppWidget());
}
