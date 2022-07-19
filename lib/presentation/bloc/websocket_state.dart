part of 'websocket_bloc.dart';

@immutable
abstract class WebSocketState {}

class WebSocketInitial extends WebSocketState {}

class WebSocketOnDataState extends WebSocketState {
  final dynamic data;
  WebSocketOnDataState(this.data);
}
