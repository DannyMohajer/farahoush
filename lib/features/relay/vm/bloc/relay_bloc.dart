import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:farahoush/core/services/mqttt_service.dart';
import 'package:farahoush/features/relay/model/relay.dart';

part 'relay_event.dart';
part 'relay_state.dart';

class RelayBloc extends Bloc<RelayEvent, RelayState> {
  final MqttService _mqttService;
  final List<RelayModel> _relays = [];
  late StreamSubscription _mqttSubscription;

  RelayBloc({required MqttService mqttService})
    : _mqttService = mqttService,
      super(RelayInitial()) {
    on<ConnectMqttEvent>(_onConnect);
    on<DisconnectMqttEvent>(_onDisconnect);
    on<ToggleRelayEvent>(_onToggleRelay);
    on<ActivateTimerRelayEvent>(_onActivateTimerRelay);
    on<RelayStatusUpdateEvent>(_onRelayStatusUpdate);

    // Subscribe to MQTT updates
    _mqttSubscription = _mqttService.messageStream.listen(_processMessage);
  }

  Future<void> _onConnect(
    ConnectMqttEvent event,
    Emitter<RelayState> emit,
  ) async {
    emit(RelayConnecting());

    final connected = await _mqttService.connect();
    if (connected) {
      _mqttService.subscribeToUpdates();
      emit(RelayConnected(relays: _relays));
    } else {
      emit(RelayConnectionFailed(message: 'Failed to connect to MQTT broker'));
    }
  }

  Future<void> _onDisconnect(
    DisconnectMqttEvent event,
    Emitter<RelayState> emit,
  ) async {
    _mqttService.disconnect();
    emit(RelayDisconnected());
  }

  Future<void> _onToggleRelay(
    ToggleRelayEvent event,
    Emitter<RelayState> emit,
  ) async {
    // Create topic for specific relay
    final topic = 'relay/${event.relayId}/${event.relayNumber}';

    // Publish the state command (ON/OFF)
    final message = event.state ? 'ON' : 'OFF';
    _mqttService.publish(topic, message);

    // We'll wait for the status update via the MQTT subscription
  }

  Future<void> _onActivateTimerRelay(
    ActivateTimerRelayEvent event,
    Emitter<RelayState> emit,
  ) async {
    // Create topic for specific relay timer
    final topic = 'relay/${event.relayId}/${event.relayNumber}/timer';

    // Publish the timer duration
    final message = event.duration.toString();
    _mqttService.publish(topic, message);

    // We'll wait for the status update via the MQTT subscription
  }

  Future<void> _onRelayStatusUpdate(
    RelayStatusUpdateEvent event,
    Emitter<RelayState> emit,
  ) async {
    // Update local state and emit status change
    emit(
      RelayStatusChanged(
        relayId: event.relayId,
        relayNumber: event.relayNumber,
        state: event.state,
      ),
    );
  }

  void _processMessage(Map<String, dynamic> data) {
    // Process incoming MQTT messages
    final topic = data['topic'] as String;
    final message = data['message'] as String;

    // Example topic format: relay/123456/1 (for relay ID 123456, number 1)
    if (topic.startsWith('relay/')) {
      final parts = topic.split('/');
      if (parts.length >= 3) {
        final relayId = parts[1];
        final relayNumber = int.tryParse(parts[2]) ?? 0;

        if (message.toUpperCase() == 'ON') {
          add(
            RelayStatusUpdateEvent(
              relayId: relayId,
              relayNumber: relayNumber,
              state: true,
            ),
          );
        } else if (message.toUpperCase() == 'OFF') {
          add(
            RelayStatusUpdateEvent(
              relayId: relayId,
              relayNumber: relayNumber,
              state: false,
            ),
          );
        }
      }
    }
  }

  void updateRelays(List<RelayModel> relays) {
    _relays.clear();
    _relays.addAll(relays);

    if (state is RelayConnected) {
      emit(RelayConnected(relays: _relays));
    }
  }

  @override
  Future<void> close() {
    _mqttSubscription.cancel();
    _mqttService.disconnect();
    return super.close();
  }
}
