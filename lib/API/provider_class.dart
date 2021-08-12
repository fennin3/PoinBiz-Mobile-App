import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/getFunctions.dart';


class PoinBizProvider with ChangeNotifier{
  List allcategories=[];
  List allbanners=[];
  bool loading;




  void getallCategories()async{
    allcategories = await GetFunc.getCategories();

    print(allcategories);

    notifyListeners();
  }





}