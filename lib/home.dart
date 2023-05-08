import 'package:apphotel/ImageMap.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          // Location Button in the AppBar
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Handle location button tap
              // Implement logic to show location on map
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // Error state
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              final imageUrl = data['image']['large'];
              final description = data['description'];

              return GestureDetector(
                onTap: () {
                  // Navigate to ImagePage on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagePage(
                        imageUrl: imageUrl,
                        description: description,
                        latitude: 0, // Provide the latitude value
                        longitude: 0, // Provide the longitude value
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circle Avatar
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              data['title'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            // Address
                            Text(data['address']),
                            SizedBox(height: 5),
                            // Phone Number
                            Text(data['phoneNumber']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
