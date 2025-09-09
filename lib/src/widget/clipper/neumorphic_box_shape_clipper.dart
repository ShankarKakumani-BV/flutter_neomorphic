import 'package:flutter/widgets.dart';

import '../../neumorphic_box_shape.dart';
import '../../shape/rrect_path_provider.dart';

class NeumorphicBoxShapeClipper extends StatelessWidget {
  final NeumorphicBoxShape shape;
  final Widget? child;

  NeumorphicBoxShapeClipper({required this.shape, this.child});

  CustomClipper<Path>? _getClipper(NeumorphicBoxShape shape) {
    return shape.customShapePathProvider;
  }

  @override
  Widget build(BuildContext context) {
    // Use cheaper, shape-specific clippers when possible.
    if (shape.isRect) {
      return ClipRect(child: child);
    }
    if (shape.isCircle) {
      return ClipOval(child: child);
    }
    if (shape.isRoundRect) {
      final borderRadius =
          (shape.customShapePathProvider as RRectPathProvider).borderRadius;
      return ClipRRect(borderRadius: borderRadius, child: child);
    }

    // Fallback to generic path clip for custom/beveled/stadium shapes.
    return ClipPath(
      clipper: _getClipper(this.shape),
      child: child,
    );
  }
}
