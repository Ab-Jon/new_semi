import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/donate_screen.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final comments = [

      {
        "name": "Clinton Mike",
        "time": "4hrs ago",
        "avatar": "https://i.pravatar.cc/100?img=5",
        "text":
        "Small act of kindness is all we all need as humans to love in a world as earth. Therefore i enjoi all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans.",
        "views": 0,
        "comments": 0,
        "likes": 0,
        "reactions": 0,
      },
      {
        "name": "Michael Mike",
        "time": "4hrs ago",
        "avatar": "https://i.pravatar.cc/100?img=5",
        "text":
        "Small act of kindness is all we all need as humans to love in a world as earth. Therefore i enjoi all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans.",
        "views": 100,
        "comments": 3,
        "likes": 200,
        "reactions": 1000,
      },
      {
        "name": "Uche Jombo",
        "time": "4hrs ago",
        "avatar": "https://i.pravatar.cc/100?img=8",
        "text":
        "Small act of kindness is all we all need as humans to love in a world as earth. Therefore i enjoi all i mean everyone to give when they have the chance to give. It doesnt take us anything to be decent humans.",
        "views": 0,
        "comments": 0,
        "likes": 0,
        "reactions": 0,
      },
    ];

    return SingleChildScrollView(
      child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final item = comments[index];
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
                                backgroundImage: NetworkImage(item["avatar"].toString()),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                item["name"].toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            item["time"].toString(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["text"].toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),

                            if (item["views"] != 0 ||
                                item["comments"] != 0 ||
                                item["likes"] != 0 ||
                                item["reactions"] != 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.remove_red_eye, size: 18),
                                      const SizedBox(width: 4),
                                      Text(item["views"].toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.comment, size: 18),
                                      const SizedBox(width: 4),
                                      Text(item["comments"].toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.favorite, size: 18),
                                      const SizedBox(width: 4),
                                      Text(item["likes"].toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.emoji_emotions, size: 18),
                                      const SizedBox(width: 4),
                                      Text(item["reactions"].toString()),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (index == 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Add a comment",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DonateScreen()));
                  },
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
      ),
    );
  }
}
