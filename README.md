# POS POC (Flutter + GetX)

POC ระบบขายหน้าร้าน: เลือกสินค้า → ตะกร้า → ส่วนลด → ชำระเงิน (เงินสด/พร้อมเพย์จำลอง) → ใบเสร็จ → ประวัติการขายวันนี้

## เริ่มใช้งาน

```bash
cd pos_poc
flutter create . --project-name pos_poc   # สร้างโฟลเดอร์ android/ ios/ web/ ฯลฯ (ไม่ทับโค้ดใน lib/)
flutter pub get
flutter run -d chrome        # หรือ -d windows / -d macos / อุปกรณ์มือถือ
flutter test                 # รัน unit test ของ PosController
```

> ถ้า `flutter create .` สร้าง `test/widget_test.dart` มาด้วย ให้ลบทิ้ง (อ้างถึง MyApp ที่ไม่มีในโปรเจกต์นี้)

## โครงสร้าง

```
lib/
├── main.dart                     GetMaterialApp + routes
├── app/
│   ├── bindings/initial_binding.dart   ลงทะเบียน service ถาวร
│   └── routes/                         app_routes.dart, app_pages.dart
├── core/                         theme, ฟังก์ชันจัดรูปแบบเงินบาท
├── data/
│   ├── models/                   Product, CartItem, Sale, PaymentMethod
│   ├── repositories/             ProductRepository (ข้อมูลจำลอง)
│   └── services/                 SalesService (GetxService เก็บประวัติขาย)
└── modules/
    ├── pos/                      binding / controller / view / widgets
    └── history/                  binding / controller / view
```

แต่ละหน้าใช้รูปแบบ **Binding → Controller → View (GetView + Obx)**
controller รับ dependency ผ่าน constructor จึงเขียน test ได้ง่าย

## Layout
- จอกว้าง ≥ 900px (แท็บเล็ตแนวนอน/เว็บ/เดสก์ท็อป): สินค้าซ้าย ตะกร้าขวา
- จอแคบ (มือถือ): แถบยอดรวมด้านล่าง แตะเพื่อเปิดตะกร้า

## ต่อยอด
- เปลี่ยน `ProductRepository` ไปเรียก API หรือ SQLite/Hive
- เก็บ `SalesService` ลงฐานข้อมูลในเครื่อง (ตอนนี้หายเมื่อปิดแอป)
- สร้าง QR พร้อมเพย์จริง (package เช่น `promptpay` + `qr_flutter`)
- พิมพ์ใบเสร็จผ่านเครื่องพิมพ์ความร้อน Bluetooth
- ระบบสต็อก / สแกนบาร์โค้ด / หลายพนักงาน
