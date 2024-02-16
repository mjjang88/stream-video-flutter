import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:stream_video/src/models/call_cid.dart';
import 'package:stream_video/src/models/call_credentials.dart';
import 'package:stream_video/src/models/call_metadata.dart';

@immutable
class CallJoinedData with EquatableMixin {
  const CallJoinedData({
    required this.callCid,
    required this.wasCreated,
    required this.metadata,
    required this.credentials,
  });

  final StreamCallCid callCid;
  final bool wasCreated;
  final CallMetadata metadata;
  final CallCredentials credentials;

  @override
  List<Object?> get props => [callCid, wasCreated, metadata, credentials];

  @override
  String toString() {
    return 'CallJoined{callCid: $callCid, wasCreated: $wasCreated, '
        'metadata: $metadata, credentials: $credentials}';
  }
}
