part of otp_fields_simple;

class OtpTheme {
  /// Colors of the input fields which have inputs.
  final Color activeColor;

  /// Color of the input field which is currently selected.
  final Color selectedColor;

  /// Colors of the input fields which don't have inputs.
  final Color inactiveColor;

  /// Colors of the input fields if the [OTP TextField] is disabled.
  final Color disabledColor;

  /// Color of the input field when in error mode.
  final Color errorBorderColor;

  /// Border radius of each otp code field
  final BorderRadius borderRadius;

  /// [height] for the otp code field.
  final double fieldHeight;

  /// [width] for the otp code field.
  final double fieldWidth;

  /// Border width for the each input fields. Default is [2.0]
  final double borderWidth;

  /// this defines the padding of each enclosing container of an input field. Default is [0.0]
  final Color backgroundColor;

  const OtpTheme.defaults({
    this.borderRadius = BorderRadius.zero,
    this.fieldHeight = 50,
    this.fieldWidth = 40,
    this.borderWidth = 2,
    this.backgroundColor = Colors.blueAccent,
    this.activeColor = Colors.blue,
    this.selectedColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.disabledColor = Colors.grey,
    this.errorBorderColor = Colors.redAccent,
  });

  factory OtpTheme({
    Color? activeColor,
    Color? selectedColor,
    Color? inactiveColor,
    Color? disabledColor,
    Color? errorBorderColor,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double? fieldHeight,
    double? fieldWidth,
    double? borderWidth,
  }) {
    const defaultValues = OtpTheme.defaults();
    return OtpTheme.defaults(
      backgroundColor: backgroundColor ?? defaultValues.backgroundColor,
      activeColor: activeColor ?? defaultValues.activeColor,
      borderRadius: borderRadius ?? defaultValues.borderRadius,
      borderWidth: borderWidth ?? defaultValues.borderWidth,
      disabledColor: disabledColor ?? defaultValues.disabledColor,
      fieldHeight: fieldHeight ?? defaultValues.fieldHeight,
      fieldWidth: fieldWidth ?? defaultValues.fieldWidth,
      inactiveColor: inactiveColor ?? defaultValues.inactiveColor,
      errorBorderColor: errorBorderColor ?? defaultValues.errorBorderColor,
    );
  }
}
