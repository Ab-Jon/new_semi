import 'package:flutter/material.dart';

class FundraiserDetailsScreen extends StatelessWidget {
  const FundraiserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- TOP TAB BAR (Overview | Updates | Comments) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Updates", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text("Comments", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),

                // --- TOP BIG IMAGE ---
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/brothers.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Days left
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("18 days left", style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),

                const SizedBox(height: 4),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Brother's Gathering",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),

                const SizedBox(height: 16),

                // --- SHARE + DONATION CARD ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Spread the word on", style: TextStyle(fontSize: 14, color: Colors.black54)),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Image.asset("assets/icons/instagram.png", height: 26),
                            SizedBox(width: 12),
                            Image.asset("assets/icons/facebook.png", height: 26),
                            SizedBox(width: 12),
                            Image.asset("assets/icons/telegram.png", height: 26),
                            SizedBox(width: 12),
                            Image.asset("assets/icons/whatsapp.png", height: 26),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("700 raised", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            Text("1500 Left", style: TextStyle(color: Colors.grey)),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Text("Last Donation: 6 days ago", style: TextStyle(color: Colors.grey)),
                            Spacer(),
                            Icon(Icons.people, size: 18, color: Colors.orange),
                            SizedBox(width: 4),
                            Text("120 donors", style: TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // --- SECOND TAB BAR (Campaign Details | About the Fundraiser) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    indicatorColor: Color(0xFF3A0CA3),
                    indicatorWeight: 2.4,
                    tabs: const [
                      Tab(text: "Campaign Details"),
                      Tab(text: "About the Fundraiser"),
                    ],
                  ),
                ),

                SizedBox(
                  height: 350,
                  child: TabBarView(
                    children: [
                      // --- TAB 1: Campaign Details ---
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Brothers Grathering@2024",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "brothers gathering is a Small act of kindness is all we all need as humans to love in a wolrld as earth. Therefore i enjoin all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans.",
                              style: TextStyle(fontSize: 15, height: 1.45),
                            ),
                          ],
                        ),
                      ),

                      // --- TAB 2: About Fundraiser ---
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: AssetImage("assets/images/fundraiser_dp.png"),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mr Judeen Igwe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text("Fundraiser", style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                Spacer(),
                                Text("View Profile", style: TextStyle(color: Color(0xFF3A0CA3), fontWeight: FontWeight.bold)),
                              ],
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              "Brother’s Gatherine",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Mr Judeen is a Passionate about fostering faith and community, I blend RCCG teachings with the power of faith to transform lives. Together, we grow in Christ, embracing love, service, and spiritual wisdom in our daily lives. Let's journey in faith and purpose as one church and family.",
                              style: TextStyle(fontSize: 15, height: 1.45),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- DONATE BUTTON ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3A0CA3),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Donate Now",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
