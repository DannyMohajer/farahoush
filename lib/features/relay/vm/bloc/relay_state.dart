part of 'relay_bloc.dart';

abstract class RelayState {}

class RelayInitial extends RelayState {}

class RelayConnecting extends RelayState {}

class RelayConnected extends RelayState {
  final List<RelayModel> relays;
  
  RelayConnected({required this.relays});
}

class RelayConnectionFailed extends RelayState {
  final String message;
  
  RelayConnectionFailed({required this.message});
}

class RelayDisconnected extends RelayState {}

class RelayStatusChanged extends RelayState {
  final String relayId;
  final int relayNumber;
  final bool state;
  
  RelayStatusChanged({
    required this.relayId,
    required this.relayNumber,
    required this.state,
  });
}