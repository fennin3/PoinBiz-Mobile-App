import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/BottomNavigationBar.dart';
import 'package:treva_shop_flutter/UI/OnBoarding.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upgrader/upgrader.dart';

/// Run first apps open
void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(SearchedWordAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(WishItemAdapter());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PoinBizProvider>(
        create: (_) => PoinBizProvider(),
      ),
    ],
    child: myApp(),
  ));
}

/// Set orienttation
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    Upgrader().clearSavedSettings(); //

    return new MaterialApp(
      title: "Treva Shop",
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: SplashScreen(),
    );
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  @override

  /// Setting duration in splash screen
  // startTime() async {
  //   return new Timer(Duration(milliseconds: 100), NavigatorPage);
  // }

  /// To navigate layout change
  // void NavigatorPage() async {
  //
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //   await _getInitData().then((value) {
  //     if (sharedPreferences.getBool("installed") == null) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => onBoarding(),
  //         ),
  //             (Route<dynamic> route) => false,
  //       );
  //     } else {
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => UpgradeAlert(
  //             child: bottomNavigationBar(),
  //           ),
  //         ),
  //             (Route<dynamic> route) => false,
  //       );
  //     }
  //   });
  //
  // }

  void _navigate()async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = await _getInitData();

    Future.delayed(Duration(seconds: 3)).then((value){
      if(result == 1 ){
        if (sharedPreferences.getBool("installed") == null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => onBoarding(),
            ),
                (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => UpgradeAlert(
                child: bottomNavigationBar(),
              ),
            ),
                (Route<dynamic> route) => false,
          );
        }
      }
      else{
        EasyLoading.showInfo("No internet connection");
      }
    });

  }


  Future<int> _getInitData()async{
    try{
      final _pro = Provider.of<PoinBizProvider>(context, listen: false);
      _pro.getallCategories();
      _pro.getBanners();
      _pro.getPromos();
      _pro.getProducts();
      _pro.getAddresses();
      _pro.getCartItem();
      _pro.getEventCategories();
      _pro.getAllEvent();
      _pro.getAllBuses();
      _pro.getDestinations();
      _pro.getCartData();
      _pro.getWishListData();
      _pro.getConfig();
      _pro.getOrders();
      _pro.getUserDetail();
      _pro.getPlacedOrders();
      _pro.getAllBusinessTypes();
      _pro.getAuction();
      _pro.getRegions();
      try{
        _pro.getAddresses();
      }
      catch(e){}
      try{
        _pro.getUserDetail();
      }catch(e){}
      return 1;
    }
    on SocketException{
      return 0;
    }
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 72, 0, 1),
      body: Container(
        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/spl.jpg'), fit: BoxFit.contain),
        ),
      ),
    );
  }
}
