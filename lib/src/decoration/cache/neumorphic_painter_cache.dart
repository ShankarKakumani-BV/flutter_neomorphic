import '../../../flutter_neumorphic.dart';
import 'abstract_neumorphic_painter_cache.dart';

class NeumorphicPainterCache extends AbstractNeumorphicEmbossPainterCache {
  @override
  Color generateShadowDarkColor(
      {required Color color, required double intensity}) {
    return NeumorphicColors.decorationDarkColor(color, intensity: intensity);
  }

  @override
  Color generateShadowLightColor(
      {required Color color, required double intensity}) {
    return NeumorphicColors.decorationWhiteColor(color, intensity: intensity);
  }

  @override
  void updateTranslations() {
    //no-op, used only for emboss
  }

  @override
  Rect updateLayerRect({required Offset newOffset, required Size newSize}) {
    // Compute a conservative padding that fully contains the blurred, translated shadows.
    // This avoids allocating a massive 3x layer while preserving identical visuals.
    const double maxDepth = Neumorphic.MAX_DEPTH; // maximum possible depth
    const double blurSigmaToExtent = 3.0; // ~3*sigma covers Gaussian blur
    const double safety = 2.0; // small extra to avoid precision clipping

    final double blurPad = maxDepth * blurSigmaToExtent;
    final double movePad =
        Offset(lightSource.dx, lightSource.dy).distance * maxDepth;
    final double pad = blurPad + movePad + safety; // ~90-95 px worst-case

    return (newOffset & newSize).inflate(pad);
  }
}
