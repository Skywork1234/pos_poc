import 'package:get/get.dart';

import '../../data/models/cart_item.dart';
import '../../data/models/product.dart';
import '../../data/models/sale.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/sales_service.dart';

class PosController extends GetxController {
  PosController({required this.repo, required this.sales});

  final ProductRepository repo;
  final SalesService sales;

  static const allCategory = 'ทั้งหมด';

  // ---------- สินค้า ----------
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final selectedCategory = allCategory.obs;
  final search = ''.obs;

  List<String> get categories =>
      [allCategory, ...products.map((p) => p.category).toSet()];

  List<Product> get filteredProducts {
    final q = search.value.trim().toLowerCase();
    return products.where((p) {
      final matchCat = selectedCategory.value == allCategory ||
          p.category == selectedCategory.value;
      final matchSearch = q.isEmpty || p.name.toLowerCase().contains(q);
      return matchCat && matchSearch;
    }).toList();
  }

  // ---------- ตะกร้า ----------
  final cart = <CartItem>[].obs;
  final discountPercent = 0.0.obs;

  int get itemCount => cart.fold(0, (sum, i) => sum + i.qty);
  double get subtotal => cart.fold(0, (sum, i) => sum + i.total);
  double get discount =>
      double.parse((subtotal * discountPercent.value / 100).toStringAsFixed(2));
  double get total => subtotal - discount;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    try {
      products.assignAll(await repo.fetchProducts());
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String c) => selectedCategory.value = c;
  void setSearch(String q) => search.value = q;

  void addToCart(Product p) {
    final idx = cart.indexWhere((i) => i.product.id == p.id);
    if (idx >= 0) {
      cart[idx].qty++;
      cart.refresh();
    } else {
      cart.add(CartItem(product: p));
    }
  }

  void increase(CartItem item) {
    item.qty++;
    cart.refresh();
  }

  void decrease(CartItem item) {
    if (item.qty > 1) {
      item.qty--;
      cart.refresh();
    } else {
      cart.remove(item);
    }
  }

  void remove(CartItem item) => cart.remove(item);

  void setDiscount(double percent) =>
      discountPercent.value = percent.clamp(0, 100).toDouble();

  void clearCart() {
    cart.clear();
    discountPercent.value = 0;
  }

  /// ปิดการขาย — คืนค่า Sale ที่บันทึกแล้ว
  Sale checkout({required PaymentMethod method, required double received}) {
    if (cart.isEmpty) throw StateError('ตะกร้าว่าง');
    if (received < total) throw StateError('รับเงินไม่พอ');

    final sale = Sale(
      id: sales.nextId(),
      time: DateTime.now(),
      items: cart.map((i) => i.copy()).toList(),
      subtotal: subtotal,
      discount: discount,
      total: total,
      method: method,
      received: received,
    );
    sales.add(sale);
    clearCart();
    return sale;
  }
}
