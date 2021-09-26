import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  static CameraPosition puntoInicial = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'),
        position: scan.getLatLng(),
        infoWindow: InfoWindow(title: 'gola')));

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
        actions: [
          IconButton(
              onPressed: () {
                this._goToTheLake();
              },
              icon: Icon(Icons.location_disabled))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: getPunto(scan),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: changeMap,
        label: Text('Change Map!'),
        icon: Icon(Icons.layers),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  getPunto(ScanModel scan) {
    final CameraPosition punto =
        CameraPosition(target: scan.getLatLng(), zoom: 14.4746, tilt: 40);
    puntoInicial = punto;
    return punto;
  }

  changeMap() {
    if (mapType == MapType.normal) {
      mapType = MapType.hybrid;
    } else {
      mapType = MapType.normal;
    }
    setState(() {});
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
  }
}
