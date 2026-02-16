import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ionicons/ionicons.dart';
import 'package:semi_bill/presentation/draw_home.dart';
import 'package:semi_bill/presentation/promo_banner.dart';
import 'package:semi_bill/presentation/wallet/transfer/gift_user_page.dart';
import 'package:semi_bill/presentation/wallet/wallet_bottom_sheet.dart';
import 'package:semi_bill/presentation/wallet/withdrawal_screen.dart';

class WalletDashboardScreen extends ConsumerWidget {
  WalletDashboardScreen({super.key});
  final balanceVisibilityProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF0F0F0F) // DARK MODE
          : Colors.grey.shade100,
      drawer: const DrawerContent(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF0F0F0F) // DARK MODE
            : Colors.grey.shade100, // LIGHT MODE
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            icon: Icon(
              Ionicons.headset_outline,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.notifications_outline,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Container(
                padding: const EdgeInsets.all(10),
                height: 70.0,
                decoration: BoxDecoration(
                  color: isLight? Colors.white : const Color(0xFF161616),
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hi, Ubokobong",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isLight ? Colors.grey.shade100 : const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CountryFlag.fromCountryCode(
                              'US',
                          theme: const ImageTheme(
                            shape: Circle(),
                            width: 25,
                          ),),
                          const SizedBox(width: 4),
                          const Text("EN", style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Balance Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text(
                        "Main Balance",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 80.0),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final isVisible = ref.watch(
                            balanceVisibilityProvider,
                          );
                          return Row(
                            children: [
                              Center(
                                child: Text(
                                  isVisible ? "₦24,100.00" : "********",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: IconButton(
                                  onPressed: () {
                                    ref.read(balanceVisibilityProvider.notifier).state = !isVisible;
                                  },
                                  icon: Icon(
                                    isVisible
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _actionButton(context, Icons.add, "Deposit", () {
                          WalletDepositSheet.show(context);
                        }),
                        _actionButton(
                          context,
                          Icons.arrow_upward,
                          "Withdraw",
                          () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => WithdrawalScreen()));
                          },
                        ),
                        _actionButton(
                          context,
                          Icons.swap_horiz,
                          "Transfer",
                          () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => GiftUserPage()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Services
              const Text(
                "Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isLight? Colors.white : const Color(0xFF161616),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio:0.85,
                    children: [
                      _serviceItem(
                        Ionicons.call_outline,
                        "Airtime",
                        context,
                      ),
                      _serviceItem(Ionicons.ticket_outline, "Ticket", context),
                      _serviceItem(
                        Ionicons.people_outline,
                        "Crowd",
                        context,
                      ),
                      _serviceItem(Ionicons.grid_outline, "More", context),
                    ],
                  ),
                ),
              const SizedBox(height: 15),
              // Promo Banner
              PromoBannerSlider(),
              const SizedBox(height: 15),
              // Recent Transactions
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isLight? Colors.white : const Color(0xFF161616),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Recent Transaction",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "See all →",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _transactionItem(
                      avatar: "https://i.pravatar.cc/100?img=5",
                      title: "Withdraw",
                      subtitle: "Paid 30 mins ago",
                      amount: "₦100.15",
                      color: Colors.red,
                      context: context,
                    ),
                    const SizedBox(height: 10),
                    _transactionItem(
                      avatar: "https://i.pravatar.cc/100?img=8",
                      title: "Withdraw",
                      subtitle: "Paid 30 mins ago",
                      amount: "₦100.15",
                      color: Colors.red,
                      context: context,
                    ),
                  ],
                )
              ),
              const SizedBox(height: 15),
              // Second Promo
              PromoBannerSlider(),
              const SizedBox(height: 15),
              // Report Section
              const Text(
                "Report",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _reportButton(
                    Icons.call_outlined,
                    "Statement",
                    context,
                  ),
                  _reportButton(Icons.history_outlined, "Dispute History", context),
                  _reportButton(Icons.bar_chart_outlined, "Statistics", context),
                ],
              ),
              const SizedBox(height: 100), // reduced from 80 to 30
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isLight ? Colors.white: const Color(0xFF1E1E1E),
                boxShadow: isLight
                    ? [] // ❌ no shadow in light mode
                    : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
                borderRadius: BorderRadius.circular(25)),
            child: Icon(
              icon,
              color:  isLight
                  ? Colors.black
                  : Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _serviceItem(IconData icon, String title, BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isLight ? Color(0xFF632AAE).withOpacity(0.08) : const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                icon,
                size: 28,
                color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),
              ),
            ),
        const SizedBox(height: 7),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),

      ],
    );
  }

  Widget _transactionItem({
    required String avatar,
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
    required BuildContext context,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isLight? Colors.white: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(avatar)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isLight ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(width: 5),

          Icon(
            Icons.north_east,
            size: 18,
            color: color, // Amount color you passed
          ),
        ],
      ),
    );
  }

  Widget _reportButton(IconData icon, String label, BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final Color iconColor = isLight
        ? const Color(0xFF2B124C)
        : const Color(0xFF632AAE);
    final Color textColor = isLight ? Colors.black : Colors.white;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: isLight? Colors.white : const Color(0xFF161616),
          borderRadius: BorderRadius.circular(12),
          // Optional: add background color here if needed
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isLight? Color(0xFF632AAE).withOpacity(0.08) : const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(10)
                ),
                  child: Icon(icon, color: iconColor)),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
