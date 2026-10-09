import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/currency.dart';
import 'pos_controller.dart';
import 'widgets/cart_panel.dart';
import 'widgets/product_grid.dart';

class PosView extends GetView<PosController> {
  const PosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS'),
        actions: [
          IconButton(
            tooltip: 'ประวัติการขาย',
            icon: const Icon(Icons.receipt_long),
            onPressed: () => Get.toNamed(Routes.history),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          // จอกว้าง (แท็บเล็ต/เดสก์ท็อป/เว็บ): สินค้าซ้าย ตะกร้าขวา
          if (c.maxWidth >= 900) {
            return const Row(
              children: [
                Expanded(child: ProductGrid()),
                SizedBox(width: 380, child: CartPanel()),
              ],
            );
          }
          // จอแคบ (มือถือ): ตะกร้าเปิดเป็น bottom sheet
          return const ProductGrid();
        },
      ),
      bottomNavigationBar: MediaQuery.sizeOf(context).width >= 900
          ? null
          : _MobileCartBar(controller: controller),
    );
  }
}

class _MobileCartBar extends StatelessWidget {
  const _MobileCartBar({required this.controller});
  final PosController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => FilledButton(
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56)),
            onPressed: controller.cart.isEmpty
                ? null
                : () => Get.bottomSheet(
                      const SizedBox(height: 600, child: CartPanel()),
                      isScrollControlled: true,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 8),
                Text('${controller.itemCount} รายการ'),
                const Spacer(),
                Text(baht(controller.total),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
