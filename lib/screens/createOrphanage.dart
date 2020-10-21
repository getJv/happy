import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(-15.7931994, -47.88613),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
            additionalOptions: {
              'accessToken': DotEnv().env['MAPBOX_TOKEN'],
              'id': 'mapbox.streets',
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(-15.7931994, -47.88613),
                builder: (ctx) => Container(
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return Container(
                            color: Colors.white,
                            child: Center(
                              child: Text("OPPA"),
                            ),
                          );
                        },
                      );
                    },
                    color: Theme.of(context).accentColor,
                    iconSize: 45.0,
                    icon: Icon(Icons.location_pin),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.navigate_next),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
