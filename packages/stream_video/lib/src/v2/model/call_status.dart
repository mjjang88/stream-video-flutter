import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../coordinator/models/coordinator_models.dart';
import 'drop_reason.dart';

@immutable
abstract class CallStatus extends Equatable {
  const CallStatus();

  factory CallStatus.idle() {
    return CallStatusIdle();
  }

  factory CallStatus.created() {
    return CallStatusCreated();
  }

  factory CallStatus.outgoing({
    bool acceptedByCallee = false,
  }) {
    return CallStatusOutgoing(acceptedByCallee: acceptedByCallee);
  }

  factory CallStatus.incoming({
    bool acceptedByMe = false,
  }) {
    return CallStatusIncoming(acceptedByMe: acceptedByMe);
  }

  factory CallStatus.joined(CallCredentials credentials) {
    return CallStatusJoined(credentials: credentials);
  }

  factory CallStatus.connected() {
    return CallStatusConnected();
  }

  factory CallStatus.drop(DropReason reason) {
    return CallStatusDrop(reason: reason);
  }

  @override
  List<Object?> get props => [];

  bool get isIdle => this is CallStatusIdle;

  bool get isActive => this is CallStatusActive;

  bool get isJoinable => this is CallStatusJoinable;

  bool get isJoined => this is CallStatusJoined;

  bool get isConnected => this is CallStatusConnected;
}

class CallStatusIdle extends CallStatus {
  factory CallStatusIdle() {
    return _instance;
  }
  const CallStatusIdle._internal();
  static const CallStatusIdle _instance = CallStatusIdle._internal();
  @override
  String toString() {
    return 'Idle';
  }
}

abstract class CallStatusActive extends CallStatus {
  const CallStatusActive();
}

abstract class CallStatusJoinable extends CallStatusActive {
  const CallStatusJoinable();
}

class CallStatusCreated extends CallStatusJoinable {
  factory CallStatusCreated() {
    return _instance;
  }
  const CallStatusCreated._internal();
  static const CallStatusCreated _instance = CallStatusCreated._internal();
  @override
  String toString() {
    return 'Created';
  }
}

class CallStatusOutgoing extends CallStatusJoinable {
  const CallStatusOutgoing({required this.acceptedByCallee});

  final bool acceptedByCallee;

  @override
  List<Object?> get props => [acceptedByCallee];

  @override
  String toString() {
    return 'Outgoing{acceptedByCallee: $acceptedByCallee}';
  }
}

class CallStatusIncoming extends CallStatusJoinable {
  const CallStatusIncoming({required this.acceptedByMe});

  final bool acceptedByMe;

  @override
  List<Object?> get props => [acceptedByMe];

  @override
  String toString() {
    return 'Outgoing{acceptedByMe: $acceptedByMe}';
  }
}

class CallStatusJoined extends CallStatusActive {
  const CallStatusJoined({required this.credentials});

  final CallCredentials credentials;

  @override
  List<Object?> get props => [credentials];

  @override
  String toString() {
    return 'Joined{credentials: $credentials}';
  }
}

class CallStatusConnected extends CallStatusActive {
  factory CallStatusConnected() {
    return _instance;
  }
  const CallStatusConnected._internal();
  static const CallStatusConnected _instance = CallStatusConnected._internal();
  @override
  String toString() {
    return 'Connected';
  }
}

class CallStatusDrop extends CallStatus {
  const CallStatusDrop({required this.reason});

  final DropReason reason;

  @override
  List<Object?> get props => [reason];

  @override
  String toString() {
    return 'Drop';
  }
}
