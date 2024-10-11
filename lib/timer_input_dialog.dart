import 'package:flutter/material.dart';
import 'timer_utils.dart';

class TimerInputDialog extends StatefulWidget {
  const TimerInputDialog({super.key});

  @override
  _TimerInputDialogState createState() => _TimerInputDialogState();
}

class _TimerInputDialogState extends State<TimerInputDialog> {
  final TextEditingController _hoursController =
      TextEditingController(text: '0');
  final TextEditingController _minutesController =
      TextEditingController(text: '1');
  final TextEditingController _secondsController =
      TextEditingController(text: '0');

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners to match the style
      ),
      backgroundColor: Colors.white, // Keep dialog clean with white background
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with consistent style
            const Text(
              "Set Timer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, // Use deep purple for text consistency
              ),
            ),
            const SizedBox(height: 20),
            // Input fields in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeInputField(
                  controller: _hoursController,
                  label: "Hours",
                ),
                _buildTimeInputField(
                  controller: _minutesController,
                  label: "Minutes",
                ),
                _buildTimeInputField(
                  controller: _secondsController,
                  label: "Seconds",
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Set Timer & Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded to match other button styles
                    ),
                  ),
                  onPressed: () {
                    int hours = int.parse(_hoursController.text);
                    int minutes = int.parse(_minutesController.text);
                    int seconds = int.parse(_secondsController.text);

                    final totalDuration = Duration(
                        hours: hours, minutes: minutes, seconds: seconds);

                    Navigator.of(context).pop(totalDuration);
                  },
                  child: const Text(
                    "Set Timer",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build time input fields without icons
  Widget _buildTimeInputField({
    required TextEditingController controller,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.deepPurple),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.deepPurpleAccent.withOpacity(0.06), // Light fill to keep focus on text
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ),
      ],
    );
  }
}
