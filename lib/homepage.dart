import 'package:animated_button_progress/constants/app_colors.dart';
import 'package:animated_button_progress/constants/extensions.dart';
import 'package:animated_button_progress/constants/image_paths.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:gusto_neumorphic/gusto_neumorphic.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Animation<double> _animation;

  late AnimationController _animationController;
  late AnimationController _splashController;

  late Animation<double> _scaleAnimation;
  bool isPaused = true;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      lowerBound: 0.01,
      vsync: this,
    );

    _splashController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.greyOuter200.withOpacity(0.8),
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // beeping splash
                AnimatedBuilder(
                  animation: _splashController,
                  builder: (context, _) {
                    return Align(
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: SizedBox.square(
                          dimension:
                              context.sizeWidth(context.layout(LayoutEnums.desktop) ? 0.31 : 0.51),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyRing100
                                      .withOpacity(_splashController.value * 0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                //  circle with convex shape
                Align(
                  child: SizedBox.square(
                    dimension: context.sizeWidth(context.layout(LayoutEnums.desktop) ? 0.27 : 0.44),
                    child: Neumorphic(
                      curve: Curves.linear,
                      margin: const EdgeInsets.all(3),
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 12,
                        intensity: 25,
                        lightSource: LightSource.left,
                        oppositeShadowLightSource: true,
                        color: AppColors.greyOuter200,
                      ),
                    ),
                  ),
                ),

                // progress indicator
                Align(
                  child: SizedBox.square(
                    dimension: context.sizeWidth(context.layout(LayoutEnums.desktop) ? 0.27 : 0.44),
                    child: CustomPaint(
                      painter: _CircularProgressIndicatorPainter(
                        valueColor: AppColors.yellow100,
                        value: _animation.value,
                        headValue: 0.2,
                        tailValue: 1.0,
                        offsetValue: 0.0,
                        rotationValue: 0.5,
                        strokeWidth: context.layout(LayoutEnums.desktop) ? 30 : 15,
                        strokeAlign: 0.6,
                        strokeCap: StrokeCap.round,
                        backgroundColor: AppColors.greyRing100.shade200,
                      ),
                    ),
                  ),
                ),

                // inner circle with play icon
                Align(
                  child: InkResponse(
                    // radius: scale,
                    onHover: (value) => false,
                    splashColor: AppColors.greyRing100.withOpacity(_animationController.value),
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    containedInkWell: true,
                    splashFactory: InkRipple.splashFactory,
                    onTap: () {
                      if (_animation.isCompleted) {
                        _animationController.reset();
                        isPaused = true;
                      } else if (_animationController.isAnimating) {
                        _animationController.stop();
                        isPaused = true;
                      } else {
                        _animationController.forward();
                        isPaused = false;
                      }
                      setState(() {});
                    },
                    child: SizedBox.square(
                      dimension:
                          context.sizeWidth(context.layout(LayoutEnums.desktop) ? 0.15 : 0.25),
                      child: Neumorphic(
                        curve: Curves.linear,
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          boxShape: const NeumorphicBoxShape.circle(),
                          depth: 0.5,
                          intensity: 5,
                          lightSource: LightSource.bottomLeft,
                          color: AppColors.greyCenter200.shade200,
                        ),
                        child: _animation.isCompleted
                            ? Image.asset(ImagePaths.cloudDownload)
                            : Icon(
                                isPaused ? Icons.play_arrow_outlined : Icons.pause,
                                size: context.layout(LayoutEnums.desktop) ? 100 : 50,
                                color: AppColors.greyRing200,
                              ),
                      ),
                    ),
                  ),
                ),

                /// downloading text widget
                Padding(
                  padding: EdgeInsets.only(
                      top: context.sizeWidth(context.layout(LayoutEnums.desktop) ? 0.55 : 0.6)),
                  child: Center(
                    child: AutoSizeText(
                      '${(_animation.value * 100).round()}% downloading..',
                      style: const TextStyle(
                        inherit: false,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyCenter100,
                        shadows: [
                          Shadow(
                            color: Colors.black12,
                            offset: Offset(-1, -1),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      minFontSize: 30,
                      maxFontSize: 80,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _CircularProgressIndicatorPainter extends CustomPainter {
  _CircularProgressIndicatorPainter({
    this.backgroundColor,
    required this.valueColor,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
    required this.strokeAlign,
    this.strokeCap,
  })  : arcStart = value != null
            ? _startAngle
            : _startAngle +
                tailValue * 3 / 2 * math.pi +
                rotationValue * math.pi * 2.0 +
                offsetValue * 0.5 * math.pi,
        arcSweep = value != null
            ? clampDouble(value, 0.0, 1.0) * _sweep
            : math.max(headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi, _epsilon);

  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double strokeAlign;
  final double arcStart;
  final double arcSweep;
  final StrokeCap? strokeCap;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Use the negative operator as intended to keep the exposed constant value
    // as users are already familiar with.
    final double strokeOffset = strokeWidth / 2 * -strokeAlign;
    final Offset arcBaseOffset = Offset(strokeOffset, strokeOffset);
    final Size arcActualSize = Size(
      size.width - strokeOffset * 2,
      size.height - strokeOffset * 2,
    );

    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        arcBaseOffset & arcActualSize,
        0,
        _sweep,
        false,
        backgroundPaint,
      );
    }

    if (value == null && strokeCap == null) {
      // Indeterminate
      paint.strokeCap = StrokeCap.square;
    } else {
      // Butt when determinate (value != null) && strokeCap == null;
      paint.strokeCap = strokeCap ?? StrokeCap.butt;
    }

    canvas.drawArc(
      arcBaseOffset & arcActualSize,
      arcStart,
      arcSweep,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.offsetValue != offsetValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth ||
        oldPainter.strokeAlign != strokeAlign ||
        oldPainter.strokeCap != strokeCap;
  }
}

extension LayoutExtension on BuildContext {
  bool layout(LayoutEnums layoutEnums) {
    switch (layoutEnums) {
      case LayoutEnums.mobile:
        return isMobile();
      case LayoutEnums.tablet:
        return isTablet();
      case LayoutEnums.desktop:
        return isDesktop();
    }
  }

  bool isMobile() => MediaQuery.of(this).size.width < 680;

  bool isTablet() => MediaQuery.sizeOf(this).width < 980 && MediaQuery.sizeOf(this).width >= 680;

  bool isDesktop() => MediaQuery.sizeOf(this).width >= 980;
}

enum LayoutEnums {
  mobile,
  tablet,
  desktop,
}
