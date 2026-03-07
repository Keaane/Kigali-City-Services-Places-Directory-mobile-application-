import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../providers/listing_provider.dart';
import '../directory/listing_detail_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const LatLng _kigaliCenter = LatLng(-1.9441, 30.0619);

  @override
  Widget build(BuildContext context) {
    final listingProvider = Provider.of<ListingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: _kigaliCenter,
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.kigali_services',
          ),
          MarkerLayer(
            markers: listingProvider.listings.map((listing) {
              return Marker(
                point: LatLng(listing.latitude, listing.longitude),
                width: 40,
                height: 40,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ListingDetailScreen(listing: listing),
                    ),
                  ),
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.teal,
                    size: 40,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}