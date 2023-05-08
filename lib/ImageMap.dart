import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagePage extends StatelessWidget {
  //define the variables
  final String imageUrl;
  final String description;
  final double latitude;
  final double longitude;

  const ImagePage({
    required this.imageUrl,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  Future<void> _openMap() async {
    // Generate the map URL using latitude and longitude
    final mapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(mapUrl)) {
      // Open the map URL
      await launch(mapUrl);
    } else {
      // Throw an error if the map URL could not be launched
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Page'),
        actions: [
          // Location Button in the AppBar
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Handle location button tap to open the map
              _openMap();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          Image.network(imageUrl),
          SizedBox(height: 20),
          // Description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
