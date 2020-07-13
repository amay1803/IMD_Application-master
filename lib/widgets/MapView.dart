import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../values/MyColors.dart';

class GoogleMapView extends StatefulWidget {
  final double lat;
  final double long;
  final List<Marker> allMarkers;
  GoogleMapView(
      {Key key,
      @required this.lat,
      @required this.long,
      @required this.allMarkers})
      : super(key: key);
  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  @override
  Widget build(BuildContext context) {
    // print('lat: ' + widget.lat.toString());
    // print('long: ' + widget.long.toString());
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width,
      child: Card(
          color: MyColors.transparent.withOpacity(0.50),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                new Factory<OneSequenceGestureRecognizer>(
                  () => new EagerGestureRecognizer(),
                ),
              ].toSet(),
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long), zoom: 12.0),
              onMapCreated: (GoogleMapController controller) {},
              markers: Set.from(widget.allMarkers),
            ),
          )),
    );
  }
}
