import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/currency.dart';
import '../../../data/models/sale.dart';

class ReceiptDialog extends StatelessWidget {
  const ReceiptDialog({super.key, required this.sale});
  final Sale sale;

  @override
  Widget build(BuildContext context) {
    final t = sale.time;
    String two(int n) => n.toString().padLeft(2, '0');
    final time =
        '${two(t.day)}/${two(t.month)}/${t.year} ${two(t.hour)}:${two(t.minute)}';

    Widget line(String a, String b, {bool bold = false}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Expanded(
                  child: Text(a,
                      style: bold
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : null)),
              Text(b,
                  style: bold
                      ? const TextStyle(fontWeight: FontWeight.bold)
                      : null),
            ],
          ),
        );

    return AlertDialog(
      icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
      title: const Text('ชำระเงินสำเร็จ'),
      content: SizedBox(
        width: 320,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              line('เลขที่', sale.id),
              line('วันที่', time),
              const Divider(),
              ...sale.items.map((i) =>
                  line('${i.product.name} x${i.qty}', baht(i.total))),
              const Divider(),
              line('ยอดรวม', baht(sale.subtotal)),
              if (sale.discount > 0) line('ส่วนลด', '-${baht(sale.discount)}'),
              line('ยอดสุทธิ', baht(sale.total), bold: true),
              line('ชำระด้วย', sale.method.label),
              line('รับเงิน', baht(sale.received)),
              line('เงินทอน', baht(sale.change), bold: true),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(onPressed: () => Get.back(), child: const Text('ขายรายการถัดไป')),
      ],
    );
  }
}
