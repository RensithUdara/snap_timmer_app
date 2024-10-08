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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Set Timer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
