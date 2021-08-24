import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/MyOrders.dart';
import 'package:treva_shop_flutter/UI/Auction/my_auction.dart';
import 'package:treva_shop_flutter/UI/OrderRequest/my_orders.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class PaymentWeb extends StatefulWidget {
  final String initUrl;
  final String where;

  PaymentWeb({this.initUrl, this.where});

  @override
  _PaymentWebState createState() => _PaymentWebState();
}

class _PaymentWebState extends State<PaymentWeb> {
  void failed() {
    Navigator.pop(context);
    EasyLoading.showError("Payment Unsuccessful");
  }

  void unknown() {
    Navigator.pop(context);
    EasyLoading.showError("Error Occur during Payment processing");
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    void success() {
      if (widget.where == "cart") {
        _pro.cart.clear();
        _pro.deletefromDisk('cart');
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => order()));
      } else if (widget.where == 'auction') {
        Navigator.pop(context);
        Navigator.pop(context);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAuctionSales()));
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyOrder()));
        EasyLoading.showSuccess("Payment Successful");
      }

    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "Processing Payment",
          style: auctionHeader,
        ),
        leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.initUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains('thank-you')) {
              success();
            }

            if (request.url.contains('payment-error')) {
              failed();
            }

            if (request.url.contains('total-error')) {
              unknown();
            }

            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
