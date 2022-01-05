import 'package:get/get.dart';
import 'package:raja_ongkir/presentation/dashboard/dashboard_page.dart';
import 'package:raja_ongkir/presentation/destination/destination_page.dart';
import 'package:raja_ongkir/presentation/home/home_page.dart';
import 'package:raja_ongkir/presentation/result/result_page.dart';

class Routes {
  static List<GetPage>? getPages = [
    GetPage(name: HomePage.TAG, page: () => const HomePage()),
    GetPage(name: DashboardPage.TAG, page: () => const DashboardPage()),
    GetPage(name: ResultPage.TAG, page: () => const ResultPage()),
    GetPage(name: DestinationPage.TAG, page: () => const DestinationPage()),
  ];
}
