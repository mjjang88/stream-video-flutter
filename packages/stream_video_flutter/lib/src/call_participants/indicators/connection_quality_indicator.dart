import 'package:flutter/material.dart';

import '../../../stream_video_flutter.dart';

/// Widget used to indicate the connection quality of a given participant.
class StreamConnectionQualityIndicator extends StatelessWidget {
  /// Creates a new instance of [StreamConnectionQualityIndicator].
  const StreamConnectionQualityIndicator({
    super.key,
    required this.connectionQuality,
    this.activeColor,
    this.inactiveColor,
  });

  /// The connection quality of the participant.
  final SfuConnectionQuality connectionQuality;

  /// The color of an active connection quality level.
  final Color? activeColor;

  /// The color of an inactive connection quality level.
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final theme = StreamVideoTheme.of(context).callParticipantTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.85),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CustomPaint(
            size: const Size.square(24),
            painter: _ConnectionQualityIndicatorPainter(
              connectionQuality: connectionQuality,
              activeColor: activeColor ?? theme.connectionLevelActiveColor,
              inactiveColor:
                  inactiveColor ?? theme.connectionLevelInactiveColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// Painter widget for the connection quality indicator widget.
class _ConnectionQualityIndicatorPainter extends CustomPainter {
  /// Constructor for creating a [_ConnectionQualityIndicatorPainter].
  const _ConnectionQualityIndicatorPainter({
    required this.connectionQuality,
    required this.activeColor,
    required this.inactiveColor,
  });

  /// The connection quality of the participant.
  final SfuConnectionQuality connectionQuality;

  /// The color of an active connection quality level.
  final Color activeColor;

  /// The color of an inactive connection quality level.
  final Color inactiveColor;

  @override
  void paint(Canvas canvas, Size size) {
    final inactivePaint = Paint()
      ..color = inactiveColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 3; i++) {
      final offsetLeft = 7 + i * 5.0;
      final offsetTop = 14 - i * 3.0;
      final connectionLevel = _getConnectionLevel();

      canvas.drawLine(
        Offset(offsetLeft, offsetTop),
        Offset(offsetLeft, 16),
        connectionLevel > i ? activePaint : inactivePaint,
      );
    }
  }

  int _getConnectionLevel() {
    switch (connectionQuality) {
      case SfuConnectionQuality.poor:
        return 1;
      case SfuConnectionQuality.good:
        return 2;
      case SfuConnectionQuality.excellent:
        return 3;
      case SfuConnectionQuality.unspecified:
        return 0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
