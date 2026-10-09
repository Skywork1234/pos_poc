import 'cart_item.dart';

enum PaymentMethod {
  cash('เงินสด'),
  promptPay('พร้อมเพย์');

  final String label;
  const PaymentMethod(this.label);
}

class Sale {
  final String id;
  final DateTime time;
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double total;
  final PaymentMethod method;
  final double received;

  const Sale({
    required this.id,
    required this.time,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.method,
    required this.received,
  });

  double get change => received - total;
  int get itemCount => items.fold(0, (sum, i) => sum + i.qty);
}
