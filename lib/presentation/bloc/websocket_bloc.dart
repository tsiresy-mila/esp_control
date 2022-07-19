import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  WebSocketBloc() : super(WebSocketInitial()) {
    final channel = WebSocketChannel.connect(
      Uri.parse(GetStorage().read('websocket_url') ??
          'wss://ws-feed.pro.coinbase.com'),
    );
    channel.stream.listen((event) {
      add(WebSocketReceivedEvent(event));
    }, onError: (error) {}, onDone: () {});
    on<WebSocketSendDataEvent>((event, emit) {
      channel.sink.add(event.data);
    });
  }
}
