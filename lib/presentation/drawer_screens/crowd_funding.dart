import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/drawer_screens/crowd_funding/post_crowd.dart';

class CrowdfundPage extends StatelessWidget {
  const CrowdfundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight? Colors.white: const Color(0xFF0F0F0F),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: isLight? Colors.white: const Color(0xFF0F0F0F),
        title: Text(
          "Crowdfund",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostCrowdPage()));
        },
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // ---------------------- HORIZONTAL SCROLL IMAGES ----------------------
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca",
                      width: 180,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1595152772835-219674b2a8a6",
                      width: 180,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- EMPTY STATE TEXT ----------------------
            Text(
              "Crowdfund Today!!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You have no events yet. Click on the (+) add icon to make a post "
                  "today and control what happens in your event with ease.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

