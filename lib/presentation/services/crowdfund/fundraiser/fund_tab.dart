import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/fund_comment.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/fund_raise.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/fund_update.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class CampaignDetailsScreen extends StatelessWidget {
  const CampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.pageBg,
        appBar: AppBar(
          backgroundColor: context.pageBg,
          leading: const SemiBackButton(),
          title: const Text("Brother's Gathering"),
          bottom: TabBar(
            labelColor: context.brand,
            unselectedLabelColor: context.semi.muted,
            indicatorColor: context.brand,
            indicatorWeight: 2.4,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Updates'),
              Tab(text: 'Comments'),
            ],
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
