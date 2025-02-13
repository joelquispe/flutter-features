import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps App',
      home: GoogleMapsScreen(),
    );
  }
}

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({
    super.key,
  });

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  Completer<GoogleMapController> completerGoogleMap =
      Completer<GoogleMapController>();
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};

  Set<Polyline> polylines = {};

  void onMoveCamera(double lat, double lng) async {
    googleMapController.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  void onAddMarker(double lat, double lng) {
    Marker marker = Marker(
      markerId: MarkerId("my_position"),
      position: LatLng(lat, lng),
    );

    setState(() {
      markers.add(marker);
    });
  }

  void onAddPolyline(List<LatLng> points) {
    Polyline polyline = Polyline(
        polylineId: PolylineId(Uuid().v4()),
        points: [
          LatLng(-12.081272917974788, -77.07227117990419),
          LatLng(-12.078461219707572, -77.08154045864109),
          LatLng(-12.074697520332547, -77.07970910647826),
          LatLng(-12.075858432086186, -77.07515364906932),
        ],
        color: Colors.blue,
        width: 2);
    setState(() {
      polylines.add(polyline);
    });
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      log(permission.toString());
    }
  }

  Future<void> setCurrentLocation() async {
    final currentPosition = await Geolocator.getCurrentPosition();
    onMoveCamera(currentPosition.latitude, currentPosition.longitude);
    onAddMarker(currentPosition.latitude, currentPosition.longitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-12.077564316643453, -77.08157288506615),
              zoom: 18,
            ),
            onMapCreated: (controller) async {
              completerGoogleMap.complete(controller);
              googleMapController = await completerGoogleMap.future;
              setCurrentLocation();
            },
            onTap: (position) {
              log(position.latitude.toString());
              log(position.longitude.toString());
              onAddMarker(position.latitude, position.longitude);
            },
            mapType: MapType.normal,
            markers: markers,
            polylines: polylines,
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // onMoveCamera();
                  },
                  child: Text("Mover camara"),
                ),
                ElevatedButton(
                  onPressed: () {
                    onAddMarker(-12.077564316643453, -77.08157288506615);
                  },
                  child: Text("Agregar marcador"),
                ),
                ElevatedButton(
                  onPressed: () {
                    onAddPolyline([]);
                  },
                  child: Text("Dibujar polyline"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
