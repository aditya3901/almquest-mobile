import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utils/constants.dart';
import '../utils/directions_model.dart';
import '../utils/directions_repository.dart';

class MapScreen extends StatefulWidget {
  final dynamic userLocation;
  final dynamic meetLocation;

  const MapScreen({
    Key? key,
    required this.userLocation,
    required this.meetLocation,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition? _initialCameraPosition;
  Marker? _origin;
  Marker? _destination;
  GoogleMapController? _googleMapController;
  Directions? _info;
  bool isLoading = true;

  void _initVars() async {
    _initialCameraPosition = CameraPosition(
      target: LatLng(
        widget.userLocation["coordinates"][0],
        widget.userLocation["coordinates"][1],
      ),
      zoom: 11.5,
    );

    _origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(
        widget.userLocation["coordinates"][0],
        widget.userLocation["coordinates"][1],
      ),
    );

    _destination = Marker(
      markerId: const MarkerId('destination'),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(
        widget.meetLocation["coordinates"][0],
        widget.meetLocation["coordinates"][1],
      ),
    );

    final directions = await DirectionsRepository().getDirections(
      origin: _origin!.position,
      destination: _destination!.position,
    );

    _info = directions;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVars();
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(
                radius: 18,
                color: kTextColor,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'AlmQuest',
              ),
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              actions: [
                if (_origin != null)
                  TextButton(
                    onPressed: () => _googleMapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: _origin!.position,
                          zoom: 14.5,
                          tilt: 50.0,
                        ),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.green,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('ORIGIN'),
                  ),
                if (_destination != null)
                  TextButton(
                    onPressed: () => _googleMapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: _destination!.position,
                          zoom: 14.5,
                          tilt: 50.0,
                        ),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('DEST'),
                  )
              ],
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                GoogleMap(
                  initialCameraPosition: _initialCameraPosition!,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) =>
                      _googleMapController = controller,
                  markers: {
                    if (_origin != null) _origin!,
                    if (_destination != null) _destination!,
                  },
                  polylines: {
                    if (_info != null)
                      Polyline(
                        polylineId: const PolylineId('overview_polyline'),
                        color: Colors.blue,
                        width: 5,
                        points: _info!.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList(),
                      ),
                  },
                ),
                if (_info != null)
                  Positioned(
                    top: 20.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                      child: Text(
                        '${_info!.totalDistance}, ${_info!.totalDuration}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () => _googleMapController!.animateCamera(
                _info != null
                    ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                    : CameraUpdate.newCameraPosition(_initialCameraPosition!),
              ),
              child: const Icon(
                Icons.center_focus_strong,
                size: 30,
              ),
            ),
          );
  }
}
