package io.getstream.video.flutter.stream_video_flutter.videoFilters.common
import android.graphics.Bitmap
import android.graphics.Matrix
class SegmentationMask
fun newSegmentationMaskMatrix(
  source: Bitmap,
  segmentationMask: SegmentationMask,
): Matrix = Matrix()
enum class Segment { FOREGROUND, BACKGROUND }
fun copySegment(
  segment: Segment,
  source: Bitmap,
  destination: Bitmap,
  segmentationMask: SegmentationMask,
  confidenceThreshold: Double,
) {
  // no-op
}