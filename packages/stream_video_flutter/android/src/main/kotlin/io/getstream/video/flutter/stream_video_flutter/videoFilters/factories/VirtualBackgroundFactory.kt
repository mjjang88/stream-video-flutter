package io.getstream.video.flutter.stream_video_flutter.videoFilters.factories
import android.content.Context
import android.graphics.Bitmap
import io.getstream.webrtc.flutter.videoEffects.VideoFrameProcessor
import io.getstream.webrtc.flutter.videoEffects.VideoFrameProcessorFactoryInterface
import io.getstream.video.flutter.stream_video_flutter.videoFilters.common.BitmapVideoFilter
import io.getstream.video.flutter.stream_video_flutter.videoFilters.common.VideoFrameProcessorWithBitmapFilter
/**
 * :흰색_확인_표시: 가상 배경(버추얼 배경) 기능 비활성화 버전 (no-op).
 *  - 안정성 최우선: ML Kit / RenderScript 의존성을 제거하기 위해
 *  - API 모양은 유지하지만, 실제 프레임 변환은 수행하지 않음.
 */
class VirtualBackgroundFactory(
  private val appContext: Context,
  private val backgroundImageUrlString: String,
  private val foregroundThreshold: Double = 0.7,
) : VideoFrameProcessorFactoryInterface {
  override fun build(): VideoFrameProcessor {
    // :흰색_확인_표시: 아무 동작도 하지 않는 패스스루 필터를 반환
    return VideoFrameProcessorWithBitmapFilter {
      object : BitmapVideoFilter() {
        override fun applyFilter(videoFrameBitmap: Bitmap) {
          // no-op (아무 것도 하지 않음)
        }
      }
    }
  }
}