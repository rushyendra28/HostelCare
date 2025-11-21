import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/hostel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../data/complaint_data.dart';
import '../../models/complaint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostComplaintScreen extends StatefulWidget {
  final Hostel hostel;

  const PostComplaintScreen({Key? key, required this.hostel}) : super(key: key);

  @override
  State<PostComplaintScreen> createState() => _PostComplaintScreenState();
}

class _PostComplaintScreenState extends State<PostComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;
  bool _isSubmitting = false;
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString("username") ?? "Guest User";
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() => _selectedImage = image);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() => _selectedImage = image);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            ListTile(
              leading: _sheetIcon(
                AppColors.primaryBlue,
                Icons.camera_alt_rounded,
              ),
              title: _sheetTitle("Take Photo"),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),

            const SizedBox(height: 12),

            ListTile(
              leading: _sheetIcon(
                AppColors.primaryPurple,
                Icons.photo_library_rounded,
              ),
              title: _sheetTitle("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sheetIcon(Color color, IconData icon) => Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, color: color),
  );

  Text _sheetTitle(String text) =>
      Text(text, style: AppStyles.body1.copyWith(fontWeight: FontWeight.w600));

  void _removeImage() => setState(() => _selectedImage = null);

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);

    final newComplaint = Complaint(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      guestName: _userName,
      roomNumber: "N/A",
      submittedDate: DateTime.now(),
      status: ComplaintStatus.inProgress,
      photoUrl: _selectedImage?.path,
      hostelId: widget.hostel.id,
    );

    globalComplaints.add(newComplaint);

    if (!mounted) return;

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text('Complaint Submitted!', style: AppStyles.heading3),
              const SizedBox(height: 12),
              Text(
                'Your complaint has been submitted successfully.',
                textAlign: TextAlign.center,
                style: AppStyles.body2.copyWith(color: AppColors.textGray),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Done",
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _header(),
          Expanded(child: _formContent()),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.headerGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: _backButton(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Post a Problem',
                style: AppStyles.heading1.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton() => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
  );

  Widget _formContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _postedByCard(),
            const SizedBox(height: 20),
            _inputLabel("Problem Title"),
            const SizedBox(height: 12),
            CustomTextField(
              hint: "e.g., Water leakage in bathroom",
              controller: _titleController,
              validator: (v) => (v == null || v.isEmpty)
                  ? "Please enter a problem title"
                  : null,
            ),

            const SizedBox(height: 20),
            _inputLabel("Description"),
            const SizedBox(height: 12),
            CustomTextField(
              hint: "Describe the problem in detail...",
              controller: _descriptionController,
              maxLines: 6,
              validator: (v) => (v == null || v.isEmpty)
                  ? "Please enter a description"
                  : (v.length < 10
                        ? "Description must be at least 10 characters"
                        : null),
            ),

            const SizedBox(height: 20),
            _inputLabel("Photo (Optional)"),
            const SizedBox(height: 12),

            _selectedImage == null ? _photoBoxEmpty() : _photoBoxFilled(),

            const SizedBox(height: 32),
            CustomButton(
              text: "Submit Complaint",
              onPressed: _submitComplaint,
              isLoading: _isSubmitting,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _inputLabel(String text) => Text(
    text,
    style: AppStyles.body1.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.textDark,
    ),
  );

  Widget _postedByCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppStyles.cardDecoration,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Posted By",
                style: AppStyles.caption.copyWith(color: AppColors.textGray),
              ),
              const SizedBox(height: 4),
              Text(
                _userName,
                style: AppStyles.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _photoBoxEmpty() {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryBlue.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_rounded,
                  color: AppColors.primaryBlue,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Upload Photo",
                style: AppStyles.body1.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Tap to add a photo",
                style: AppStyles.caption.copyWith(color: AppColors.textGray),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photoBoxFilled() {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.file(
              File(_selectedImage!.path),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.close_rounded, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Photo attached",
                    style: AppStyles.caption.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
