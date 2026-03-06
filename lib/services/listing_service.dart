import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing_model.dart';

class ListingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'listings';

  // Get all listings
  Stream<List<Listing>> getListings() {
    return _firestore
        .collection(collection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Listing.fromFirestore(doc)).toList());
  }

  // Get listings by current user
  Stream<List<Listing>> getUserListings(String uid) {
    return _firestore
        .collection(collection)
        .where('createdBy', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Listing.fromFirestore(doc)).toList());
  }

  // Create listing
  Future<String?> createListing(Listing listing) async {
    try {
      await _firestore.collection(collection).add(listing.toMap());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Update listing
  Future<String?> updateListing(Listing listing) async {
    try {
      await _firestore
          .collection(collection)
          .doc(listing.id)
          .update(listing.toMap());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Delete listing
  Future<String?> deleteListing(String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}