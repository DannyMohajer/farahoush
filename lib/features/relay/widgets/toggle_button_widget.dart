import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ToggleButtonWidget extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  const ToggleButtonWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        inactiveTrackColor: HexColor('#8A8E92'),
        value: value,
        onChanged: onChanged,
        activeTrackColor: Colors.grey[200],
        activeColor: Colors.grey[200],
        inactiveThumbColor: Colors.white,
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        thumbColor: WidgetStateProperty.all(Colors.white),
      ),
    );
  }
}
