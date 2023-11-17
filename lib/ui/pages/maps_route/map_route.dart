import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_directions/flutter_map_directions.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _message = 'Finding route...';
  double _topPadding = 0;

  List<DirectionCoordinate> _coordinates = [];
  final MapController _mapController = MapController();
  final DirectionController _directionController = DirectionController();

  @override
  void initState() {
    _loadNewRoute();
    super.initState();
  }

  void _loadNewRoute() async {
    await Future.delayed(const Duration(seconds: 5));
    _coordinates = [
      DirectionCoordinate(20.98091894, 105.78737106),
    ];
    final bounds = LatLngBounds.fromPoints(_coordinates
        .map((location) => LatLng(location.latitude, location.longitude))
        .toList());
    CenterZoom centerZoom = _mapController.centerZoomFitBounds(bounds);
    _mapController.move(centerZoom.center, centerZoom.zoom);
    _directionController.updateDirection(_coordinates);
  }

  @override
  Widget build(BuildContext context) {
    _topPadding = MediaQuery.of(context).padding.top;
    final bounds = LatLngBounds.fromPoints([
      DirectionCoordinate(20.98091894, 105.78737106)
    ]
        .map((location) => LatLng(location.latitude, location.longitude))
        .toList());

    return Scaffold(
        body: Stack(
      children: [
        FlutterMap(
        
          mapController: _mapController,
          options: MapOptions(
            bounds: bounds,
            boundsOptions: _buildMapFitBoundsOptions(),
          ),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
                markers: _coordinates.map((location) {
              return Marker(
                  point: LatLng(location.latitude, location.longitude),
                  width: 35,
                  height: 35,
                  builder: (context) => const Icon(
                        Icons.location_pin,
                      ),
                  anchorPos: AnchorPos.align(AnchorAlign.top));
            }).toList()),
            DirectionsLayer(
              coordinates: _coordinates,
              color: Colors.deepOrange,
              onCompleted: (isRouteAvailable) =>
                  _updateMessage(isRouteAvailable),
              controller: _directionController,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: Text(_message),
          ),
        ),
      ],
    ));
  }

  FitBoundsOptions _buildMapFitBoundsOptions() {
    const padding = 50.0;
    return FitBoundsOptions(
      padding: EdgeInsets.only(
        left: padding,
        top: padding + _topPadding,
        right: padding,
        bottom: padding,
      ),
    );
  }

  void _updateMessage(bool isRouteAvailable) {
    if (_coordinates.length < 2) return;

    setState(() {
      _message = isRouteAvailable ? 'Found route' : 'No route found';
    });
  }
}
