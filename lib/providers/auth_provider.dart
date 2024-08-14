import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_couriers/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';

class AuthProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late StreamSubscription<User?> _authStateSubscription;

  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  void _setUser(User? user) {
    _user = user;
    _isLoading = false;
    notifyListeners();
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  AuthProvider() {
    _authService = _getIt.get<AuthService>();
    _initializeAuthState();
  }

  void _initializeAuthState() {
    _authStateSubscription = _authService.authStateChanges.listen(authStateChangesStreamListener);
  }

  void authStateChangesStreamListener(User? user) {
    _setUser(user);
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<bool> login(String email, String password) async {
    _setLoadingState(true);
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _setUser(user);
        if (kDebugMode) print('Login successful!');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      if (kDebugMode) print('Exception: ${e.toString()}');
    } finally {
      _setLoadingState(false);
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    _setLoadingState(true);
    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        _setUser(user);
        if (kDebugMode) print('Sign up successful!');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      if (kDebugMode) print('Exception: ${e.toString()}');
    } finally {
      _setLoadingState(false);
    }
    return false;
  }

  Future<void> forgotPassword(String email) async {
    _setLoadingState(true);
    try {
      await _authService.sendPasswordResetEmail(email);
      if (kDebugMode) print('Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      if (kDebugMode) print('Exception: ${e.toString()}');
    } finally {
      _setLoadingState(false);
    }
  }

  Future<bool> logout() async {
    _setLoadingState(true);
    try {
      await _authService.signOut();
      _setUser(null);
      if (kDebugMode) print('Logout successful!');
      return true;
    } catch (e) {
      if (kDebugMode) print('Exception: ${e.toString()}');
    } finally {
      _setLoadingState(false);
    }
    return false;
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    _setLoadingState(true);
    try {
      User user = _user!;
      await _authService.changePassword(user, oldPassword, newPassword);
      if (kDebugMode) print('Password changed successfully!');
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      if (kDebugMode) print('Exception: ${e.toString()}');
    } finally {
      _setLoadingState(false);
    }
    return false;
  }

  void _handleAuthException(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided.';
        break;
      case 'weak-password':
        errorMessage = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        errorMessage = 'The account already exists for that email.';
        break;
      default:
        errorMessage = 'Error: ${e.message}';
        break;
    }
    if (kDebugMode) print(errorMessage);
  }
}
