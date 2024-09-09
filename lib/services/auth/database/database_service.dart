/* database services

handles all the data from and to firebase


-user profile
-post message
-likes
-comments
-account stuff
-follow /unfollow
-search users

*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/models/user.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //user profile
  // when a new user registers, we create an account dor them, but lets store their details in database to display on their profile page

  //save user info
  Future<void> saveUserInfoInFirebase(
      {required String name, required String email}) async {
    //get current uid
    String uid = _auth.currentUser!.uid;

    //extract username from email
    String username = email.split('@')[0];

    //create a user profile
    UserProfile user = UserProfile(
      uid: uid,
      name: name,
      email: email,
      username: username,
      bio: '',
    );

    //convert user into a map so that we can store it into firebase
    final userMap = user.toMap();

    //save user info in firebase
    await _db.collection('Users').doc(uid).set(userMap);
  }

  //get user info
  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      //retreive userinfo doc from firebase
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();

      //convert doc to user profile
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
