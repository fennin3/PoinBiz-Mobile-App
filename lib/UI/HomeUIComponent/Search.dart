import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Components/product_item.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/constant.dart';
class searchAppbar extends StatefulWidget {
  final Map data;

  searchAppbar({this.data});
  @override
  _searchAppbarState createState() => _searchAppbarState();
}

class _searchAppbarState extends State<searchAppbar> {


  List _products = [];
  final TextEditingController _searchText = TextEditingController();
  void setData(){
    setState(() {
      _products = widget.data['products'];
    });
  }


  void _searchFun(String text){
    _products = widget.data['products'];
    setState(() {
      _products = _products.where((element) => element['name'].toString().toLowerCase().contains("${text.toLowerCase()}")).toList();
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchText.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    _pro.getSearchwords();
    super.initState();
    setData();
  }
  @override
  static var _customTextStyleBlack = TextStyle(
      fontFamily: "Gotik",
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 15.0);

  /// Sentence Text header "Hello i am Treva.........."
  var _textHello = Padding(
    padding: const EdgeInsets.only(right: 50.0, left: 20.0),
    child: Text(
      "Hello, i am PoinBiz. What would you like to search ?",
      style: TextStyle(
          letterSpacing: 0.1,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: Colors.black54,
          fontFamily: "Gotik"),
    ),
  );


  /// Popular Keyword Item



  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    var _search = Padding(
      padding: const EdgeInsets.only(top: 35.0, right: 20.0, left: 20.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                controller: _searchText,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFF6991C7),
                      size: 28.0,
                    ),
                    hintText: "Find you want",
                    hintStyle: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Gotik",
                        fontWeight: FontWeight.w400)),
                onChanged: (e){
                  _searchFun(_searchText.text);
                },
              ),
            ),
          ),
        ),
      ),
    );
    // var _searchResults2 = Container(
    //   child: Column(
    //     children: <Widget>[
    //       Padding(
    //         padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text(
    //               "Search results",
    //               style: _customTextStyleBlack,
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //       _products.length <1 ? Container(
    //
    //         child: Column(
    //           children: [
    //             SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
    //             Text("No Products Found", style: TextStyle(fontSize: 25),)
    //           ],
    //         ),
    //       ):
    //       Container(
    //         margin: EdgeInsets.only(right: 5.0, left: 5.0),
    //
    //         ///
    //         ///
    //         /// check the condition if image data from server firebase loaded or no
    //         /// if image true (image still downloading from server)
    //         /// Card to set card loading animation
    //         ///
    //         ///
    //         child:
    //
    //         Container(
    //           color: Colors.white,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //
    //
    //               GridView.count(
    //                 shrinkWrap: true,
    //                 padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    //                 crossAxisSpacing: 10.0,
    //                 mainAxisSpacing: 15.0,
    //                 childAspectRatio: 0.55,
    //                 crossAxisCount: 2,
    //                 primary: false,
    //                 children:List.generate(
    //                   /// Get data in flashSaleItem.dart (ListItem folder)
    //                   _products.length,
    //                       (index) => ItemGrid(_products[index]),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //
    //       ),
    //
    //     ],
    //   ),
    // );
    var _sugestedText = Container(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20.0),
            child: Text(
              "Search History",
              style: TextStyle(fontFamily: "Gotik", color: Colors.black26),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          // Expanded(
          //     child: ListView(
          //       scrollDirection: Axis.horizontal,
          //       children: <Widget>[
          //         Padding(padding: EdgeInsets.only(left: 20.0)),
          //         for(var word in _pro.searchedWords)
          //           KeywordItem(
          //             title: "Iphone X",
          //             title2: "Mackbook",
          //           ),
          //
          //       ],
          //     ))

          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Container(
              height: 70,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                childAspectRatio: (2 / 4),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,

                children: [
                  for (var cat in _pro.searchedWords)
                    InkWell(
                      onTap: (){
                        setState(() {

                        });
                      },
                      child: Card(
                        elevation: 3,
                        child: Center(child: Text(cat.text)),
                      ),
                    ),
                ],
                shrinkWrap: true, crossAxisCount: 2,
              ),
            ),
          )
        ],
      ),
    );
    var _searchResults = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Products",
                  style: _customTextStyleBlack,
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context).push(PageRouteBuilder(
                //         pageBuilder: (_, __, ___) => new promoDetail()));
                //   },
                //   child: Text("See More", style: _customTextStyleBlue),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5.0, left: 5.0),

            child:

            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ///
                  ///
                  /// check the condition if image data from server firebase loaded or no
                  /// if image true (image still downloading from server)
                  /// Card to set card loading animation
                  ///
                  ///

                  GridView.count(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 0.55,
                    crossAxisCount: 2,
                    primary: false,
                    children:List.generate(
                      /// Get data in flashSaleItem.dart (ListItem folder)
                      _products.length,
                          (index) => ItemGridMain(_products[index],_searchText.text),
                    ),
                  )
                ],
              ),
            ),

          ),

        ],
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF6991C7),
        ),
        title: Text(
          "Search",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Caliing a variable
                _textHello,
                _search,
                _sugestedText,
                _searchResults,
                Padding(padding: EdgeInsets.only(bottom: 30.0, top: 2.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Popular Keyword Item class
class KeywordItem extends StatelessWidget {
  @override
  String title, title2;

  KeywordItem({this.title, this.title2});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:4.0,left: 3.0),
          child: Container(
            height: 29.5,
            width: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.5,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Center(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontFamily: "Sans"),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 15.0)),
        Container(
          height: 29.5,
          width: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.5,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Center(
            child: Text(
              title2,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "Sans",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///Favorite Item Card
class FavoriteItem extends StatelessWidget {
  String image, Rating, Salary, title, sale;

  FavoriteItem({this.image, this.Rating, this.Salary, this.title, this.sale});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left:2.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    Salary,
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            Rating,
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        sale,
                        style: TextStyle(
                            fontFamily: "Sans",
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
