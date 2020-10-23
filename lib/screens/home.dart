import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy/utils/routes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  BitmapDescriptor _markerIcon;

  static final CameraPosition _kInitial = CameraPosition(
    target: LatLng(
      -15.7920155,
      -47.8897989,
    ),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(-15.7920155, -47.8897989),
          infoWindow: InfoWindow(
            title: "Primeiro Marker",
            snippet: "An cool feature",
          ),
          icon: _markerIcon,
        ),
      );

      _markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(-15.7968677, -47.8802717),
          infoWindow: InfoWindow(
            title: "Segundo Marker",
            snippet: "An cool feature",
          ),
          icon: _markerIcon,
        ),
      );
    });
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/marker.png',
    );
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
        initialCameraPosition: _kInitial,
        onMapCreated: _onMapCreated,
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.CREATE_ORPHANAGE);
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  /* Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  } */
}
