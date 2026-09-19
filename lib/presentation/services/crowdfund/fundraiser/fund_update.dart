import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/donate_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class UpdatesTab extends StatelessWidget {
  const UpdatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    const updates = [
      ('Sir Wise', '4hrs ago'),
      ('Uche Jombo', '4hrs ago'),
      ('Confucius', '4hrs ago'),
      ('Sir Unwana', '4hrs ago'),
    ];
    const body =
        'A small act of kindness is all we need. Give when you have the chance — it does not take much to be decent humans.';

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        for (final item in updates) ...[
          Row(
            children: [
              const SemiAvatar(size: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Text(item.$1, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
              Text(item.$2, style: TextStyle(color: context.semi.muted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(fontSize: 14, height: 1.4)),
          Divider(height: 28, color: context.hairline),
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
