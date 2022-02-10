import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/utils/page.dart';
import 'package:weather_app/utils/prefence.dart';

import '../styles/styles.dart';
import '../utils/data.dart';

CameraPosition _kInitialPosition =
    const CameraPosition(target: LatLng(Data.lat, Data.long), zoom: 11.0);

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
  LatLng _lastTap = LatLng(Data.lat, Data.long);
  LatLng? _lastLongPress;

  coor() async {
    if (PreferenceUtils.getDouble('lat') != null) {
      double? lat = PreferenceUtils.getDouble('lat');
      double? lng = PreferenceUtils.getDouble('lng');

      _lastTap = LatLng(lat!, lng!);
      _kInitialPosition = CameraPosition(target: _lastTap, zoom: 10.0);
    } else {
      _kInitialPosition = const CameraPosition(
          target: LatLng(Data.lat, Data.long), zoom: 11.0);
      return _lastTap =  const LatLng(Data.lat, Data.long);
    }
  }

  @override
  void initState() {
    PreferenceUtils.init().whenComplete(() => setState((){}));
    coor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      mapType: MapType.hybrid,
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      onTap: (LatLng pos) async {
        setState(() {
          _lastTap = pos;
        });
        PreferenceUtils.setDouble('lat', pos.latitude);
        PreferenceUtils.setDouble('lng', pos.longitude);
      },
      markers: <Marker>{_createMarker()},
      onLongPress: (LatLng pos) {
        setState(() {
          _lastLongPress = pos;
        });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePopAndPushNamed(context, '/');
        },
        backgroundColor: Styles.dayBackGroundColor,
        child: const Icon(Icons.navigation),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

  Marker _createMarker() {
    return Marker(
      markerId: MarkerId("marker_1"),
      position: _lastTap,
    );
  }
}
