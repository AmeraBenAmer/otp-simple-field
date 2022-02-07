import 'package:flutter_test/flutter_test.dart';

import 'package:otp_fields_simple/otp_fields_simple.dart';

void main() {
  test('adds one to input values', () {
    final otpField = OtpField( fieldsCount: 4);
    expect(OtpField, 3);
    // expect(calculator.addOne(-7), -6);
    // expect(calculator.addOne(0), 1);
  });
}
