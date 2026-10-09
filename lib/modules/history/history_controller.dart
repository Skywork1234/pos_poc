import 'package:get/get.dart';

import '../../data/models/sale.dart';
import '../../data/services/sales_service.dart';

class HistoryController extends GetxController {
  HistoryController({required this.sales});

  final SalesService sales;

  RxList<Sale> get list => sales.sales;
  double get todayTotal => sales.todayTotal;
  int get todayCount => sales.todaySales.length;
}
