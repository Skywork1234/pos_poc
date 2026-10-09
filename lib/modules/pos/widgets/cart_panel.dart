import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/currency.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/sale.dart';
import '../pos_controller.dart';
import 'payment_dialog.dart';
import 'receipt_dialog.dart';

class CartPanel extends GetView<PosController> {
  const CartPanel({super.key});

  Future<void> _pay() async {
    final sale = await Get.dialog<Sale>(const PaymentDialog());
    if (sale == null) return;
    if (Get.isBottomSheetOpen ?? false) Get.back();
    Get.dialog(ReceiptDialog(sale: sale));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
            child: Row(
              children: [
                Text('ตะกร้า', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                Obx(() => TextButton.icon(
                      onPressed:
                          controller.cart.isEmpty ? null : controller.clearCart,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('ล้าง'),
                    )),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Obx(() {
              if (controller.cart.isEmpty) {
                return const Center(child: Text('แตะสินค้าเพื่อเพิ่มลงตะกร้า'));
              }
              return ListView.separated(
                itemCount: controller.cart.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) => _CartRow(item: controller.cart[i]),
              );
            }),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => Column(
                children: [
                  _line('ยอดรวม', baht(controller.subtotal)),
                  Row(
                    children: [
                      const Text('ส่วนลด'),
                      const SizedBox(width: 8),
                      DropdownButton<double>(
                        value: controller.discountPercent.value,
                        isDense: true,
                        underline: const SizedBox.shrink(),
                        items: const [0.0, 5.0, 10.0, 20.0]
                            .map((d) => DropdownMenuItem(
                                value: d, child: Text('${d.toInt()}%')))
                            .toList(),
                        onChanged: (v) => controller.setDiscount(v ?? 0),
                      ),
                      const Spacer(),
                      Text('-${baht(controller.discount)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _line('ยอดสุทธิ', baht(controller.total),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52)),
                    onPressed: controller.cart.isEmpty ? null : _pay,
                    icon: const Icon(Icons.payments),
                    label: const Text('ชำระเงิน'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value, {TextStyle? style}) => Row(
        children: [
          Text(label, style: style),
          const Spacer(),
          Text(value, style: style),
        ],
      );
}

class _CartRow extends GetView<PosController> {
  const _CartRow({required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Text(item.product.emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(baht(item.total),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => controller.decrease(item),
          ),
          Text('${item.qty}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => controller.increase(item),
          ),
        ],
      ),
    );
  }
}
