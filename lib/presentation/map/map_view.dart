import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/map/extensions/markers_ext.dart';
import 'package:moovup_test/presentation/map/extensions/people_ext.dart';
import 'package:moovup_test/presentation/map/no_location_view.dart';
import 'package:moovup_test/presentation/routes/route.dart';

class MapView extends StatefulWidget {
  final List<Person> people;
  final bool allowNav;

  const MapView({super.key, required this.people, required this.allowNav});

  @override
  State<MapView> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapView> {
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(1, 1);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    _initMarkers();
    super.initState();
  }

  void _initMarkers() {
    _markers.clear();
    _markers
        .addAll(widget.people.toMarkerSet(widget.allowNav, _onMarkerTapped));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateCamera();
  }

  void _onMarkerTapped(String markerId) {
    if (!widget.allowNav) return;
    _navToPersonView(markerId);
  }

  void _navToPersonView(String personId) {
    final person = widget.people.firstWhere((p) => p.id == personId);
    PersonRoute(personId: person.id, $extra: person).push(context);
  }

  void _updateCamera() {
    if (_markers.isEmpty) return;
    _mapController
        .animateCamera(CameraUpdate.newLatLngBounds(_markers.getBounds(), 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _markers.isEmpty
          ? const NoLocationView()
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _markers.isNotEmpty ? _markers.first.position : _center,
                zoom: 0.0,
              ),
              onMapCreated: _onMapCreated,
              markers: _markers,
            ),
    );
  }
}
