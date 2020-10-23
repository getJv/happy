import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateOrphanage extends StatefulWidget {
  @override
  _CreateOrphanageState createState() => _CreateOrphanageState();
}

class _CreateOrphanageState extends State<CreateOrphanage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  BitmapDescriptor _markerIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-15.7920155, -47.8897989),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(-15.7995798, -47.8638008),
    tilt: 59.440717697143555,
    zoom: 18,
  );

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/marker.png',
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    setState(() {
      /*  _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(-15.7920155, -47.8897989),
          infoWindow: InfoWindow(
            title: "Primeiro Marker",
            snippet: "An cool feature",
          ),
          icon: _markerIcon
        ),
      ); */
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: _onMapCreated,
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
