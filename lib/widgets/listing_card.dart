import 'package:flutter/material.dart';
import '../models/listing_model.dart';

class ListingCard extends StatelessWidget {
  final Listing listing;
  final VoidCallback onTap;

  const ListingCard({super.key, required this.listing, required this.onTap});

  Color _categoryColor(String category) {
    switch (category) {
      case 'Hospital':
        return Colors.red;
      case 'Police Station':
        return Colors.blue;
      case 'Library':
        return Colors.purple;
      case 'Restaurant':
        return Colors.orange;
      case 'Café':
        return Colors.brown;
      case 'Park':
        return Colors.green;
      case 'Tourist Attraction':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _categoryColor(listing.category),
          child: const Icon(Icons.location_on, color: Colors.white),
        ),
        title: Text(
          listing.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(listing.address),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _categoryColor(listing.category).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _categoryColor(listing.category).withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                listing.category,
                style: TextStyle(
                  color: _categoryColor(listing.category),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        isThreeLine: true,
      ),
    );
  }
}