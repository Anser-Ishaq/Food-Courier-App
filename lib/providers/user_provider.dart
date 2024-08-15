import 'package:flutter/foundation.dart';
import 'package:food_couriers/models/user.dart';
import 'package:food_couriers/services/database_service.dart';
import 'package:get_it/get_it.dart';

class UserProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;

  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  UserProvider() {
    _databaseService = _getIt.get<DatabaseService>();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> createUser({required User user}) async {
    _setLoading(true);
    try {
      await _databaseService.createUser(user: user);
      _currentUser = user;
    } catch (e) {
      if (kDebugMode) print("Error creating user: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchUser({required String userUid}) async {
    // _setLoading(true);
    try {
      _currentUser = await _databaseService.getUser(uid: userUid);
    } catch (e) {
      if (kDebugMode) print("Error fetching user: $e");
    } finally {
      // _setLoading(false);
    }
  }

  Future<void> updateUser({
    required String uid,
    String? newAddress,
    double? newLongitude,
    double? newLatitude,
  }) async {
    _setLoading(true);
    try {
      await _databaseService.updateUser(
        uid: uid,
        newAddress: newAddress,
        newLongitude: newLongitude,
        newLatitude: newLatitude,
      );

      if (_currentUser != null && _currentUser!.uid == uid) {
        if (newAddress != null) _currentUser!.address = newAddress;
        if (newLongitude != null) _currentUser!.longitude = newLongitude;
        if (newLatitude != null) _currentUser!.latitude = newLatitude;
      }
    } catch (e) {
      if (kDebugMode) print("Error updating user: $e");
    } finally {
      _setLoading(false);
    }
  }
}
