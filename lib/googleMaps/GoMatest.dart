/* import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoMatest extends StatefulWidget {
  @override
  _GoMatestState createState() => _GoMatestState();
}

class _GoMatestState extends State<GoMatest> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor marico;
  Future<void> cre(BuildContext context) async {
    if (marico == null) {
      final ImageConfiguration image = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(image, 'assets/images (1).jpg')
          .then(update);
    }
  }

  void update(BitmapDescriptor bitmap) {
    if (this.mounted) {
      setState(() {
        marico = bitmap;
      });
    }
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> markers = Set<Marker>();

  Future<Set<Marker>> creM() async {
    List<Marker> mar = [];

    mar.add(Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.42796133580664, -122.085749655962),
      icon: marico,
      //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)// تغيير لونو
      infoWindow: InfoWindow(
          // شرح توضيحي بعد ما اضغط على الماركر
          title: 'mmh',
          snippet: 'jkjkjkjk', // شرح توضيحي تحت الاساسي صغير
          onTap: () {}),
      onTap: () {},
    ));
    return mar.toSet();
  }

  @override
  Widget build(BuildContext context) {
    cre(context);
    return Scaffold(
      body: FutureBuilder(
          future: creM(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              /* onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }, */
              markers: snapshot.data,
            );
          }),
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
 */