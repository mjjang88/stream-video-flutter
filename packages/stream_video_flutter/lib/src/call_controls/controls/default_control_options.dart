import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

/// Builds the default set of call control options.
List<Widget> defaultCallControlOptions({
  required Call call,
  required CallParticipantState localParticipant,
  VoidCallback? onLeaveCallTap,
}) {
  return [
    ToggleSpeakerphoneOption(call: call),
    ToggleCameraOption(call: call, localParticipant: localParticipant),
    ToggleMicrophoneOption(call: call, localParticipant: localParticipant),
    FlipCameraOption(call: call, localParticipant: localParticipant),
  ];
}
