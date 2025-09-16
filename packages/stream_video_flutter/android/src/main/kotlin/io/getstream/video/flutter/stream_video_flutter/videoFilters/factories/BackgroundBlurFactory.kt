package io.getstream.video.flutter.stream_video_flutter.videoFilters.factories
import android.graphics.Bitmap
import io.getstream.webrtc.flutter.videoEffects.VideoFrameProcessor
import io.getstream.webrtc.flutter.videoEffects.VideoFrameProcessorFactoryInterface
import io.getstream.video.flutter.stream_video_flutter.videoFilters.common.BitmapVideoFilter
import io.getstream.video.flutter.stream_video_flutter.videoFilters.common.VideoFrameProcessorWithBitmapFilter
/**
 * No-op version of BackgroundBlurFactory.
 * Keeps the same API but does nothing to the frame (no RenderScript, no MLKit).
 */
class BackgroundBlurFactory(
  private val blurIntensity: BlurIntensity = BlurIntensity.MEDIUM,
  private val foregroundThreshold: Double = DEFAULT_FOREGROUND_THRESHOLD,
) : VideoFrameProcessorFactoryInterface {
  override fun build(): VideoFrameProcessor {
    // Return a pass-through filter (does nothing)
    return VideoFrameProcessorWithBitmapFilter { NoopBackgroundBlurFilter() }
  }
}
private class NoopBackgroundBlurFilter : BitmapVideoFilter() {
  override fun applyFilter(videoFrameBitmap: Bitmap) {
    // no-op: leave the original frame untouched
  }
}
/**
 * Keep enum & constants for binary/source compatibility with call sites.
 */
enum class BlurIntensity(val radius: Int) {
  LIGHT(5),
  MEDIUM(10),
  HEAVY(15),
}
private const val DEFAULT_FOREGROUND_THRESHOLD: Double = 0.999