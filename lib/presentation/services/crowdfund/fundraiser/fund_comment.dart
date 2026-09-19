import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/donate_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    const comments = [
      (
        name: 'Clinton Mike',
        time: '4hrs ago',
        text:
            'A small act of kindness is all we need. Give when you have the chance — it does not take much to be decent humans.',
        views: 0,
        comments: 0,
        likes: 0,
      ),
      (
        name: 'Michael Mike',
        time: '4hrs ago',
        text:
            'A small act of kindness is all we need. Give when you have the chance — it does not take much to be decent humans.',
        views: 100,
        comments: 3,
        likes: 200,
      ),
      (
        name: 'Uche Jombo',
        time: '4hrs ago',
        text:
            'A small act of kindness is all we need. Give when you have the chance — it does not take much to be decent humans.',
        views: 0,
        comments: 0,
        likes: 0,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        for (var i = 0; i < comments.length; i++) ...[
          Row(
            children: [
              const SemiAvatar(size: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  comments[i].name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Text(comments[i].time, style: TextStyle(color: context.semi.muted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comments[i].text, style: const TextStyle(fontSize: 14, height: 1.4)),
                if (comments[i].likes > 0) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Ionicons.eye_outline, size: 16, color: context.iconTint),
                      const SizedBox(width: 4),
                      Text('${comments[i].views}'),
                      const Spacer(),
                      Icon(Ionicons.chatbubble_outline, size: 16, color: context.iconTint),
                      const SizedBox(width: 4),
                      Text('${comments[i].comments}'),
                      const Spacer(),
                      Icon(Ionicons.heart_outline, size: 16, color: context.iconTint),
                      const SizedBox(width: 4),
                      Text('${comments[i].likes}'),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (i == 0) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: context.isDark ? SemiColors.surfaceDark : const Color(0xFFF6F4FA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text('Add a comment', style: TextStyle(color: context.semi.muted)),
            ),
          ],
          const SizedBox(height: 18),
        ],
        SemiButton(
          label: 'Donate Now',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const DonateScreen()));
          },
        ),
      ],
    );
  }
}
