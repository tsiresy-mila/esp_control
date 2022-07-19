part of 'websocket_bloc.dart';

@immutable
abstract class WebSocketEvent {}

class WebSocketSendDataEvent extends WebSocketEvent {
  final dynamic data;
  WebSocketSendDataEvent(this.data);
}

class WebSocketReceivedEvent extends WebSocketEvent {
  final dynamic data;
  WebSocketReceivedEvent(this.data);
}
