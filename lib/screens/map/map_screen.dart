import 'package:flutter/material.dart';
import 'package:food_couriers/components/back_notification_row.dart';
import 'package:food_couriers/providers/auth_provider.dart';
import 'package:food_couriers/providers/map_provider.dart';
import 'package:food_couriers/providers/user_provider.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/screens/map/widgets/location_details_box.dart';
import 'package:food_couriers/screens/map/widgets/location_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authProvider = Provider.of(context, listen: false);
    Provider.of<MapProvider>(context, listen: false).initLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        body: Consumer<MapProvider>(
          builder: (context, mapProvider, child) {
            return Stack(
              children: [
                mapProvider.currentLocation == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.red,
                          strokeWidth: 3,
                        ),
                      )
                    : GoogleMap(
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: mapProvider.currentLocation!,
                          zoom: 12.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          if (!mapProvider.mapCompleter.isCompleted) {
                            mapProvider.mapCompleter.complete(controller);
                          }
                        },
                        markers: Set<Marker>.of(mapProvider.markers),
                      ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          BackNotificationRow(
                            index: 1,
                            onTapBack: () async {
                              FocusScope.of(context).unfocus();
                              await Future.delayed(
                                const Duration(
                                  milliseconds: 90,
                                ),
                              );
                              _navigationService.goBack();
                            },
                            onTapNotification: () {},
                          ),
                          const SizedBox(height: 20),
                          LocationSearchBar(
                            textEditingController:
                                mapProvider.locationTextController,
                            placesList: mapProvider.placesList,
                            onTapPlace: (place) async {
                              mapProvider.selectedPlace(place);
                            },
                          ),
                        ],
                      ),
                      Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                        return LocationDetailsBox(
                          locationAddress:
                              mapProvider.stAddress ?? 'Loading....',
                          isLoading: userProvider.isLoading,
                          onTapSetLocation: () {
                            userProvider.updateUser(
                              uid: _authProvider.user!.uid,
                              newAddress: mapProvider.stAddress,
                              newLongitude:
                                  mapProvider.currentLocation!.longitude,
                              newLatitude:
                                  mapProvider.currentLocation!.latitude,
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
