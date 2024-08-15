import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as location;
import 'package:uuid/uuid.dart';

class MapProvider with ChangeNotifier {
  final location.Location _locationController = location.Location();
  final Completer<GoogleMapController> _mapCompleter = Completer();
  final Uuid _uuid = const Uuid();

  List<Marker> _markers = [];
  List<dynamic> _placesList = [];
  String? _stAddress;
  String? _sessionToken;
  LatLng? _currentLocation;
  final TextEditingController _locationTextController = TextEditingController();

  List<Marker> get markers => _markers;
  set markers(List<Marker> markers) {
    _markers = markers;
    notifyListeners();
  }

  List<dynamic> get placesList => _placesList;
  set placesList(List<dynamic> places) {
    _placesList = places;
    notifyListeners();
  }

  String? get stAddress => _stAddress;
  set stAddress(String? address) {
    _stAddress = address;
    notifyListeners();
  }

  LatLng? get currentLocation => _currentLocation;
  set currentLocation(LatLng? location) {
    _currentLocation = location;
    notifyListeners();
  }

  Completer<GoogleMapController> get mapCompleter => _mapCompleter;

  TextEditingController get locationTextController => _locationTextController;

  void initLocationUpdates() {
    getLocationUpdates();
    _locationTextController.addListener(() => onChange());
  }

  void onChange() {
    _sessionToken ??= _uuid.v4();
    getSuggestions(_locationTextController.text);
  }

  String _buildSuggestionsUrl(String input) {
    return 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${dotenv.env['GOOGLE_MAP_API']}&sessiontoken=$_sessionToken';
  }

  Future<void> getSuggestions(String input) async {
    try {
      final url = _buildSuggestionsUrl(input);
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) print(response.body);

      if (response.statusCode == 200) {
        placesList = jsonDecode(response.body.toString())['predictions'];
      } else {
        throw Exception('Failed to load suggestions: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching suggestions: $e');
    }
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return;
    }

    location.PermissionStatus permissionGranted =
        await _locationController.hasPermission();
    if (permissionGranted == location.PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != location.PermissionStatus.granted) return;
    }

    final currentLocationData = await _locationController.getLocation();
    if (kDebugMode) print(currentLocationData);
    if (currentLocationData.latitude != null &&
        currentLocationData.longitude != null) {
      currentLocation =
          LatLng(currentLocationData.latitude!, currentLocationData.longitude!);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocationData.latitude!, currentLocationData.longitude!);
      markers = [
        Marker(
          markerId: const MarkerId('_currentLocation'),
          position: currentLocation!,
          infoWindow: const InfoWindow(
            title: 'Your Location',
          ),
        ),
      ];

      final GoogleMapController controller = await _mapCompleter.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation!,
            zoom: 15.0,
          ),
        ),
      );
      stAddress =
          '${placemarks.last.name!}, ${placemarks.last.street!}, ${placemarks.last.locality!}, ${placemarks.last.administrativeArea!}, ${placemarks.last.country!}';
    }
  }

  Future<void> selectedPlace(String place) async {
    List<Location> locations = await locationFromAddress(place);
    markers = [
      Marker(
        markerId: MarkerId(place),
        position: LatLng(locations.last.latitude, locations.last.longitude),
        infoWindow: InfoWindow(title: place),
      ),
    ];

    final GoogleMapController controller = await _mapCompleter.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            locations.last.latitude,
            locations.last.longitude,
          ),
          zoom: 14.0,
        ),
      ),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
        locations.last.latitude, locations.last.longitude);

    stAddress =
        '${placemarks.last.name!}, ${placemarks.last.locality!}, ${placemarks.last.administrativeArea!}, ${placemarks.last.country!}';
  }

  @override
  void dispose() {
    _locationTextController.dispose();
    super.dispose();
  }
}
