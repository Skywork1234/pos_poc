import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/currency.dart';
import '../pos/widgets/receipt_dialog.dart';
import 'history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('ประวัติการขาย')),
      body: Obx(() {
        // อ่าน list ก่อนเพื่อให้ Obx ติดตามการเปลี่ยนแปลง
        final sales = controller.list.toList();
        return Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ยอดขายวันนี้'),
                  Text(baht(controller.todayTotal),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text('${controller.todayCount} บิล'),
                ],
              ),
            ),
            Expanded(
              child: sales.isEmpty
                  ? const Center(child: Text('ยังไม่มีรายการขาย'))
                  : ListView.separated(
                      itemCount: sales.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final s = sales[i];
                        final t = s.time;
                        final hm =
                            '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
                        return ListTile(
                          leading: const Icon(Icons.receipt),
                          title: Text('${s.id} · ${s.itemCount} ชิ้น'),
                          subtitle: Text('$hm · ${s.method.label}'),
                          trailing: Text(baht(s.total),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          onTap: () => Get.dialog(ReceiptDialog(sale: s)),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
