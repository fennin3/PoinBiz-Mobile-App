import 'package:flutter/material.dart';

class ShippingAddresses extends StatefulWidget {
  const ShippingAddresses({Key key}) : super(key: key);

  @override
  _ShippingAddressesState createState() => _ShippingAddressesState();
}

class _ShippingAddressesState extends State<ShippingAddresses> {
  int nu = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Column(
              children: [
                SizedBox(height: 30,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      for (var i in [1, 2, 3, 4, 5])
                        InkWell(
                          onTap: () {
                            setState(() {
                              nu = [1, 2, 3, 4, 5].indexOf(i);
                            });
                          },
                          child: AddressWidget(
                            nu: nu,
                            index: [1, 2, 3, 4, 5].indexOf(i),
                          ),
                        )
                    ],
                  ),
                ),

                SizedBox(height: 20,),
                Row(
                  children: [

                  ],
                ),
                SizedBox(height: 30,),
              ],
            )));
  }
}

class AddressWidget extends StatelessWidget {
  final index;
  final nu;

  AddressWidget({this.index, this.nu});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Stack(
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: index != nu ? Colors.black : Colors.green)),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Default Address",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Tema Community 9",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Post Office Box 32",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Ennin Francis",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "+233541752049",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 7,
                top: 7,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor:
                          index == nu ? Colors.green : Colors.white,
                    ),
                  ),
                ))
          ],
        ));
  }
}
