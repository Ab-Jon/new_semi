import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semi_bill/presentation/drawer_screens/crowd_funding/photo_preview.dart';

class PostEventScreen extends StatefulWidget {
  const PostEventScreen({super.key});

  @override
  State<PostEventScreen> createState() => _PostEventScreenState();
}

class _PostEventScreenState extends State<PostEventScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController venueCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController ticketsCtrl = TextEditingController();

  XFile? _selectedImage;

  String? ticketType = "General";
  String? refundPolicy = "Non-Refundable";
  String? postVisibility = "Private Post";
  String? listedBy = "Owner";
  String? promotion = "Free";

  DateTime? startDate;
  TimeOfDay? startTime;
  DateTime? endDate;
  TimeOfDay? endTime;

  List<String> selectedCategories = ["Birthday"];
  List<String> categories = [
    "Birthday","Concert","Sport","Theatre","Festival","Travel","Music",
    "Seminar","Education","Performance","Conference"
  ];

  List<String> ticketTypes = ["General", "Regular", "VIP", "VVIP", "Premium"];
  List<String> refundOptions = ["Non-Refundable", "Partial Refund", "Total Refund"];
  List<String> visibilityOptions = ["Private Post", "Public Post"];
  List<String> listedOptions = ["Owner", "Agent", "Merchant"];

  List<String> ticketsPerPerson = ["No Limit", "1", "2", "3", "4"];
  String? selectedTicketLimit = "No Limit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Event"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- PHOTO BOX ----------
            PhotoPickerPreview(onImageSelected: (img) {
              setState(() {
                _selectedImage = img;
              });
            }),

            const SizedBox(height: 20),

            _title("Name of Event"),
            _input(nameCtrl),

            _title("Event Description"),
            _input(descCtrl, maxLines: 3, hint: "Enter number of tickets to sell"),

            _title("Venue Name"),
            _input(venueCtrl),

            _title("Location"),
            _input(locationCtrl),

            const SizedBox(height: 20),
            _title("Event Date & Time"),

            Row(
              children: [
                Expanded(child: _dateSelector("Start")),
                const SizedBox(width: 10),
                Expanded(child: _timeSelector("Start")),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _dateSelector("End")),
                const SizedBox(width: 10),
                Expanded(child: _timeSelector("End")),
              ],
            ),

            const SizedBox(height: 25),
            _title("Tickets Type"),
            Wrap(
              spacing: 8,
              children: ticketTypes.map((e) {
                return ChoiceChip(
                  label: Text(e),
                  selected: ticketType == e,
                  onSelected: (_) => setState(() => ticketType = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            _title("Amount"),
            _input(amountCtrl, hint: "Enter Amount"),

            const SizedBox(height: 20),
            _title("Category"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((e) {
                return FilterChip(
                  label: Text(e),
                  selected: selectedCategories.contains(e),
                  onSelected: (v) {
                    setState(() {
                      v ? selectedCategories.add(e) : selectedCategories.remove(e);
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 25),
            _title("Refund Policy"),
            Wrap(
              spacing: 10,
              children: refundOptions.map((e) {
                return ChoiceChip(
                  label: Text(e),
                  selected: refundPolicy == e,
                  onSelected: (_) => setState(() => refundPolicy = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 25),
            _title("Post Visibility"),
            Wrap(
              spacing: 10,
              children: visibilityOptions.map((e) {
                return ChoiceChip(
                  label: Text(e),
                  selected: postVisibility == e,
                  onSelected: (_) => setState(() => postVisibility = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 25),
            _title("Listed By"),
            Wrap(
              spacing: 10,
              children: listedOptions.map((e) {
                return ChoiceChip(
                  label: Text(e),
                  selected: listedBy == e,
                  onSelected: (_) => setState(() => listedBy = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            _title("Available Tickets"),
            _input(ticketsCtrl),

            const SizedBox(height: 25),
            _title("Tickets Available per Person"),
            Wrap(
              spacing: 10,
              children: ticketsPerPerson.map((e) {
                return ChoiceChip(
                  label: Text(e),
                  selected: selectedTicketLimit == e,
                  onSelected: (_) => setState(() => selectedTicketLimit = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 25),
            _title("Promote your Event"),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: const Text("Free Promotion"),
                  selected: promotion == "Free",
                  onSelected: (_) => setState(() => promotion = "Free"),
                ),
                ChoiceChip(
                  label: const Text("7 Days ₦7000"),
                  selected: promotion == "7 Days",
                  onSelected: (_) => setState(() => promotion = "7 Days"),
                ),
                ChoiceChip(
                  label: const Text("1 Month ₦10,000"),
                  selected: promotion == "1 Month",
                  onSelected: (_) => setState(() => promotion = "1 Month"),
                ),
                ChoiceChip(
                  label: const Text("Premium ₦20,000"),
                  selected: promotion == "Premium",
                  onSelected: (_) => setState(() => promotion = "Premium"),
                ),
              ],
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------

  Widget _input(TextEditingController c, {int maxLines = 1, String? hint}) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 15),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _dateSelector(String label) {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        setState(() {
          if (label == "Start") startDate = picked;
          else endDate = picked;
        });
      },
      child: _selectorBox(
        label,
        (label == "Start" ? startDate : endDate)?.toString().split(" ").first ?? label,
      ),
    );
  }

  Widget _timeSelector(String label) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        setState(() {
          if (label == "Start") startTime = picked;
          else endTime = picked;
        });
      },
      child: _selectorBox(
        label,
        (label == "Start" ? startTime : endTime)?.format(context) ?? "Time",
      ),
    );
  }

  Widget _selectorBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(value),
              const Spacer(),
              const Icon(Icons.calendar_month, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
