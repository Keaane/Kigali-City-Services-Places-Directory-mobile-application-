import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<String?> signUp(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      // Send email verification
      await user?.sendEmailVerification();

      // Create user profile in Firestore
      await _firestore.collection('users').doc(user?.uid).set({
        'name': name,
        'email': email,
        'uid': user?.uid,
        'createdAt': Timestamp.now(),
      });

      return null; // null means success
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Temporarily disable email verification check for testing
      // if (!result.user!.emailVerified) {
      //   await _auth.signOut();
      //   return 'Please verify your email before logging in.';
      // }

      return null; // null means success
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> updateProfile({String? displayName, String? photoURL}) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return 'User not authenticated';

      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoURL);

      // Update in Firestore as well
      if (displayName != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': displayName,
        });
      }

      await user.reload();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> updatePassword(String currentPassword, String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return 'User not authenticated';

      // Re-authenticate user before password change
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> deleteAccount(String password) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return 'User not authenticated';

      // Re-authenticate user before account deletion
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Delete user data from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete user's listings
      QuerySnapshot listings = await _firestore
          .collection('listings')
          .where('createdBy', isEqualTo: user.uid)
          .get();

      for (DocumentSnapshot doc in listings.docs) {
        await doc.reference.delete();
      }

      // Delete the user account
      await user.delete();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}