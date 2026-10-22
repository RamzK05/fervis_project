
import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum ReportUiState {
  idle,
  loading,
  success,
  empty,
  error,
}

// Set to true temporarily to test the error state.
// Set to false for normal simulated submission.
const bool testErrorState = false;

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() =>
      _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  static const Color primaryColor = Color(0xFF167D75);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _categories = [
    'Road or Infrastructure',
    'Drainage or Flooding',
    'Waste or Environmental Concern',
    'Other Community Concern',
  ];

  String? _selectedCategory;
  String _submittedTitle = '';
  ReportUiState _uiState = ReportUiState.idle;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (_uiState == ReportUiState.loading) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _uiState = ReportUiState.loading;
    });

    try {
      // Simulates waiting for a future server request.
      await Future<void>.delayed(
        const Duration(seconds: 10),
      );

      if (!mounted) return;

      // Testing only: no real server request is made.
      if (testErrorState) {
        throw Exception('Submission failure');
      }

      setState(() {
        _submittedTitle = _titleController.text.trim();
        _uiState = ReportUiState.success;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _uiState = ReportUiState.error;
      });
    }
  }

  void _showEmptyState() {
    setState(() {
      _uiState = ReportUiState.empty;
    });
  }

  void _createAnotherReport() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _locationController.clear();
    _descriptionController.clear();

    setState(() {
      _selectedCategory = null;
      _uiState = ReportUiState.idle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'BayanSense',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF183B38),
          ),
        ),
        leading: IconButton(
          tooltip: 'Back to Home',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: _buildCurrentState(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentState() {
    switch (_uiState) {
      case ReportUiState.empty:
        return _buildEmptyState();

      case ReportUiState.success:
        return _buildSuccessState();

      case ReportUiState.idle:
      case ReportUiState.loading:
      case ReportUiState.error:
        return _buildForm();
    }
  }

  Widget _buildForm() {
    final isLoading = _uiState == ReportUiState.loading;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE5ECE9),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.campaign_outlined,
              color: primaryColor,
              size: 48,
            ),
            const SizedBox(height: 12),
            const Text(
              'Report a Community Concern',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183B38),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Provide details to help organize your barangay concern.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF647571),
              ),
            ),
            const SizedBox(height: 28),

            if (_uiState == ReportUiState.loading)
              _stateMessage(
                icon: Icons.hourglass_top_rounded,
                title: 'Submitting your report...',
                message:
                    'Please wait while the request is processing.',
                color: primaryColor,
              ),

            if (_uiState == ReportUiState.error)
              _stateMessage(
                icon: Icons.error_outline_rounded,
                title: 'Submission failed',
                message:
                    'The request failed. Tap Retry to try again.',
                color: Colors.red.shade700,
              ),

            if (_uiState == ReportUiState.error)
              const SizedBox(height: 20),

            AppTextField(
              controller: _titleController,
              label: 'Report Title',
              hint: 'e.g. Damaged road near the barangay hall',
              prefixIcon: Icons.title_rounded,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a report title.';
                }
                if (value.trim().length < 5) {
                  return 'Title must be at least 5 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Concern Category',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF29433F),
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              isExpanded: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.category_outlined,
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAF9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              hint: const Text('Select a category'),
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a concern category.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            AppTextField(
              controller: _locationController,
              label: 'Location or Purok',
              hint: 'Enter the location of the concern',
              prefixIcon: Icons.location_on_outlined,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the location.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            AppTextField(
              controller: _descriptionController,
              label: 'Description',
              hint: 'Describe the concern in your community',
              prefixIcon: Icons.description_outlined,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please describe the concern.';
                }
                if (value.trim().length < 10) {
                  return 'Description must be at least 10 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: LinearProgressIndicator(
                  color: primaryColor,
                ),
              ),

            AppButton(
              label: isLoading
                  ? 'Submitting...'
                  : _uiState == ReportUiState.error
                      ? 'Retry Submission'
                      : 'Submit Report',
              icon: isLoading
                  ? Icons.hourglass_empty_rounded
                  : _uiState == ReportUiState.error
                      ? Icons.refresh_rounded
                      : Icons.send_rounded,
              onPressed: isLoading ? null : _submitReport,
            ),
            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: isLoading ? null : _showEmptyState,
              icon: const Icon(Icons.inbox_outlined),
              label: const Text(
                'View Reports',
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return _stateCard(
      icon: Icons.check_circle_outline_rounded,
      color: Colors.green.shade700,
      title: 'Report Submitted Successfully!',
      message:
          'Your report "$_submittedTitle" passed the '
          'submission process.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          AppButton(
            label: 'Create Another Report',
            icon: Icons.add_rounded,
            onPressed: _createAnotherReport,
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _showEmptyState,
            child: const Text('View Reports'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return _stateCard(
      icon: Icons.inbox_outlined,
      color: primaryColor,
      title: 'No Reports Available',
      message:
          'There are no report records to display.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          AppButton(
            label: 'Create a Report',
            icon: Icons.add_rounded,
            onPressed: _createAnotherReport,
          ),
        ],
      ),
    );
  }

  Widget _stateCard({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE5ECE9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(icon, color: color, size: 64),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183B38),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.6,
              color: Color(0xFF506660),
            ),
          ),
          const SizedBox(height: 28),
          child,
        ],
      ),
    );
  }

  Widget _stateMessage({
    required IconData icon,
    required String title,
    required String message,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
