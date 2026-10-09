import '../models/product.dart';

/// แหล่งข้อมูลสินค้า — ตอนนี้เป็นข้อมูลจำลอง
/// ภายหลังเปลี่ยนเป็นเรียก API / SQLite ได้โดยไม่ต้องแก้ controller
class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mock;
  }

  static const _mock = <Product>[
    Product(id: 'd1', name: 'อเมริกาโน่', category: 'เครื่องดื่ม', price: 55, emoji: '☕'),
    Product(id: 'd2', name: 'ลาเต้เย็น', category: 'เครื่องดื่ม', price: 65, emoji: '🧋'),
    Product(id: 'd3', name: 'ชาเขียวนม', category: 'เครื่องดื่ม', price: 60, emoji: '🍵'),
    Product(id: 'd4', name: 'ชาไทย', category: 'เครื่องดื่ม', price: 50, emoji: '🥤'),
    Product(id: 'd5', name: 'น้ำเปล่า', category: 'เครื่องดื่ม', price: 15, emoji: '💧'),
    Product(id: 'f1', name: 'ข้าวกะเพราไก่', category: 'อาหาร', price: 60, emoji: '🍛'),
    Product(id: 'f2', name: 'ข้าวผัดหมู', category: 'อาหาร', price: 60, emoji: '🍚'),
    Product(id: 'f3', name: 'ผัดไทยกุ้ง', category: 'อาหาร', price: 80, emoji: '🍜'),
    Product(id: 'f4', name: 'แซนด์วิชทูน่า', category: 'อาหาร', price: 45, emoji: '🥪'),
    Product(id: 's1', name: 'ครัวซองต์', category: 'ขนม', price: 45, emoji: '🥐'),
    Product(id: 's2', name: 'บราวนี่', category: 'ขนม', price: 40, emoji: '🍫'),
    Product(id: 's3', name: 'เค้กส้ม', category: 'ขนม', price: 55, emoji: '🍰'),
    Product(id: 's4', name: 'คุกกี้', category: 'ขนม', price: 25, emoji: '🍪'),
  ];
}
