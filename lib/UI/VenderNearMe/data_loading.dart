import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/UI/VenderNearMe/home.dart';
import 'package:treva_shop_flutter/UI/VenderNearMe/vendor_model.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';

class DataLoading extends StatefulWidget {
  const DataLoading({Key key}) : super(key: key);

  @override
  _DataLoadingState createState() => _DataLoadingState();
}

class _DataLoadingState extends State<DataLoading> {

  List<VendorModel> vendors = [];

  _getCurrentLocation() async {

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void getVendors()async{
   try{
     vendors=[];
     final Position locs = await _determinePosition();
     final userToken = await UserData.getUserToken();

     final Map _data = {
       "lat":locs.latitude.toString(),
       "lng":locs.longitude.toString()
     };

     http.Response  response = await http.post(Uri.parse(base_url + "user/search-vendors"),
         body: _data,
         headers: {HttpHeaders.authorizationHeader :"Bearer $userToken"}
     );

     if(response.statusCode <206){
       List data = json.decode(response.body)['vendors'];
       for (Map vendor in data){
         vendors.add(VendorModel(image: vendor['banner']['path'],
             name: vendor['name'],
             description: vendor['description'],
             lat: vendor['address']['latitude'],
             lon: vendor['address']['longitude'],
             location: vendor['address']['location'],
             phone: vendor['merchant']['phone']
         ));
       }
       Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorNearMe(vendors: vendors,lat: locs.latitude.toString(), lng: locs.longitude.toString(),)));
     }
     else{
       Navigator.pop(context);
       EasyLoading.showError("Sorry something went wrong");
     }
   }
   on SocketException{
     Navigator.pop(context);
     EasyLoading.showError("Internet connection failed");
   }

  }

  @override
  void initState() {
    // TODO: implement initState
    getVendors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Please wait", style: TextStyle(fontSize: 16),),
                  SizedBox(height: 15,),
                  CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(appColor),
                    strokeWidth: 1.5,
                  ),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}
