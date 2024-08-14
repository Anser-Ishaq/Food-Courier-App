import 'package:flutter/foundation.dart';
import 'package:food_couriers/models/user.dart';
import 'package:food_couriers/services/database_service.dart';
import 'package:get_it/get_it.dart';

class UserProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;

  User? _currentUser;

  User? get currentUser => _currentUser;

  UserProvider() {
    _databaseService = _getIt.get<DatabaseService>();
  }

  Future<void> createUser({required User user}) async {
    try {
      await _databaseService.createUser(user: user);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error creating user: $e");
    }
  }

    Future<void> fetchUser(String userUid) async {
    try {
      _currentUser = await _databaseService.getUser(uid: userUid);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error fetching user: $e");
    }
  }
}