import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semi_bill/presentation/drawer_screens/crowd_funding/photo_preview.dart';


class PostCrowdPage extends StatefulWidget {
  const PostCrowdPage({super.key});

  @override
  State<PostCrowdPage> createState() => _PostCrowdPageState();
}

class _PostCrowdPageState extends State<PostCrowdPage> {

  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Post Content",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================== ADD PHOTO BOX ===================
            PhotoPickerPreview(
              onImageSelected: (img) {
                setState(() {
                  _selectedImage = img;
                });
              },
            ),
            const SizedBox(height: 20),

            // =================== TITLE ===================
            Text(
              "Title",
              style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              decoration: InputDecoration(
                hintText: "Brothers Gathering",
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =================== EVENT DESCRIPTION ===================
            Text(
              "Event Description",
              style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter description",
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =================== VENUE NAME ===================
            const Text(
              "Venue Name",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              decoration: InputDecoration(
                hintText: "Jbees Hotel",
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =================== LOCATION ===================
            const Text(
              "Location",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              decoration: InputDecoration(
                hintText: "21, Ugbomro Avenue",
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================== DATE & TIME HEADER ===================
            Row(
              children: const [
                Text(
                  "Event Date & Time",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 6),
                Text(
                  "max 60 days",
                  style: TextStyle(fontSize: 11, color: Colors.red),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // =================== START DATE & TIME ===================
            Row(
              children: [
                Expanded(
                  child: _dateBox(
                    "Start",
                    "4th Oct",
                    Icons.calendar_today_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: _dateBox("Time", "10AM", Icons.access_time)),
              ],
            ),

            const SizedBox(height: 15),

            // =================== END DATE & TIME ===================
            Row(
              children: [
                Expanded(
                  child: _dateBox(
                    "End",
                    "7th Oct",
                    Icons.calendar_today_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: _dateBox("Time", "10AM", Icons.access_time)),
              ],
            ),

            const SizedBox(height: 15),
            // =================== AMOUNT TO BE RAISED ===================
            const Text(
              "Amount to be raised",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Amount",
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================== CATEGORY ===================
            const Text(
              "Category",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: [
                categoryChip("Charity", true),
                categoryChip("Community Project", false),
                categoryChip("Social Causes", false),
                categoryChip("Creative arts", false),
                categoryChip("Sustainability", false),
                categoryChip("Sports", false),
                categoryChip("Events", false),
                categoryChip("Health", false),
                categoryChip("Education", false),
              ],
            ),

            const SizedBox(height: 25),

            // =================== POST VISIBILITY ===================
            const Text(
              "Post Visibility",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                visibilityChip("Private Post", true),
                const SizedBox(width: 12),
                visibilityChip("Public Post", false),
              ],
            ),

            const SizedBox(height: 25),

            // =================== LISTED BY ===================
            const Text(
              "Listed By",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                visibilityChip("Campaigner", true),
                const SizedBox(width: 12),
                visibilityChip("Beneficiary", false),
              ],
            ),

            const SizedBox(height: 15),

            TextField(
              decoration: InputDecoration(
                hintText: "Enter Beneficiary name",
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =================== PROMOTION ===================
            const Text(
              "Promote your Event",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: [
                promoChip("Free Promotion", true),
                promoChip("7 days  ₦7000", false),
                promoChip("1 Month  ₦10,000", false),
                promoChip("Premium  ₦20,000", false),
              ],
            ),

            const SizedBox(height: 40),

            // =================== SUBMIT BUTTON ===================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // =================== Helper Widgets ===================

  Widget _dateBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(icon, size: 20, color: Theme.of(context).colorScheme.surface),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryChip(String text, bool selected) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE) : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE)
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 18,
            color: selected ? Colors.white : Theme.of(context).colorScheme.surface,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget visibilityChip(String text, bool selected) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE) : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Theme.of(context).colorScheme.surface,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget promoChip(String text, bool selected) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE) : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Theme.of(context).colorScheme.surface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
