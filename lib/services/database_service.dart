import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_couriers/models/user.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference _usersCollection;

  DatabaseService() {
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    _usersCollection =
        _firebaseFirestore.collection('users').withConverter<User>(
              fromFirestore: (snapshots, _) => User.fromJson(snapshots.data()!),
              toFirestore: (users, _) => users.toJson(),
            );
  }

  Future<void> createUser({required User user}) {
    return _usersCollection.doc(user.uid).set(user);
  }

  Future<User?> getUser({required String uid}) async {
    try {
      final DocumentSnapshot<User> documentSnapshot =
          await _usersCollection.doc(uid).get() as DocumentSnapshot<User>;

      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        if (kDebugMode) print("User with document ID $uid does not exist.");
        return null;
      }
    } catch (e) {
      if (kDebugMode) print("Error getting user: $e");
      return null;
    }
  }
}
