import 'package:esp_control/presentation/bloc/websocket_bloc.dart';
import 'package:esp_control/presentation/pages/home.dart';
import 'package:esp_control/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  setupDependency();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 CONTROLLER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return MultiBlocProvider(providers: [
          BlocProvider(create: (context) => sl.get<WebSocketBloc>())
        ], child: child ?? Container());
      },
      home: const HomePage(),
    );
  }
}
