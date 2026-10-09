/// แปลงตัวเลขเป็นรูปแบบเงินบาท เช่น 1234.5 -> ฿1,234.50
String baht(num value) {
  final fixed = value.abs().toStringAsFixed(2);
  final parts = fixed.split('.');
  final digits = parts[0];
  final buf = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buf.write(',');
    buf.write(digits[i]);
  }
  final sign = value < 0 ? '-' : '';
  return '$sign฿$buf.${parts[1]}';
}
