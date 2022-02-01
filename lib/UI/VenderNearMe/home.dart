import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treva_shop_flutter/UI/VenderNearMe/direction_repository.dart';
import 'package:treva_shop_flutter/UI/VenderNearMe/directions_model.dart';
import 'package:treva_shop_flutter/UI/VenderNearMe/modal_sheet.dart';
import 'package:treva_shop_flutter/UI/VenderNearMe/vendor_model.dart';
import 'package:treva_shop_flutter/constant.dart';

class VendorNearMe extends StatefulWidget {
  final List<VendorModel> vendors;
  final String lat;
  final String lng;

  VendorNearMe({this.vendors, this.lat, this.lng});

  @override
  _VendorNearMeState createState() => _VendorNearMeState();
}

class _VendorNearMeState extends State<VendorNearMe> {
  CameraPosition _initialCameraPosition;
  List<Marker> markers = [];
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;


  void _showModal(VendorModel vendor){
    showModalBottomSheet(
        elevation: 10,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        context: context, builder: (context){
      return VNMModal(vendor: vendor,);
    }).then((value)async{

      if(value != null){
        final directions = await DirectionsRepository().getDirections(origin: _origin.position,
            destination: LatLng(double.parse(vendor.lat),double.parse(vendor.lon)));

        setState(() => _info = directions);
      }
    });
  }

  void setMarkers(){
   setState(() {
     markers.add(Marker(
         markerId: MarkerId("${widget.lat}${widget.lat}"),
         position: LatLng(double.parse(widget.lat), double.parse(widget.lng)),
         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
         infoWindow: InfoWindow(
           title: "me",
         )));
   });

    for (var vendor in widget.vendors){
      setState(() {
        markers.add(
            Marker(
              onTap: ()=>_showModal(vendor),
              position: LatLng(double.parse(vendor.lat),double.parse(vendor.lon)),
                markerId: MarkerId('${vendor.lat}${vendor.lon}'),
              // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            ));
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _initialCameraPosition = CameraPosition(
      target: LatLng(
        double.parse(widget.lat),
        double.parse(widget.lng),
      ),
      zoom: 12.5,
    );
    _origin = Marker(
            markerId: MarkerId("${widget.lat}${widget.lat}"),
            position: LatLng(double.parse(widget.lat), double.parse(widget.lng)),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
                title: "me",
            ));
    setMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.lat);
    print(widget.lng);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          title: Text("Vendor Near Me", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                trafficEnabled: true,
                mapType: MapType.hybrid,
                buildingsEnabled: true,

                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: markers.toSet(),
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                mapToolbarEnabled: false,
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              if(_info != null)
                Positioned(
                  top: 15.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Text(
                      '${_info.totalDistance}, ${_info.totalDuration}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: appColor,
        //   onPressed: ()=> _googleMapController.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition)),
        //   child: const Icon(Icons.center_focus_strong),
        // ),
      ),
    );
  }
}
