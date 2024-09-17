import 'package:chat/theme/custom_color.dart';
import 'package:flutter/material.dart';

enum CusStepState {
  indexed,
  editing,
  complete,
  disabled,
  error,
}

enum CusStepperType {
  horizontal,
}

@immutable
class ControlsDetails {
  const ControlsDetails({
    required this.currentStep,
    required this.stepIndex,
    this.onStepCancel,
    this.onStepContinue,
  });
  final int currentStep;
  final int stepIndex;
  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;
  bool get isActive => currentStep == stepIndex;
}

typedef ControlsWidgetBuilder = Widget Function(
    BuildContext context, ControlsDetails details);

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kStepSize = 24.0;
const double _kTriangleHeight = _kStepSize * 0.866025;

@immutable
class CusStep {
  const CusStep({
    required this.title,
    this.subtitle,
    required this.content,
    this.state = CusStepState.indexed,
    this.isActive = false,
    this.label,
  });

  final Widget title;

  final Widget? subtitle;

  final Widget content;

  final CusStepState state;

  final bool isActive;

  final Widget? label;
}

class CusStepper extends StatefulWidget {
  const CusStepper({
    super.key,
    required this.steps,
    this.physics,
    this.type = CusStepperType.horizontal,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.elevation,
    this.margin,
    this.lineColor = Colors.grey,
  }) : assert(0 <= currentStep && currentStep < steps.length);

  final List<CusStep> steps;

  final ScrollPhysics? physics;

  final CusStepperType type;

  final int currentStep;

  final ValueChanged<int>? onStepTapped;

  final VoidCallback? onStepContinue;

  final VoidCallback? onStepCancel;

  final ControlsWidgetBuilder? controlsBuilder;

  final double? elevation;

  final EdgeInsetsGeometry? margin;

  final Color lineColor;

  @override
  State<CusStepper> createState() => _CusStepperState();
}

