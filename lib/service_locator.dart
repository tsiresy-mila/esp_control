import 'package:esp_control/presentation/bloc/websocket_bloc.dart';
import 'package:get_it/get_it.dart';

var sl = GetIt.instance;

void setupDependency() {
  sl.registerLazySingleton<WebSocketBloc>(() => WebSocketBloc());
}
