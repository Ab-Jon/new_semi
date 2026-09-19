import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:semi_bill/presentation/draw_home.dart';
import 'package:semi_bill/presentation/promo_banner.dart';
import 'package:semi_bill/presentation/services/airtime/airtime_home.dart';
import 'package:semi_bill/presentation/services/crowdfund/crowd_fund.dart';
import 'package:semi_bill/presentation/services/service_main.dart';
import 'package:semi_bill/presentation/services/tickets/event_tickets.dart';
import 'package:semi_bill/presentation/wallet/statement/statement_report.dart';
import 'package:semi_bill/presentation/wallet/transfer/gift_user_page.dart';
import 'package:semi_bill/presentation/wallet/wallet_bottom_sheet.dart';
import 'package:semi_bill/presentation/wallet/withdrawal_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class WalletDashboardScreen extends ConsumerWidget {
  WalletDashboardScreen({super.key});
  final balanceVisibilityProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.pageBg,
      drawer: const DrawerContent(),
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: Builder(
          builder: (ctx) => IconButton(
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            icon: Icon(Ionicons.menu_outline, color: context.semi.textPrimary),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Ionicons.headset_outline, color: context.semi.textPrimary),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Ionicons.notifications_outline, color: context.semi.textPrimary),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hi, Ubokobong',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: context.isDark ? SemiColors.surfaceDark : const Color(0xFFF6F4FA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          'US',
                          theme: const ImageTheme(shape: Circle(), width: 18),
                        ),
                        const SizedBox(width: 6),
                        const Text('EN', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Center(
                child: Text(
                  'Main Balance',
                  style: TextStyle(fontSize: 14, color: context.semi.muted),
                ),
              ),
              const SizedBox(height: 6),
              Consumer(
                builder: (context, ref, _) {
                  final isVisible = ref.watch(balanceVisibilityProvider);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isVisible ? '₦24,100.00' : '********',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: () {
                          ref.read(balanceVisibilityProvider.notifier).state = !isVisible;
                        },
                        icon: Icon(
                          isVisible ? Ionicons.eye_outline : Ionicons.eye_off_outline,
                          color: context.brand,
                          size: 22,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SemiIconAction(
                    icon: Ionicons.add,
                    label: 'Deposit',
                    onTap: () => WalletDepositSheet.show(context),
                  ),
                  SemiIconAction(
                    icon: Ionicons.arrow_up_outline,
                    label: 'Withdraw',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WithdrawalScreen()),
                      );
                    },
                  ),
                  SemiIconAction(
                    icon: Ionicons.swap_horizontal_outline,
                    label: 'Transfer',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GiftUserPage()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Services',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              SemiCard(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.82,
                  children: [
                    SemiServiceTile(
                      icon: Ionicons.call_outline,
                      label: 'Airtime',
                      onTap: () => _open(context, const AirtimeScreen()),
                    ),
                    SemiServiceTile(
                      icon: Ionicons.ticket_outline,
                      label: 'Ticket',
                      onTap: () => _open(context, const EventsScreen()),
                    ),
                    SemiServiceTile(
                      icon: Ionicons.people_outline,
                      label: 'Crowd',
                      onTap: () => _open(context, const CrowdfundingPage()),
                    ),
                    SemiServiceTile(
                      icon: Ionicons.grid_outline,
                      label: 'More',
                      onTap: () => _open(context, const ServicesScreen()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const PromoBannerSlider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transaction',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StatementReportPage()),
                      );
                    },
                    child: Text(
                      'See all →',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: context.brand,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _tx(context, 'assets/avatar_1.jpg', 'Withdraw', 'Paid 30 mins ago', '₦100.15'),
              const SizedBox(height: 8),
              _tx(context, 'assets/avatar_1.jpg', 'Withdraw', 'Paid 30 mins ago', '₦100.15'),
              const SizedBox(height: 20),
              const Text(
                'Report',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _report(context, Ionicons.document_text_outline, 'Statement', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StatementReportPage()),
                    );
                  }),
                  _report(context, Ionicons.time_outline, 'Dispute', () {}),
                  _report(context, Ionicons.stats_chart_outline, 'Statistics', () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _tx(
    BuildContext context,
    String avatar,
    String title,
    String subtitle,
    String amount,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SemiAvatar(size: 44, asset: avatar),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: context.semi.muted),
                ),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          const Icon(Icons.north_east, size: 14, color: SemiColors.danger),
        ],
      ),
    );
  }

  Widget _report(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: context.isDark ? SemiColors.cardDark : const Color(0xFFF6F4FA),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, color: context.brand, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
