import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../KeepAliveWrapper.dart';

class WebView extends StatefulWidget {

  const WebView({super.key});

  @override
  State<StatefulWidget> createState() {
    return WebViewState();
  }

}

class WebViewState extends State<WebView> {
  ///控制正在加载的显示
  var _isHide = true;

  @override
  Widget build(BuildContext context) {
    print("build");
    var args = jsonDecode(ModalRoute.of(context)!.settings.arguments.toString());
    var url = args["url"];

    return Scaffold(
        appBar: AppBar(
          title: Text(args["title"]),
        ),
        body: Stack(
          children: [
            //加载提示
            Offstage(
              offstage: /*!_isHide*/false,//是否显示
              child:  Center(
                // 圆形进度条直径指定为100
                  child:SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation(Colors.green),
                      strokeWidth: 5,
                    ),
                  )
              ),
            ),
            Offstage(
                offstage: /*_isHide*/false,
                child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setBackgroundColor(const Color(0x00000000))
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onProgress: (int progress) {
                            // Update loading bar.
                            print("progress=$progress");
                            if(progress == 100){
                              //onPageFinished();
                            }
                          },
                          onPageStarted: (String url) {
                            print("onPageStarted");

                          },
                          onPageFinished: (String url) {
                            print("onPageFinished");
                            ///会一直刷新
                          /*  setState(() {
                              _isHide = false;
                            });*/
                          },
                          onWebResourceError: (WebResourceError error) {},
                          onNavigationRequest: (NavigationRequest request) {
                            //拦截url
                            if (request.url.startsWith('https://www.youtube.com/')) {
                              return NavigationDecision.prevent;
                            }
                            return NavigationDecision.navigate;
                          },
                        ),
                      )
                      ..loadRequest(Uri.parse(url)
                      )
                )
               )
          ]
         )
        );
  }

}
