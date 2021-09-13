import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/Payment/payment_web.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAuctionSale extends StatefulWidget {
  const AddAuctionSale({Key key}) : super(key: key);

  @override
  _AddAuctionSaleState createState() => _AddAuctionSaleState();
}

class _AddAuctionSaleState extends State<AddAuctionSale> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  List _data = [];
  PickedFile _image;
  final ImagePicker _picker = ImagePicker();
  bool checkBoxValue = false;
  String auctiontype = "";
  String businessTypeId = "";
  String catId = "";
  final plugin = PaystackPlugin();

  void pickImageFromCamera() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = pickedFile;
    });
    Navigator.pop(context);
  }

  void pickImageFromGallery() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = pickedFile;
    });

    Navigator.pop(context);
  }

  void showImagePickerModal() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 160,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Image Pick Options",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => pickImageFromCamera(),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                "Open camera",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Icon(
                                Icons.camera,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () => pickImageFromGallery(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                "Open Gallery",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }


  void addAuction() async {
    EasyLoading.show(status: "Creating Auction Request");
    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();

    Map<String, String> _data = {
      "user_id": userId,
      "quantity": _quantity.text,
      "category_id": catId.toString(),
      "name": _productName.text,
      "description": _description.text
    };

    final response = http.MultipartRequest(
        'POST', Uri.parse("${base_url}user/create-auction"));

    if (_image != null)
      response.files
          .add(await http.MultipartFile.fromPath("image", _image.path));

    response.fields.addAll(_data);

    response.headers['authorization'] = "Bearer $userToken";

    var streamedResponse = await response.send();
    var res = await http.Response.fromStream(streamedResponse);
    EasyLoading.dismiss();

    if (res.statusCode < 206) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentWeb(
                where: "auction",
                initUrl: json.decode(res.body)['data']['authorization_url'],
              )));
    } else {
      EasyLoading.showError("${json.decode(res.body)['message']}");
    }
  }

  // final _chars =
  //     'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  // Random _rnd = Random();
  //
  // String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
  //     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productName.dispose();
    _description.dispose();
    _quantity.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 10, right: 10, bottom: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                DropdownSearch<Map>(
                  mode: Mode.BOTTOM_SHEET,
                  label: "Category",
                  hint: "Select item category",
                  items: [for (var a in _pro.allcategories) a],
                  itemAsString: (Map u) => u['name'],
                  onChanged: (Map data) {
                    setState(() {
                      if (data != null) {
                        auctiontype = data['name'];
                        catId = data['id'].toString();
                      } else {
                        auctiontype = "";
                        catId = "";
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.4))),
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.transparent,
                      ),
                      child: TextFormField(
                        controller: _productName,
                        validator: (e) {
                          if (_productName.text.isEmpty) {
                            return "Please enter item name";
                          }
                          // else if(!_email.text.contains("@") || !_email.text.contains(".com")){
                          //   return "Please enter a valid email address";
                          // }
                          else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Item name",
                            labelStyle: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Sans',
                                letterSpacing: 0.3,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.4))),
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.transparent,
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        controller: _description,
                        validator: (e) {
                          if (_description.text.isEmpty) {
                            return "Please enter item description";
                          }
                          // else if(!_email.text.contains("@") || !_email.text.contains(".com")){
                          //   return "Please enter a valid email address";
                          // }
                          else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Item description",
                            labelStyle: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Sans',
                                letterSpacing: 0.3,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.4))),
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.transparent,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: _quantity,
                        validator: (e) {
                          if (_quantity.text.isEmpty) {
                            return "Please enter item quantity";
                          }
                          // else if(!_email.text.contains("@") || !_email.text.contains(".com")){
                          //   return "Please enter a valid email address";
                          // }
                          else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Item quantity",
                            labelStyle: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Sans',
                                letterSpacing: 0.3,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600)),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius:
                          BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: Colors.black.withOpacity(0.4))),
                      child: _image == null
                          ? Center(
                        child: Text("Image of Item"),
                      )
                          : Container(
                          width: double.infinity,
                          child: Image.file(
                            File(_image.path),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: TextButton(
                          onPressed: () => showImagePickerModal(),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: appColor,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Checkbox(
                        value: checkBoxValue,
                        activeColor: appColor,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkBoxValue = newValue;
                          });

                        }),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text:
                                  "To successfully place an auction purchase request, you are required to make a down payment of ",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                              children: [
                            TextSpan(
                              text: "GHc 20.",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            )
                          ])),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () async {
                          if (checkBoxValue) {
                            // final res =await  makePayment(context);

                            // if(res == "Success"){
                            //   EasyLoading.show(status: "Sending Request");
                            //   Future.delayed(Duration(seconds: 3));
                            //   EasyLoading.dismiss();
                            // }
                            // else{
                            //   EasyLoading.show(status: "Not Sending Request");
                            // }
                            // await initPayment();
                            addAuction();
                          } else {}
                        },
                        child: Card(
                          color: checkBoxValue
                              ? appColor
                              : Colors.grey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Proceed",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
