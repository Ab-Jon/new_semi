import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/internet/internet_summary.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({super.key});

  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> providers = ["Smile", "Spectranet", "Swift", "Airtel Fiber"];
  String selectedProvider = "Smile";

  final List<Map<String, dynamic>> dataPlans = [
    {"size": "200MB", "days": "3 Days", "amount": "₦200"},
    {"size": "500MB", "days": "3 Days", "amount": "₦200"},
    {"size": "1000MB", "days": "3 Days", "amount": "₦200"},
    {"size": "500MB", "days": "3 Days", "amount": "₦200"},
    {"size": "500MB", "days": "3 Days", "amount": "₦200"},
    {"size": "1000MB", "days": "3 Days", "amount": "₦200"},
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "Internet",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [

            const SizedBox(height: 10),

            /// 🔵 TOP BANNER (same as Airtime screen)
            _buildBanner(),

            const SizedBox(height: 20),

            /// 🔵 INTERNET PROVIDER DROPDOWN
            _buildProviderCard(),

            const SizedBox(height: 20),

            /// 🔵 DATA PLAN SECTION
            _buildDataPlanCard(),

            const SizedBox(height: 20),

            /// 🔵 MAKE PAYMENT BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // handle navigation
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => InternetSummaryScreen(
                              amount: 100,
                              phone: "09059837082",
                              network: "MTN")));
                },
                child: const Text("Make Payment", style: TextStyle(color: Colors.white),),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // 🔵 Reusable Widgets
  // ------------------------------------------------------------

  Widget _buildBanner() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          /// Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/gift_banner.jpg", // use your real banner asset
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),

          /// User row
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/avatar_1.jpg"),
              ),
              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  "09045687844",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_search_outlined, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProviderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Internet Provider",
              style: TextStyle(fontWeight: FontWeight.w600)),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: selectedProvider,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: providers
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (value) => setState(() => selectedProvider = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildDataPlanCard() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select data Plan",
              style: TextStyle(fontWeight: FontWeight.w600)),

          const SizedBox(height: 10),

          /// Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: "search",
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceBright,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// TAB BAR
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.surface,
            indicatorColor: isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE),
            tabs: const [
              Tab(text: "Hot"),
              Tab(text: "Daily"),
              Tab(text: "Weekly"),
              Tab(text: "Monthly"),
            ],
          ),

          const SizedBox(height: 16),

          /// DATA PLANS GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataPlans.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, i) {
              final item = dataPlans[i];
              return _buildPlanItem(
                size: item["size"],
                days: item["days"],
                amount: item["amount"],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItem({required String size, required String days, required String amount}) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(size, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(days, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
