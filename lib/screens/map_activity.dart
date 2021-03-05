import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapActivity extends StatefulWidget {
  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {

  Completer<GoogleMapController> _controller = Completer();

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  LatLng _lastMapPosition = _center;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void _addMarkerToMap(){
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "A good place",
          snippet: "5 stars"
        ),
        icon: BitmapDescriptor.defaultMarker
      )
      );
    });
  }

  void _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Maps Activity'),
            backgroundColor: Colors.green[700],
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: _markers,
                onCameraMove: _onCameraMove,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      // FloatingActionButton(
                      //   onPressed: _onMapTypeButtonPressed,
                      //   materialTapTargetSize: MaterialTapTargetSize.padded,
                      //   backgroundColor: Colors.green,
                      //   child: const Icon(Icons.map, size: 36.0),
                      // ),
                      SizedBox(height: 16.0),
                      FloatingActionButton(
                        onPressed: _addMarkerToMap,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.add_location, size: 36.0),
                      )
                    ],
                  )
                ),
              ),
            ],
          )
        )
    );
  }
}
