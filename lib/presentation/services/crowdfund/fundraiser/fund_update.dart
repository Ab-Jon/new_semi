import 'package:flutter/material.dart';

class UpdatesTab extends StatelessWidget {
  const UpdatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final updates = [
      {
        "name": "Sir Wise",
        "time": "4hrs ago",
        "avatar": "https://i.pravatar.cc/100?img=5",
        "text":
        "Small act of kindness is all we all need as humans to love in a worlid as earth. Therefore i enjoi all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans."
      },
      {
        "name": "Uche Jombo",
        "time": "4hrs ago",
        "avatar": "https://i.pravatar.cc/100?img=8",
        "text":
        "Small act of kindness is all we all need as humans to love in a worlid as earth. Therefore i enjoi all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans."
      },
      {
        "name": "Confucius",
        "time": "4hrs ago",
        "avatar": "https://i.pravatar.cc/100?img=5",
        "text":
        "Small act of kindness is all we all need as humans to love in a worlid as earth. Therefore i enjoi all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans."
      },
      {
        "name": "Sir Unwana",
        "time": "4hrs ago",
        "avatar": "https://i.pravatar.cc/100?img=5",
        "text":
        "Small act of kindness is all we all need as humans to love in a worlid as earth. Therefore i enjoi all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans."
      },
    ];

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: updates.length,
          itemBuilder: (context, index) {
            final item = updates[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(item["avatar"]!),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item["name"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        item["time"]!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item["text"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // Donate button placed exactly like UI
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Donate Now",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
