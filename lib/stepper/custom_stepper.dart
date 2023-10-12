import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.texts,
    Color? activeColor,
    Color? inactiveColor,
    double? width,
    double? height,
    double? borderWidth,
    double? circleSize,
    double? fontSize,
    FontWeight? fontWeight,
  })  : activeColor = activeColor ?? const Color(0xff222222),
        inactiveColor = inactiveColor ?? const Color(0xffcacaca),
        width = width ?? double.infinity,
        height = height ?? 80,
        borderWidth = borderWidth ?? 3.0,
        circleSize = circleSize ?? 7.0,
        fontSize = fontSize ?? 14,
        fontWeight = fontWeight ?? FontWeight.bold;

  final int steps;
  final int currentStep;
  final List<String> texts;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double height;
  final double borderWidth;
  final double circleSize;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: StepperPainter(
          steps: steps,
          currentStep: currentStep,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          borderWidth: borderWidth,
          circleSize: circleSize,
          texts: texts,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class StepperPainter extends CustomPainter {
  StepperPainter({
    required this.steps,
    required this.currentStep,
    required this.activeColor,
    required this.inactiveColor,
    required this.borderWidth,
    required this.circleSize,
    required this.texts,
    required this.fontSize,
    required this.fontWeight,
  });

  final int steps;
  final int currentStep;
  final Color activeColor;
  final Color inactiveColor;
  final double borderWidth;
  final double circleSize;
  final List<String> texts;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  void paint(Canvas canvas, Size size) {
    double stepWidth = size.width / (steps + 1);

    for (int i = 1; i < steps; i++) {
      canvas.drawLine(
        Offset(i * stepWidth, size.height / 7),
        Offset((i + 1) * stepWidth, size.height / 7),
        Paint()
          ..color = i < currentStep ? activeColor : inactiveColor
          ..strokeWidth = borderWidth,
      );
    }

    for (int i = 1; i <= steps; i++) {
      canvas.drawCircle(
        Offset(i * stepWidth, size.height / 7),
        circleSize,
        Paint()
          ..color = i <= currentStep ? activeColor : inactiveColor
          ..style = PaintingStyle.fill,
      );

      final textSpan = TextSpan(
        text: texts[i - 1],
        style: TextStyle(
          color: i <= currentStep ? activeColor : inactiveColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      final offset = Offset(
        i * stepWidth - textPainter.width / 2,
        size.height / 7 + circleSize + 5,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
