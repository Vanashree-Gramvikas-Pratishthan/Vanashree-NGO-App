import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppGoogleMap extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final ValueChanged<GoogleMapController>? onMapCreated;
  final ValueChanged<LatLng>? onTap;
  final double? zoom;

  const AppGoogleMap({
    super.key,
    required this.initialLocation,
    this.markers = const {},
    this.polylines = const {},
    this.onMapCreated,
    this.onTap,
    this.zoom,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialLocation,
        zoom: zoom ?? 14.0,
      ),
      markers: markers,
      polylines: polylines,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: onMapCreated,
      onTap: onTap,
    );
  }
}