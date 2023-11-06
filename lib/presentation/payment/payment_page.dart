import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/payment/widgets/success_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String invoiceUrl;
  final String id;
  const PaymentPage({
    Key? key,
    required this.invoiceUrl,
    required this.id,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController? _controller;
  Timer? _timer;
  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        Colors.black,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {},
          onProgress: (int progress) async {},
          onPageStarted: (String invoiceUrl) {},
          onPageFinished: (String invoiceUrl) {},
          onWebResourceError: (WebResourceError error) {
            log('error:${error.description}|${error.errorCode}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            if (request.url.contains('accounts')) {
              context.read<CartBloc>().add(const CartEvent.started());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SuccessPage();
                  },
                ),
              );
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.invoiceUrl));

    const durSec = Duration(seconds: 5);
    _timer = Timer.periodic(durSec, (timer) {
      // context.read<OrderDetailBloc>().add(
      //       OrderDetailEvent.getOrderDetail(
      //         widget.id,
      //       ),
      //     );
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller!),
      // BlocListener<OrderDetailBloc, OrderDetailState>(
      //   listener: (context, state) {
      //     state.maybeWhen(
      //       orElse: () {},
      //       success: (response) {
      //         context.read<CartBloc>().add(
      //               const CartEvent.started(),
      //             );
      //         if (response.data.attributes.status == 'packaging') {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) {
      //                 return const SuccessPage();
      //               },
      //             ),
      //           );
      //         } else if (response.data.attributes.status == 'failed') {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) {
      //                 return const FailedPage();
      //               },
      //             ),
      //           );
      //         }
      //       },
      //     );
      //   },
      //   child: WebViewWidget(controller: _controller!),
      // ),
    );
  }
}
