import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/UI/VenderNearMe/vendor_model.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class VNMModal extends StatefulWidget {
  final VendorModel vendor;

  VNMModal({this.vendor});

  @override
  _VNMModalState createState() => _VNMModalState();
}

class _VNMModalState extends State<VNMModal> {
  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: size.height * 0.6,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                      ),
                      height: size.height * 0.3,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                          child: Image.network(
                            widget.vendor.image, fit: BoxFit.cover, alignment: Alignment.center,))),

                  SizedBox(height: 10,),

                  Text("${widget.vendor.name}", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),),
                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ExpandableText(
                      "${widget.vendor.description}",
                      expandText: 'read more',
                      collapseText: 'show less',
                      maxLines: 5,
                      linkColor: appColor,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          color: Colors.black,
                          letterSpacing: 0.3,
                          wordSpacing: 0.5, fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 20,),
                  Text("Location", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),

                  SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "${widget.vendor.location}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          color: Colors.black,
                          letterSpacing: 0.3,
                          wordSpacing: 0.5, fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 20,),
                  Text("Contact", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                  SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "${widget.vendor.phone}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          color: Colors.black,
                          letterSpacing: 0.3,
                          wordSpacing: 0.5, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 70,)
                ],
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: InkWell(
                onTap: ()=>Navigator.pop(context),
                child: Card(
                  elevation: 50,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.close, color: Colors.white,size: 25,),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 15,
                right: 10,
                child: InkWell(
                  onTap: ()=>Navigator.pop(context, 1),
                  child: Card(
                    elevation: 15,
              color: appColor,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Get Direction", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
              ),
            ),
                )),
            Positioned(
                bottom: 15,
                right: 120,
                child: InkWell(
                  onTap: (){
                    if(widget.vendor.phone != null){
                      _launchURL("tel:${widget.vendor.phone}");
                    }
                    else{
                      EasyLoading.showInfo("Vendor has no contact info on the platform");
                    }
                  },
                  child: Card(
                    elevation: 15,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(Icons.call, size: 30, color: Colors.white,),
              )
            ),
                )),
          ],
        ),
      ),
    );
  }
}
