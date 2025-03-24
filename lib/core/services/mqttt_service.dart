import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/foundation.dart';

class MqttService {
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final String _topic;
  final ValueNotifier<MqttConnectionState> connectionStateNotifier =
      ValueNotifier(MqttConnectionState.disconnected);

  // Stream controller for received messages
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;

  MqttService({
    required String identifier,
    required String host,
    required String topic,
  }) : _identifier = identifier,
       _host = host,
       _topic = topic;

  Future<bool> connect() async {
    _client = MqttServerClient(_host, _identifier);
    _client!.logging(on: false);
    _client!.keepAlivePeriod = 60;
    _client!.onDisconnected = _onDisconnected;
    _client!.onConnected = _onConnected;
    _client!.onSubscribed = _onSubscribed;
    _client!.pongCallback = _pong;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic('willtopic')
        .withWillMessage('Disconnected!')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    _client!.connectionMessage = connMessage;

    try {
      await _client!.connect();
      if (_client!.connectionStatus!.state == MqttConnectionState.connected) {
        _subscribe();
        return true;
      } else {
        _client!.disconnect();
        return false;
      }
    } on SocketException {
      _client!.disconnect();
      return false;
    } catch (e) {
      _client!.disconnect();
      return false;
    }
  }

  void _subscribe() {
    _client!.subscribe('$_topic/#', MqttQos.atMostOnce);
  }

  void _onConnected() {
    connectionStateNotifier.value = MqttConnectionState.connected;
  }

  void _onDisconnected() {
    connectionStateNotifier.value = MqttConnectionState.disconnected;
    _messageController.add({'status': 'disconnected'});
  }

  void _onSubscribed(String topic) {
    // Called when subscription is successful
  }

  void _pong() {
    // Called when a ping response is received
  }

  void _handleMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    final MqttPublishMessage message =
        messages[0].payload as MqttPublishMessage;
    final String payload = MqttPublishPayload.bytesToStringAsString(
      message.payload.message,
    );
    final String topic = messages[0].topic;

    _messageController.add({'topic': topic, 'message': payload});
  }

  bool publish(String topic, String message) {
    if (_client?.connectionStatus?.state != MqttConnectionState.connected) {
      return false;
    }

    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    _client!.publishMessage(
      topic,
      MqttQos.atLeastOnce,
      builder.payload!,
      retain: true,
    );

    return true;
  }

  void subscribeToUpdates() {
    _client?.updates?.listen(_handleMessage);
  }

  void disconnect() {
    _client?.disconnect();
    _messageController.close();
  }
}
