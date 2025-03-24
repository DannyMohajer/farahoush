part of 'relay_bloc.dart';

abstract class RelayEvent {}

class ConnectMqttEvent extends RelayEvent {
  final String clientId;
  ConnectMqttEvent({required this.clientId});
}

class DisconnectMqttEvent extends RelayEvent {}

class ToggleRelayEvent extends RelayEvent {
  final String relayId;
  final int relayNumber;
  final bool state;

  ToggleRelayEvent({
    required this.relayId,
    required this.relayNumber,
    required this.state,
  });
}

class ActivateTimerRelayEvent extends RelayEvent {
  final String relayId;
  final int relayNumber;
  final double duration;

  ActivateTimerRelayEvent({
    required this.relayId,
    required this.relayNumber,
    required this.duration,
  });
}

class RelayStatusUpdateEvent extends RelayEvent {
  final String relayId;
  final int relayNumber;
  final bool state;

  RelayStatusUpdateEvent({
    required this.relayId,
    required this.relayNumber,
    required this.state,
  });
}
