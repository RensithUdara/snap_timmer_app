import 'package:flutter/material.dart';

Widget buildTimeInputField(
    {required TextEditingController controller, required String label}) {
  return Column(
    children: [
      Text(label),
      SizedBox(
        width: 60,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.all(8),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
