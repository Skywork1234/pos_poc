import 'package:get/get.dart';

import '../../modules/history/history_binding.dart';
import '../../modules/history/history_view.dart';
import '../../modules/pos/pos_binding.dart';
import '../../modules/pos/pos_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.pos;

  static final pages = <GetPage>[
    GetPage(
      name: Routes.pos,
      page: () => const PosView(),
      binding: PosBinding(),
    ),
    GetPage(
      name: Routes.history,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