class _CusStepperState extends State<CusStepper> with TickerProviderStateMixin {
  late List<GlobalKey> _keys;
  final Map<int, CusStepState> _oldStates = <int, CusStepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i += 1) {
      _oldStates[i] = widget.steps[i].state;
    }
  }

  @override
  void didUpdateWidget(CusStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1) {
      _oldStates[i] = oldWidget.steps[i].state;
    }
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  bool _isLabel() {
    for (final CusStep step in widget.steps) {
      if (step.label != null) {
        return true;
      }
    }
    return false;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? 1.0 : 0.0,
      height: 16.0,
      color: widget.lineColor,
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final CusStepState state =
        oldState ? _oldStates[index]! : widget.steps[index].state;
    final bool isDarkActive = _isDark() && widget.steps[index].isActive;
    switch (state) {
      case CusStepState.indexed:
      case CusStepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive
              ? _kStepStyle.copyWith(color: Colors.black87)
              : _kStepStyle,
        );
      case CusStepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case CusStepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case CusStepState.error:
        return const Text('!', style: _kStepStyle);
    }
  }

  Color _circleColor(int index, int indexActive) {
    if (!_isDark()) {
      return indexActive >= index ? CustomColor.primary : Colors.black38;
    } else {
      return indexActive >= index ? CustomColor.primary : Colors.black38;
    }
  }

  Widget _buildCircle(int index, bool oldState, int indexActive) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index, indexActive),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: index > indexActive
              ? _buildCircleChild(index,
                  oldState && widget.steps[index].state == CusStepState.error)
              : Text(''),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height:
              _kTriangleHeight, // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(
                  0.0, 0.8), // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(index,
                  oldState && widget.steps[index].state != CusStepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index, int indexActive) {
    if (widget.steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true, indexActive),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.steps[index].state == CusStepState.error
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.steps[index].state != CusStepState.error) {
        return _buildCircle(index, false, indexActive);
      } else {
        return _buildTriangle(index, false);
      }
    }
  }

  Widget _buildVerticalControls(int stepIndex) {
    if (widget.controlsBuilder != null) {
      return widget.controlsBuilder!(
        context,
        ControlsDetails(
          currentStep: widget.currentStep,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel,
          stepIndex: stepIndex,
        ),
      );
    }

    final Color cancelColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    const OutlinedBorder buttonShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)));
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: double.infinity,
      child: TextButton(
        onPressed: widget.onStepContinue,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            return states.contains(WidgetState.disabled) ? null : Colors.white;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            return _isDark() || states.contains(WidgetState.disabled)
                ? null
                : colorScheme.primary;
          }),
          padding:
              const WidgetStatePropertyAll<EdgeInsetsGeometry>(buttonPadding),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(buttonShape),
        ),
        child: Text('${stepIndex == 2 ? 'Finish' : 'Next'}'),
      ),
    );
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case CusStepState.indexed:
      case CusStepState.editing:
      case CusStepState.complete:
        return textTheme.bodyLarge!;
      case CusStepState.disabled:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case CusStepState.error:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case CusStepState.indexed:
      case CusStepState.editing:
      case CusStepState.complete:
        return textTheme.bodySmall!;
      case CusStepState.disabled:
        return textTheme.bodySmall!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case CusStepState.error:
        return textTheme.bodySmall!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _labelStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case CusStepState.indexed:
      case CusStepState.editing:
      case CusStepState.complete:
        return textTheme.bodyLarge!;
      case CusStepState.disabled:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case CusStepState.error:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
        if (widget.steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].subtitle!,
            ),
          ),
      ],
    );
  }

  Widget _buildLabelText(int index) {
    if (widget.steps[index].label != null) {
      return AnimatedDefaultTextStyle(
        style: _labelStyle(index),
        duration: kThemeAnimationDuration,
        child: widget.steps[index].label!,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildHorizontal() {
    int indexActive = 0;
    for (int i = 0; i < widget.steps.length; i += 1) {
      if (widget.steps[i].isActive == true) {
        indexActive = i;
      }
    }
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        InkResponse(
          onTap: widget.steps[i].state != CusStepState.disabled
              ? () {
                  widget.onStepTapped?.call(i);
                }
              : null,
          canRequestFocus: widget.steps[i].state != CusStepState.disabled,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: _isLabel() ? 104.0 : 72.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (widget.steps[i].label != null)
                      const SizedBox(
                        height: 24.0,
                      ),
                    Center(child: _buildIcon(i, indexActive)),
                    if (widget.steps[i].label != null)
                      SizedBox(
                        height: 24.0,
                        child: _buildLabelText(i),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 2.5,
              color: indexActive > i ? widget.lineColor : Colors.black45,
            ),
          ),
      ],
    ];

    final List<Widget> stepPanels = <Widget>[];
    for (int i = 0; i < widget.steps.length; i += 1) {
      stepPanels.add(
        Visibility(
          maintainState: true,
          visible: i == widget.currentStep,
          child: widget.steps[i].content,
        ),
      );
    }

    return Column(
      children: <Widget>[
        Material(
          // elevation: widget.elevation ?? 2,
          child: Container(
            margin:
                const EdgeInsets.only(left: 64, right: 64, top: 24, bottom: 0),
            child: Column(children: [
              Row(
                children: children,
              ),
            ]),
          ),
        ),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSize(
                  curve: Curves.fastOutSlowIn,
                  duration: kThemeAnimationDuration,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: stepPanels),
                ),
                _buildVerticalControls(widget.currentStep),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<Stepper>() != null) {
        throw FlutterError(
          'Steppers must not be nested.\n'
          'The material specification advises that one should avoid embedding '
          'steppers within steppers. '
          'https://material.io/archive/guidelines/components/steppers.html#steppers-usage',
        );
      }
      return true;
    }());
    switch (widget.type) {
      case CusStepperType.horizontal:
        return _buildHorizontal();
    }
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true;
  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
