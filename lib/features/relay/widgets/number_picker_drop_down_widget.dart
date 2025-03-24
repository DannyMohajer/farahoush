import 'package:farahoush/common/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NumberPickerDropDownWidget extends StatelessWidget {
  final ValueNotifier<int> selectedNumber;
  final String title;
  const NumberPickerDropDownWidget({
    super.key,
    required this.selectedNumber,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(title),
        Gap(10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ValueListenableBuilder(
            valueListenable: selectedNumber,
            builder:
                (context, value, child) => DropdownButtonFormField<int>(
                  value: selectedNumber.value,
                  hint: Text(
                    'شماره رله را وارد کنید',
                    style: TextTheme.of(
                      context,
                    ).bodyMedium!.copyWith(color: Colors.black38),
                  ),
                  items:
                      List.generate(10, (index) => index + 1)
                          .map(
                            (num) => DropdownMenuItem(
                              value: num,
                              child: Text('رله $num'),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    selectedNumber.value = value!;
                  },
                  iconEnabledColor: Colors.grey[400],
                  iconDisabledColor: Colors.grey[400],
                  dropdownColor: Colors.grey[100],
                  focusColor: Colors.grey[400],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
