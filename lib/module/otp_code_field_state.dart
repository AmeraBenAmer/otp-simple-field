part of otp_fields_simple;

class OtpCodeTextFieldState extends State<OtpCodeTextField>
    with TickerProviderStateMixin {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;

  BorderRadius? borderRadius;

  // AnimationController for the error animation
  late AnimationController _controller;

  AnimationController? _cursorController;

  bool isInErrorMode = false;

  // Animation for the error animation
  late Animation<Offset> _offsetAnimation;

  late Animation<double> _cursorAnimation;

  OtpTheme get _otpTheme => widget.otpTheme;

  TextStyle get _textStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ).merge(widget.textStyle);

  @override
  void initState() {
    _checkForInvalidValues();
    _assignController();
    borderRadius = _otpTheme.borderRadius;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.addListener(() {
      setState(() {});
    }); // Rebuilds on every change to reflect the correct color on each field.
    _inputList = List<String>.filled(widget.length, "");

    if (widget.showCursor) {
      _cursorController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800));
      _cursorAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(curve: Curves.linear, parent: _cursorController!));

      _cursorController!.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _cursorController!.repeat(reverse: true);
        }
      });
      _cursorController!.forward();
    }

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.errorAnimationDuration),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    if (widget.showCursor) {
      _cursorController!.repeat();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    // If a default value is set in the TextEditingController, then set to UI
    if (_textEditingController!.text.isNotEmpty) {
      _setTextToInput(_textEditingController!.text);
    }
    super.initState();
  }

  // validating all the values
  void _checkForInvalidValues() {
    assert(widget.length > 0);
    assert(_otpTheme.fieldHeight > 0);
    assert(_otpTheme.fieldWidth > 0);
    assert(_otpTheme.borderWidth >= 0);
  }

  void _assignController() {
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = widget.controller;
    }
    _textEditingController?.addListener(() {
      if (isInErrorMode) {
        setState(() => isInErrorMode = false);
      }
      var currentText = _textEditingController!.text;

      if (widget.enabled && _inputList.join("") != currentText) {
        if (currentText.length >= widget.length) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.length) {
              // removing extra text longer than the length
              currentText = currentText.substring(0, widget.length);
            }
            //  delay the onComplete event handler to give the onChange event handler enough time to complete
            Future.delayed(const Duration(milliseconds: 300),
                () => widget.onCompleted!(currentText));
          }

          if (widget.autoDismissKeyboard) _focusNode!.unfocus();
        }
        widget.onChanged(currentText);
      }

      _setTextToInput(currentText);
    });
  }

  @override
  void dispose() {
    if (widget.autoDisposeControllers) {
      _textEditingController!.dispose();
      _focusNode!.dispose();
    }

    _cursorController!.dispose();

    _controller.dispose();
    super.dispose();
  }

//  selects the right color for the field
  Color _getColorFromIndex(int index) {
    if (!widget.enabled) {
      return _otpTheme.disabledColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus) {
      return _otpTheme.selectedColor;
    } else if (_selectedIndex > index) {
      Color relevantActiveColor = _otpTheme.activeColor;
      if (isInErrorMode) relevantActiveColor = _otpTheme.errorBorderColor;
      return relevantActiveColor;
    }

    Color relevantInActiveColor = _otpTheme.inactiveColor;
    if (isInErrorMode) relevantInActiveColor = _otpTheme.errorBorderColor;
    return relevantInActiveColor;
  }

  Widget _renderOtpField({
    @required int? index,
  }) {
    assert(index != null);
    final text = _inputList[index!];
    return Text(
      text,
      key: ValueKey(_inputList[index]),
      style: _textStyle,
    );
  }

  /// Builds the widget to be shown
  Widget buildChild(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus &&
        widget.showCursor) {
      if ((_selectedIndex == index + 1 && index + 1 == widget.length)) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _renderOtpField(
              index: index,
            ),
          ],
        );
      } else {
        return Center(
          child:
              FadeTransition(opacity: _cursorAnimation, child: _buildCursor()),
        );
      }
    }
    return _renderOtpField(
      index: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    var textField = TextFormField(
      textInputAction: widget.textInputAction,
      controller: _textEditingController,
      focusNode: _focusNode,
      enabled: widget.enabled,
      autofocus: widget.autoFocus,
      autocorrect: false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autoValidateMode,

      // trigger on the complete event handler from the keyboard
      onFieldSubmitted: widget.onSubmitted,
      enableInteractiveSelection: false,
      showCursor: false,

      decoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // fillColor: Colors.blueAccent
      ),
      style: const TextStyle(
        color: Colors.transparent,
        height: .01,
        fontSize: 1,
      ),
      scrollPadding: widget.scrollPadding,
      readOnly: widget.readOnly,
    );

    return SlideTransition(
      position: _offsetAnimation,
      child: SizedBox(
        // adding the extra space at the bottom to show the error text from validator
        height: (widget.autoValidateMode == AutovalidateMode.disabled &&
                widget.validator == null)
            ? widget.otpTheme.fieldHeight
            : widget.otpTheme.fieldHeight + widget.errorTextSpace,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            AutofillGroup(
              child: textField,
            ),
            _buildCombineAllOtpFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildCombineAllOtpFields() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) widget.onTap!();
          _onFocus();
        },
        child: Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: _generateFields(),
        ),
      ),
    );
  }

  List<Widget> _generateFields() {
    var result = <Widget>[];
    for (int i = 0; i < widget.length; i++) {
      result.add(
        AnimatedContainer(
          curve: widget.animationCurve,
          duration: widget.animationDuration,
          width: _otpTheme.fieldWidth,
          height: _otpTheme.fieldHeight,
          decoration: BoxDecoration(
            boxShadow: widget.boxShadows,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            border: Border.all(
              color: _getColorFromIndex(i),
              width: _otpTheme.borderWidth,
            ),
          ),
          child: Container(
            color: widget.backgroundColor,
            child: Center(
              child: buildChild(i),
            ),
          ),
        ),
      );
    }
    return result;
  }

  void _onFocus() {
    if (_focusNode!.hasFocus &&
        MediaQuery.of(widget.appContext).viewInsets.bottom == 0) {
      _focusNode!.unfocus();
      Future.delayed(
          const Duration(microseconds: 1), () => _focusNode!.requestFocus());
    } else {
      _focusNode!.requestFocus();
    }
  }

  void _setTextToInput(String data) async {
    var replaceInputList = List<String>.filled(widget.length, "");

    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : "";
    }

    if (mounted) {
      setState(() {
        _selectedIndex = data.length;
        _inputList = replaceInputList;
      });
    }
  }

  Widget _buildCursor() {
    return AnimatedBuilder(
      animation: _cursorController!,
      builder: (context, child) {
        return Center(
          child: Opacity(
            opacity: _cursorAnimation.value,
            child: widget.cursor ??
                Text(
                  '|',
                  style: widget.cursorStyle,
                ),
          ),
        );
      },
    );
  }
}
