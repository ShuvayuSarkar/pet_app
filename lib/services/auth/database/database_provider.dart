//this provider is used to seperate the firestore data handling data

// the database service class handles data to and from firebase
//the database provider

//also, if one day we decide to change our backend, it would be useful

import 'package:flutter/foundation.dart';

import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/auth/database/database_service.dart';

class DatbaseProvider extends ChangeNotifier {
  //services

  //get db and auth service
  final _auth = AuthService();
  final _db = DatabaseService();

  //user profile

  //get user profile given uid
  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);
}
