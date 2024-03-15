import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumPicker extends StatelessWidget {
  final String titleType;
  final String type;
  final int value;
  final Function(int) onChanged;

  const CustomNumPicker({
    super.key,
    required this.titleType,
    required this.type,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titleType,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            type,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          NumberPicker(
            minValue: 0,
            maxValue: 200,
            step: 1,
            value: value,
            onChanged: (int newValue) => onChanged(newValue),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.green[400]!,
                width: 1,
              ),
            ),
            itemWidth: 60,
          ),
        ],
      ),
    );
  }
}
