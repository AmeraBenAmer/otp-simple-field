part of otp_fields_simple;

/// Otp code text fields which automatically changes focus
class OtpCodeTextField extends StatefulWidget {
  /// The [BuildContext] of the application
  final BuildContext appContext;

  ///Box Shadow for Otp Field
  final List<BoxShadow>? boxShadows;

  /// length of how many field otp
  final int length;

  /// returns the current typing text in the fields
  final ValueChanged<String> onChanged;

  /// returns text when all otp number are set
  final ValueChanged<String>? onCompleted;

  /// returns text when user presses done/next action on the keyboard
  final ValueChanged<String>? onSubmitted;

  /// the style of the text, default is [ fontSize: 20, fontWeight: FontWeight.bold]
  final TextStyle? textStyle;

  /// background color for the whole row of otp code fields.
  final Color? backgroundColor;

  /// This defines how the elements in the otp field align. Default to [MainAxisAlignment.spaceBetween]
  final MainAxisAlignment mainAxisAlignment;

  /// Duration for the animation. Default is [Duration(milliseconds: 150)]
  final Duration animationDuration;

  /// [Curve] for the animation. Default is [Curves.easeInOut]
  final Curve animationCurve;

  /// [TextInputType] for the otp  fields. default is [TextInputType.visiblePassword]
  final TextInputType keyboardType;

  /// If the otp field should be autofocused or not. Default is [false]
  final bool autoFocus;

  /// Should pass a [FocusNode] to manage it from the parent
  final FocusNode? focusNode;

  /// A list of [TextInputFormatter] that goes to the TextField
  final List<TextInputFormatter> inputFormatters;

  /// Enable or disable the Field. Default is [true]
  final bool enabled;

  /// [TextEditingController] to control the text manually. Sets a default [TextEditingController()] object if none given
  final TextEditingController? controller;


  /// Auto dismiss the keyboard upon inputting the value for the last field. Default is [true]
  final bool autoDismissKeyboard;

  /// Auto dispose the [controller] and [FocusNode] upon the destruction of widget from the widget tree. Default is [true]
  final bool autoDisposeControllers;

  final TextInputAction textInputAction;

  /// Callback method to validate if text can be pasted. This is helpful when we need to validate text before pasting.
  /// e.g. validate if text is number. Default will be pasted as received.
  final bool Function(String? text)? beforeTextPaste;

  /// Method for detecting a otp form tap
  /// work with all form windows
  final Function? onTap;

  // /// Theme for the otp cells.
  final OtpTheme otpTheme;


  /// Validator for the [TextFormField]
  final FormFieldValidator<String>? validator;

  /// An optional method to call with the final value when the form is saved via
  /// [FormState.save].
  final FormFieldSetter<String>? onSaved;

  /// enables auto validation for the [TextFormField]
  /// Default is [autoValidateMode.onUserInteraction]
  final AutovalidateMode autoValidateMode;

  /// The vertical padding from the [OtpCodeTextField] to the error text
  /// Default is 16.
  final double errorTextSpace;

  /// Error animation duration
  final int errorAnimationDuration;

  /// Whether to show cursor or not
  final bool showCursor;

  /// The color of the cursor, default to Theme.of(context).accentColor
  final Color? cursorColor;

  /// and it also uses the [textStyle]'s properties
  /// [TextStyle.color] is [Colors.grey]
  final TextStyle? hintStyle;

  /// ScrollPadding follows the same property as TextField's ScrollPadding, default to
  /// const EdgeInsets.all(20),
  final EdgeInsets scrollPadding;

  /// Text gradient for OTp code
  final Gradient? textGradient;

  /// Makes the otp cells readOnly
  final bool readOnly;

  /// If cursor is '|' select style as color & size
  final TextStyle? cursorStyle;

  /// If [showCursor] true the focused field includes cursor widget or '|'
  final Widget? cursor;

  final InputDecoration? textInputDecoration;

  const OtpCodeTextField({
    Key? key,
    required this.appContext,
    required this.length,
    this.controller,
    this.textInputDecoration,
    required this.onChanged,
    this.onCompleted,
    this.cursorStyle,
    this.cursor,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.keyboardType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.onTap,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    this.textStyle,
    this.showCursor = true,
    this.textInputAction = TextInputAction.done,
    this.autoDismissKeyboard = true,
    this.autoDisposeControllers = true,
    this.onSubmitted,
    this.beforeTextPaste,
    this.otpTheme = const OtpTheme.defaults(),
    this.validator,
    this.onSaved,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.errorTextSpace = 16,
    this.errorAnimationDuration = 500,
    this.boxShadows,
    this.cursorColor,
    this.hintStyle,
    this.textGradient,
    this.readOnly = false,
    this.scrollPadding = const EdgeInsets.all(20),
  }) :
        super(key: key);

  @override
  OtpCodeTextFieldState createState() => OtpCodeTextFieldState();
}
