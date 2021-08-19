import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AddOrder extends StatefulWidget {
  const AddOrder({Key key}) : super(key: key);

  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  List _data = [];
  PickedFile _image;
  final ImagePicker _picker = ImagePicker();
  bool checkBoxValue = false;


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



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          "Place Order",
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
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 30),
                child: Column(
                  children: [
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
                        "Brazil",
                        "Italia",
                        "Tunisia",
                        "Canada",
                        "Brazil",
                        "Italia",
                        "Tunisia",
                        "Canada"
                      ],
                      label: "Category",
                      hint: "Select product category",
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
                                labelText: "Product name",
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
                                labelText: "Product description",
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
                              border: Border.all(color: Colors.black.withOpacity(0.4))
                          ),
                          child: _image == null ? Center(child: Text("Image of product"),):Container(
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
                              onPressed: ()=> showImagePickerModal(),
                              child: Card(

                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.camera_alt, color: appColor,),
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
                        Checkbox(value: checkBoxValue,
                            activeColor: appColor,
                            onChanged:(bool newValue){
                              setState(() {
                                checkBoxValue = newValue;
                              });
                              Text('Remember me');
                            }),
                        Expanded(child: Text("To successfully place a request for auction sale, you are required to make a down payment.", style: TextStyle(fontSize: 12, color: Colors.blue),)),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed:()async{
                          if(checkBoxValue){


                          }
                          else{

                          }
                        }, child: Card(
                          color: checkBoxValue? appColor:Colors.grey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Proceed", style: TextStyle(color: Colors.white),),
                          ),
                        ))
                      ],
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
