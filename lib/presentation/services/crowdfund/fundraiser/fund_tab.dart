import 'package:flutter/material.dart';

class CampaignDetailsScreen extends StatelessWidget {
  const CampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,

          title: const Text(
            "",
            style: TextStyle(color: Colors.black),
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Column(
              children: [
                const TabBar(
                  labelColor: Color(0xFF3A0CA3),       // Active color
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Color(0xFF3A0CA3),
                  indicatorWeight: 2.5,
                  isScrollable: true,
                  tabs: [
                    Tab(text: "Overview"),
                    Tab(text: "Updates"),
                    Tab(text: "Comments"),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),

        body: const TabBarView(
          children: [
            // TODO: Replace these with your actual tab widgets
            Center(child: Text("Overview Tab Placeholder")),
            Center(child: Text("Updates Tab Placeholder")),
            Center(child: Text("Comments Tab Placeholder")),
          ],
        ),
      ),
    );
  }
}
