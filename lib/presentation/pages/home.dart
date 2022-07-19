import 'dart:io';

import 'package:esp_control/presentation/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:math' as math;

import '../bloc/websocket_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController? _webViewController;

  void sendData(String data) {
    BlocProvider.of<WebSocketBloc>(context).add(WebSocketSendDataEvent(data));
  }

  @override
  initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocConsumer<WebSocketBloc, WebSocketState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: WebView(
                      onWebViewCreated: (controller) {
                        _webViewController = controller;
                      },
                      zoomEnabled: false,
                      initialUrl: Uri.dataFromString(
                              '<!DOCTYPE html> <html> <head> <title></title> <style> html,body {padding: 0; margin: 0;background-color: black;  width: 100vw; height: 100vh;  } img { width: 100vw; height: 100vh; object-fit: cover; padding: 0; } </style> </head> <body> <img alt="" onerror="this.style.display = \'none\'" src="${GetStorage().read('camera_stream_url') ?? 'http://192.168.88.18:81/stream'}" /> </body> </html>',
                              mimeType: 'text/html')
                          .toString(),
                      javascriptMode: JavascriptMode.unrestricted,
                      backgroundColor: Colors.transparent,
                      debuggingEnabled: false),
                  //decoration: const BoxDecoration(color: Colors.teal),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 200,
                    height: 200,
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          customColors: CustomSliderColors(
                              trackColor: Colors.blue,
                              progressBarColor: Colors.yellow,
                              shadowColor: Colors.yellow),
                          customWidths: CustomSliderWidths(
                              progressBarWidth: 20,
                              trackWidth: 20,
                              shadowWidth: 0)),
                      min: 0,
                      max: 255,
                      onChange: (value) {},
                      onChangeEnd: (v) {
                        sendData('speed-$v');
                      },
                      innerWidget: (value) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'SPEED',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              ),
                              Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 18),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.all(8).copyWith(right: 20),
                    width: 200,
                    height: 200,
                    child: Transform.rotate(
                      angle: math.pi / 4,
                      child: Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Material(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(100)),
                                        child: Ink(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(100))),
                                          child: InkWell(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(100)),
                                            highlightColor: Colors.blue[200],
                                            onTapDown: (details) {
                                              sendData('forward');
                                            },
                                            onTapUp: (details) {
                                              sendData('stop');
                                            },
                                            onTap: () {},
                                            child: Transform.rotate(
                                              angle: (math.pi / 4) + math.pi,
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(100)),
                                        child: Ink(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(100))),
                                          child: InkWell(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(100)),
                                            highlightColor: Colors.yellow[200],
                                            onTapDown: (details) {
                                              sendData('right');
                                            },
                                            onTapUp: (details) {
                                              sendData('stop');
                                            },
                                            onTap: () {},
                                            child: Transform.rotate(
                                              angle: -(math.pi / 4),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Material(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(100)),
                                        child: Ink(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(100))),
                                          child: InkWell(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(100)),
                                            highlightColor: Colors.yellow[200],
                                            onTapDown: (details) {
                                              sendData('left');
                                            },
                                            onTapUp: (details) {
                                              sendData('stop');
                                            },
                                            onTap: () {},
                                            child: Transform.rotate(
                                              angle: math.pi - (math.pi / 4),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(100)),
                                        child: Ink(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(100))),
                                          child: InkWell(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(100)),
                                            highlightColor: Colors.blue[200],
                                            onTapDown: (details) {
                                              sendData('back');
                                            },
                                            onTapUp: (details) {
                                              sendData('stop');
                                            },
                                            onTap: () {},
                                            child: Transform.rotate(
                                              angle: math.pi / 4,
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(100),
                              child: Ink(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(100)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    sendData('led');
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.yellow,
                      ),
                      onPressed: () {
                        _webViewController?.reload();
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.yellow,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (ctx) {
                          return const SettingPage();
                        }));
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
