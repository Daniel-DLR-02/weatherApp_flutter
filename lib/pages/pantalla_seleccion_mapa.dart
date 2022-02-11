import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/utils/page.dart';
import 'package:weather_app/utils/prefence.dart';

import '../styles/styles.dart';
import '../utils/data.dart';

LatLng location = const LatLng(Data.lat, Data.long);

CameraPosition _kGooglePlex = CameraPosition(target: location, zoom: 11.0);

class MapClickPage extends GoogleMapExampleAppPage {
  const MapClickPage() : super(const Icon(Icons.mouse), 'Map click');

  @override
  Widget build(BuildContext context) {
    return const _MapClickBody();
  }
}

class _MapClickBody extends StatefulWidget {
  const _MapClickBody();

  @override
  State<StatefulWidget> createState() => _MapClickBodyState();
}

class _MapClickBodyState extends State<_MapClickBody> {
  _MapClickBodyState();

  GoogleMapController? mapController;

  coor() async {
    if (PreferenceUtils.getDouble('lat') != null) {
      double? lat = PreferenceUtils.getDouble('lat');
      double? lng = PreferenceUtils.getDouble('lng');

      location = LatLng(lat!, lng!);
      _kGooglePlex = CameraPosition(target: location, zoom: 11.0);
    } else {
      PreferenceUtils.setDouble('lat', Data.lat);
      PreferenceUtils.setDouble('lng', Data.long);
      return location = const LatLng(Data.lat, Data.long);
    }
  }

  @override
  void initState() {
    coor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      mapType: MapType.hybrid,
      onMapCreated: onMapCreated,
      initialCameraPosition: _kGooglePlex,
      onTap: (LatLng pos) async {
        setState(() {
          coor();
          location = pos;

          _kGooglePlex = CameraPosition(
              target: LatLng(pos.latitude, pos.longitude), zoom: 11.0);
        });
        PreferenceUtils.setDouble('lat', pos.latitude);
        PreferenceUtils.setDouble('lng', pos.longitude);
      },
      markers: <Marker>{_createMarker()},
      onLongPress: (LatLng pos) {
        setState(() {});
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: googleMap,
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 45.0),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {});
            Navigator.popAndPushNamed(context, '/');
          },
          backgroundColor: Styles.dayBackGroundColor,
          child: const Icon(Icons.navigation),
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    coor();
    _kGooglePlex = CameraPosition(
        target: LatLng(PreferenceUtils.getDouble('lat')!,
            PreferenceUtils.getDouble('lng')!),
        zoom: 11.0);
    mapController = controller;
    setState(() {});
  }

  Marker _createMarker() {
    return Marker(
      markerId: const MarkerId("marker_1"),
      position: location,
    );
  }
}
