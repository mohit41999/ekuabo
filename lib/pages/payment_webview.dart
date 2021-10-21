import 'dart:async';
import 'dart:io';

import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/payment_webview_controller.dart';
import 'package:ekuabo/utils/log.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  final _homeController = Get.find<HomeController>();
  final _con = Get.find<PaymentWebViewController>();
  String loadUrl=Get.arguments;

  ProgressView pd=ProgressView(Get.context);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentWebViewController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          actions: [
            NavigationControls(_controller.future),
          ],
        ),
        body:WebView(
        initialUrl: loadUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        onPageStarted: (url){
          if(url.contains("payment_success.php"))
            {
              pd.dismiss();
              Get.back();
            }
          else
           pd.show();
        },
       onPageFinished: (_){
         Get.back();
       },
      ),), initState: (_) {
      if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    },);
  }
}
class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        Log.info("STATE>>>",snapshot.connectionState);
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No back history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  // ignore: deprecated_member_use
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay,color: Colors.white,),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}
