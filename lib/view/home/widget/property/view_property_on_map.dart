import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';




class ViewPropertyOnMap extends StatefulWidget {
  ViewPropertyOnMap({super.key, required this.lat, required this.long});
  double lat;
  double long;

  @override
  // ignore: library_private_types_in_public_api
  _ViewPropertyOnMapState createState() => _ViewPropertyOnMapState();

}

class _ViewPropertyOnMapState extends State<ViewPropertyOnMap> {


  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    
    // Set the initial location
    //final LatLng _initialLocation = LatLng(widget.lat, widget.long); // Example: San Francisco

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 12,
        ),
        /*initialCameraPosition: CameraPosition(
          target: _initialLocation,
          zoom: 12.0,
        ),*/
        markers: {
          Marker(
            markerId: const MarkerId('initial_location'),
            position: LatLng(widget.lat, widget.long), // _initialLocation,
          ),
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}





	