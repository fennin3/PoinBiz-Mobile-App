import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReview extends StatefulWidget {
  const AddReview({Key key}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  double rate = 0.0;

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
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
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
                  Card(
                    color: appColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Submit", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Card(
                    color: appColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Cancel", style: TextStyle(color: Colors.white),),
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
