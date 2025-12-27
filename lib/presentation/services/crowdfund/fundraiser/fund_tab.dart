import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/fund_comment.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/fund_raise.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/fund_update.dart';

class CampaignDetailsScreen extends StatelessWidget {
  const CampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          automaticallyImplyLeading: true,

          title: const Text(
            "",
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Column(
              children: [
                TabBar(
                  labelColor: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),       // Active color
                  unselectedLabelColor: isLight? Colors.black : Colors.white,
                  indicatorColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  indicatorWeight: 2.5,
                  isScrollable: true,
                  tabs: const [
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
            FundraiserDetailsScreen(),
            UpdatesTab(),
            CommentsTab(),
          ],
        ),
      ),
    );
  }
}
