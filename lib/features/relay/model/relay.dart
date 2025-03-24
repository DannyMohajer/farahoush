import 'package:flutter/widgets.dart';

class RelayModel {
  final String id;
  final String? deviceName;
  final String? serialNumber;
  final IconData? icon;
  final RelayType? relayType;
  final bool? quickAccess;

  RelayModel({
    required this.id,
    required this.deviceName,
    required this.serialNumber,
    required this.icon,
    this.quickAccess,
    this.relayType,
  });

  RelayModel copyWith({
    String? id,
    String? deviceName,
    String? serialNumber,
    IconData? icon,
    bool? quickAccess,
    RelayType? relayType,
  }) {
    return RelayModel(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      serialNumber: serialNumber ?? this.serialNumber,
      icon: icon ?? this.icon,
      quickAccess: quickAccess ?? this.quickAccess,
      relayType: relayType ?? this.relayType,
    );
  }
}

sealed class RelayType {
  const RelayType();
}

class SingleChannelRelay extends RelayType {
  final String? relayName;
  final int? relayNumber;
  final RelayMode? relayMode;

  SingleChannelRelay({
    required this.relayName,
    required this.relayNumber,
    required this.relayMode,
  });
}

class TwoChannelRelay extends RelayType {
  final String? relayName;
  final int? firstRelayNumber;
  final int? secondRelayNumber;

  TwoChannelRelay({
    required this.relayName,
    required this.firstRelayNumber,
    required this.secondRelayNumber,
  });
}

sealed class RelayMode {
  const RelayMode();
}

class OnOffRelayMode extends RelayMode {
  const OnOffRelayMode();
}

class TimerRelayMode extends RelayMode {
  final TimerType timerType;

  const TimerRelayMode(this.timerType);
}

class TimerType {
  final double? timerValue;

  TimerType(this.timerValue);
}