import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/hostel.dart';

class AddHostelScreen extends StatefulWidget {
  const AddHostelScreen({Key? key}) : super(key: key);

  @override
  State<AddHostelScreen> createState() => _AddHostelScreenState();
}

class _AddHostelScreenState extends State<AddHostelScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController door = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController locality = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();

  final List<String> amenities = [
    "Free WiFi",
    "Meals",
    "24/7 Security",
    "Common Area",
    "Gym",
    "Study Room",
    "Laundry",
    "Hot Water",
  ];

  final List<String> selected = [];

  void toggleAmenity(String a) {
    setState(() {
      selected.contains(a) ? selected.remove(a) : selected.add(a);
    });
  }

  void submit() {
    if (name.text.trim().isEmpty) return;

    final hostel = Hostel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.text.trim(),
      about: desc.text.trim(),
      location:
          "${door.text}, ${landmark.text}, ${locality.text}, ${city.text}, ${stateCtrl.text}",
      rating: 0,
      reviews: 0,
      amenities: selected,
      isJoined: false,
    );

    Navigator.pop(context, hostel);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add Hostel"),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hostel Name", style: AppStyles.body1),
            TextField(controller: name),
            const SizedBox(height: 16),

            Text("Description", style: AppStyles.body1),
            TextField(controller: desc, maxLines: 3),
            const SizedBox(height: 20),

            Text("Location", style: AppStyles.heading3),
            const SizedBox(height: 20),

            TextField(
              controller: door,
              decoration: const InputDecoration(labelText: "Door No"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: landmark,
              decoration: const InputDecoration(
                labelText: "Landmark/Building Name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locality,
              decoration: const InputDecoration(labelText: "Locality"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: city,
              decoration: const InputDecoration(labelText: "City"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: stateCtrl,
              decoration: const InputDecoration(labelText: "State"),
            ),

            const SizedBox(height: 20),

            Text("Amenities", style: AppStyles.heading3),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: amenities.map((a) {
                final sel = selected.contains(a);
                return GestureDetector(
                  onTap: () => toggleAmenity(a),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? AppColors.primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: sel ? AppColors.primaryBlue : Colors.grey,
                      ),
                    ),
                    child: Text(
                      a,
                      style: TextStyle(
                        color: sel ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Add Hostel"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
