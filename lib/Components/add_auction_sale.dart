import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
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

  var publicKey = 'pk_test_6b5ee5a7e01626079c5de90d976374d421f7acbc';
  final plugin = PaystackPlugin();

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void initPayment() async {
    final userToken = await UserData.getUserToken();
    final userId = await UserData.getUserId();
    final _data = {
      "email": "enninfrancis47@gmail.com",
      "amount": "1000",
      "user_id": userId.toString()
    };
    http.Response response = await http.post(
        Uri.parse(base_url + "user/payments"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $userToken"},
        body: _data);

    if (response.statusCode < 205) {
      final ref = json.decode(response.body)['data']['reference'];
      final accessCode = json.decode(response.body)['data']['access_code'];
      makePayment(context, ref, accessCode);
    } else {
      // EasyLoading.showInfo(json.decode(response.body)['message']);
      print(response.body);
    }
  }

  makePayment(context, ref, access) async {
    Charge charge = Charge();
    charge.amount = 10000;
    charge.reference = ref;
    charge.currency = "GHS";
    charge.accessCode = access;
    charge.email = 'customer@email.com';
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.selectable,
      // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    return response.message;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    if (_pro.allcategories != null) {
      _data = _pro.allcategories;
    }
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 10, right: 10, bottom: 30),
            child: Column(
              children: [
                DropdownSearch<String>(
                  mode: Mode.BOTTOM_SHEET,
                  showSelectedItem: true,
                  //                 searchFieldProps: TextFieldProps(
                  // controller: TextEditingController(text: 'Mrs'),
                  // ),
                  maxHeight: 200,
                  isFilteredOnline: true,
                  showClearButton: true,

                  items: [
                    "E-commerce",
                    "Events",
                  ],
                  label: "Auction type",
                  hint: "Select auction type",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (e) {
                    setState(() {
                      if(e != null) {
                        auctiontype = e;
                      }else{
                        auctiontype ="";
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>(
                  mode: Mode.BOTTOM_SHEET,
                  showSelectedItem: true,
                  //                 searchFieldProps: TextFieldProps(
                  // controller: TextEditingController(text: 'Mrs'),
                  // ),
                  showSearchBox: true,

                  isFilteredOnline: true,
                  showClearButton: true,

                  items: [
                    if(auctiontype == "E-commerce")
                      for(var cat in _pro.allcategories)
                        cat['name'],

                    if(auctiontype == "Events")
                      for(var cat in _pro.alleventCat)
                        cat['name']
                  ],

                  label: auctiontype.isEmpty
                      ? "Waiting for auction type to be selected"
                      : "Category",
                  hint: auctiontype.isEmpty
                      ? "Select auction type first"
                      : "Select product category",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (e) {
                    print(e);
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
                            return "Please enter product name";
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
                            labelText: auctiontype.isEmpty
                                ? "Please select auction type"
                                : "Product name",
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
                            return "Please enter product description";
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
                            labelText: auctiontype.isEmpty
                                ? "Please select auction type"
                                : "Product description",
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
                if (!auctiontype.isEmpty && auctiontype != "Events")
                  SizedBox(
                    height: 20,
                  ),
                if (!auctiontype.isEmpty && auctiontype != "Events")
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
                              return "Please enter product quantity";
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
                              labelText: "Product quantity",
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
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.4))),
                      child: _image == null
                          ? Center(
                              child: Text(auctiontype.isEmpty
                                  ? "Please select auction type"
                                  : auctiontype == "Events"
                                      ? "Image of product (optional)"
                                      : "Image of product"),
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
                          Text('Remember me');
                        }),
                    Expanded(
                        child: Text(
                      "To successfully place a request for auction sale, you are required to make a down payment.",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    )),
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
                            await initPayment();
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
