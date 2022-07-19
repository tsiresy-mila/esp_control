import 'package:esp_control/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController websocket_url_controller = TextEditingController();
  TextEditingController camera_stream_url_controller = TextEditingController();

  @override
  initState() {
    super.initState();
    var box = GetStorage();
    websocket_url_controller.text = box.read('websocket_url') ?? '';
    camera_stream_url_controller.text = box.read('camera_stream_url') ?? '';
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (ctx) {
              return const HomePage();
            }));
          },
        ),
        title: const Text(
          'Setting',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                var box = GetStorage();
                box.write('websocket_url', websocket_url_controller.text);
                box.write(
                    'camera_stream_url', camera_stream_url_controller.text);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: websocket_url_controller,
                decoration: InputDecoration(
                    hintText: 'WebSocket server url',
                    prefixIcon: const Icon(Icons.signal_wifi_4_bar_sharp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextField(
                  controller: camera_stream_url_controller,
                  decoration: InputDecoration(
                      hintText: 'Camera stream url',
                      prefixIcon: const Icon(Icons.camera_enhance_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
