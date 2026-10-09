import 'package:get/get.dart';

import '../../data/repositories/product_repository.dart';
import '../../data/services/sales_service.dart';

/// dependency ที่ต้องอยู่ตลอดอายุแอป
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository(), permanent: true);
    Get.put(SalesService(), permanent: true);
  }
}
