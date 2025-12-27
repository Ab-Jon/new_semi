import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/airtime/airtime_amount.dart';

class AirtimeScreen extends StatelessWidget {
  const AirtimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Airtime",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      backgroundColor: isLight
          ? const Color(0xFF2B124C)
          : const Color(0xFF632AAE),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // PROMO BANNER CARD
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Top promo image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      "assets/images/gift_banner.jpg", // <-- replace with your banner
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Avatar + Phone + Fav
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage("assets/avatar_1.png"),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "09045667844",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Icon(Icons.favorite_outline, color: isLight
                              ? const Color(0xFF2B124C)
                              : const Color(0xFF632AAE),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // SELECT NETWORK CARD
            _buildSectionCard(
              title: "Select Network",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _networkButton("MTN", "assets/images/mtn.png", context),
                  _networkButton("9 Mobile", "assets/images/9mobile.png", context),
                  _networkButton("Airtel", "assets/images/airtel.png", context),
                  _networkButton("Glo", "assets/images/glo.png", context),
                ],
              ), context: context,
            ),
            const SizedBox(height: 20),
            // SELECT BENEFICIARY CARD

            _buildSectionCard(
              title: "Select Beneficiary",
              child: Column(
                children: [
                  // Search box
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 20, color: isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE),),
                        const SizedBox(width: 8),
                        const Text(
                          "search Beneficiary",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _beneficiaryTile("assets/avatar_1.png", "08134243438"),
                  _beneficiaryTile("assets/avatar_1.png", "08134243438"),
                  _beneficiaryTile("assets/avatar_1.png", "08134243438"),
                ],
              ), context: context,
            ),
            const SizedBox(height: 30),
            // PROCEED BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AirtimeAmountScreen(phone: "", network: "")));
                },
                child: const Text(
                  "Proceed",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  // REUSABLE SECTION CARD

  Widget _buildSectionCard({required String title, required Widget child, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
  // NETWORK BUTTON
  Widget _networkButton(String label, String asset, BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: 45,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(asset),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
  // BENEFICIARY TILE
  Widget _beneficiaryTile(String avatar, String number) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: AssetImage(avatar)),
            const SizedBox(width: 12),
            Text(number, style: const TextStyle(fontSize: 14)),
          ],
        ),
        const Divider(height: 18),
      ],
    );
  }
}
