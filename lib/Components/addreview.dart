import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class AddReview extends StatefulWidget {
  final id;

  AddReview({this.id});

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  double rate = 0.0;
  final TextEditingController _comment = TextEditingController();

  void sendReview(prodId, rate, comment)async{

    EasyLoading.show(status: "Sending Feedback");
    final userId = await UserData.getUserId();
    final userToken = await UserData.getUserToken();

    final _data = {
      "user_id":userId,
      "product_id":prodId,
      "rating":rate.toString(),
      "comment":comment

    };
    http.Response response = await http.post(Uri.parse(base_url + "user/create-review"), body: _data, headers: {
      HttpHeaders.authorizationHeader:"Bearer $userToken"
    });
    EasyLoading.dismiss();
    if(response.statusCode < 205){
      EasyLoading.showSuccess("Thank you for your feedback.");
      Navigator.pop(context);
    }
    else{
      EasyLoading.showError(json.decode(response.body)['message']);
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _comment.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(

          children: [
            SizedBox(
              height: 20,
            ),

            // SizedBox(
            //   height: 40,
            // ),
            Text(
              "Rate",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            RatingBar.builder(
              initialRating: rate,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  rate = rating;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Review",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10,),
            TextFormField(
              maxLines: 4,
              controller: _comment,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: appColor)
                  )
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()=>sendReview(widget.id, rate, _comment.text),
                    child: Card(
                      color: appColor,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Submit", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: ()=>Navigator.pop(context),
                    child: Card(
                      color: appColor,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Cancel", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
