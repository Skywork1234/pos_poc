import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/currency.dart';
import '../../../data/models/product.dart';
import '../pos_controller.dart';

class ProductGrid extends GetView<PosController> {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: controller.setSearch,
            decoration: const InputDecoration(
              hintText: 'ค้นหาสินค้า',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: Obx(
              () => ListView(
                scrollDirection: Axis.horizontal,
                children: controller.categories
                    .map((c) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(c),
                            selected: controller.selectedCategory.value == c,
                            onSelected: (_) => controller.selectCategory(c),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final items = controller.filteredProducts;
              if (items.isEmpty) {
                return const Center(child: Text('ไม่พบสินค้า'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: items.length,
                itemBuilder: (_, i) => _ProductCard(
                  product: items[i],
                  onTap: () => controller.addToCart(items[i]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});
  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Text(product.emoji,
                      style: const TextStyle(fontSize: 44)),
                ),
              ),
              Text(product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(baht(product.price),
                  style: TextStyle(color: scheme.primary)),
            ],
          ),
        ),
      ),
    );
  }
}
