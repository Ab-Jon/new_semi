import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/drawer_screens/tickets/events/post_event.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});

  // Sample image URLs; you should replace these with real event image URLs
  final List<String> imageUrls = const [
    'https://picsum.photos/200/120?random=1',
    'https://picsum.photos/200/120?random=2',
    'https://picsum.photos/200/120?random=3',
  ];

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Event", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Create Event screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostEventScreen()));
        },
        backgroundColor: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Row of online images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: imageUrls.map((url) => _networkImage(url)).toList(),
            ),
            const SizedBox(height: 40),

            /// Title
            const Text(
              "Post an Event Today!!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            /// Description
            Text(
              "You have no events yet. Click on the (+) add icon to make a post today and control what happens in your event with ease.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _networkImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        url,
        width: 100,
        height: 85,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            width: 100,
            height: 85,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return Container(
            width: 100,
            height: 85,
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.grey[700]),
          );
        },
      ),
    );
  }
}
