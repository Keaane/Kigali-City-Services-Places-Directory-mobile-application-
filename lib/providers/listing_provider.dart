import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing_model.dart';
import '../services/listing_service.dart';

class ListingProvider extends ChangeNotifier {
  final ListingService _listingService = ListingService();

  List<Listing> _listings = [];
  List<Listing> _userListings = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<Listing> get listings => _filteredListings();
  List<Listing> get userListings => _userListings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<Listing> _filteredListings() {
    return _listings.where((listing) {
      final matchesSearch = listing.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || listing.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void fetchListings() {
    _isLoading = true;
    notifyListeners();

    _listingService.getListings().listen((listings) {
      _listings = listings;
      _isLoading = false;
      notifyListeners();
    });
  }

  void fetchUserListings(String uid) {
    _listingService.getUserListings(uid).listen((listings) {
      _userListings = listings;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<bool> createListing({
    required String name,
    required String category,
    required String address,
    required String contactNumber,
    required String description,
    required double latitude,
    required double longitude,
    required String uid,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final listing = Listing(
      id: '',
      name: name,
      category: category,
      address: address,
      contactNumber: contactNumber,
      description: description,
      latitude: latitude,
      longitude: longitude,
      createdBy: uid,
      timestamp: Timestamp.now(),
    );

    String? error = await _listingService.createListing(listing);

    _isLoading = false;
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> updateListing(Listing listing) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    String? error = await _listingService.updateListing(listing);

    _isLoading = false;
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> deleteListing(String id) async {
    String? error = await _listingService.deleteListing(id);
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }
    return true;
  }
}