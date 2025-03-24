import 'package:flutter/material.dart';

class RadioButtonWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T> onChanged;

  const RadioButtonWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            fillColor: WidgetStateProperty.all(Colors.blueAccent),
            onChanged: (newValue) => onChanged(newValue!),
            activeColor: Colors.blueAccent,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: groupValue == value ? Colors.blueAccent : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
