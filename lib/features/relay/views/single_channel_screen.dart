import 'package:farahoush/common/title_widget.dart';
import 'package:farahoush/common/widgets/buttons/custom_button_widget.dart';
import 'package:farahoush/common/widgets/scaffold/custom_scaffold_widget.dart';
import 'package:farahoush/common/widgets/textfield/custom_textfield.dart';
import 'package:farahoush/features/relay/model/relay.dart';
import 'package:farahoush/features/relay/widgets/header_widget.dart';
import 'package:farahoush/features/relay/widgets/number_picker_drop_down_widget.dart';
import 'package:farahoush/features/relay/widgets/radio_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SingleChannelScreen extends StatefulWidget {
  final RelayModel relayModel;

  const SingleChannelScreen({super.key, required this.relayModel});

  @override
  State<SingleChannelScreen> createState() => _SingleChannelScreenState();
}

class _SingleChannelScreenState extends State<SingleChannelScreen> {
  final TextEditingController _relayNameController = TextEditingController();
  ValueNotifier<int> selectedRelayNumber = ValueNotifier(1);
  RelayMode _relayMode = const OnOffRelayMode();
  double? _selectedTimerValue = 5.0;

  @override
  void initState() {
    super.initState();
    if (widget.relayModel.relayType is SingleChannelRelay) {
      _relayNameController.text =
          (widget.relayModel.relayType as SingleChannelRelay).relayName ?? '';
      selectedRelayNumber.value =
          (widget.relayModel.relayType as SingleChannelRelay).relayNumber ?? 1;
      _relayMode =
          (widget.relayModel.relayType as SingleChannelRelay).relayMode ??
          const OnOffRelayMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      title: 'تنضیمات رله',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(
            name: widget.relayModel.deviceName!,
            icon: widget.relayModel.icon!,
          ),
          Gap(20),
          CustomTextfield(
            controller: _relayNameController,
            hintText: 'نام رله را وارد کنید',
            keyboardType: TextInputType.name,
            onChanged: (p0) {},
            title: 'نام رله',
          ),
          Gap(20),
          NumberPickerDropDownWidget(
            selectedNumber: selectedRelayNumber,
            title: 'شماره رله',
          ),
          Gap(20),
          titleWidget('نوع رله'),
          Gap(10),
          RadioButtonWidget(
            value: const OnOffRelayMode(),
            groupValue: _relayMode,
            label: 'روشن / خاموش',
            onChanged: (newMode) => setState(() => _relayMode = newMode),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RadioButtonWidget(
                value: TimerRelayMode(TimerType(_selectedTimerValue)),
                groupValue: _relayMode,
                label: 'لحظه‌ای',
                onChanged:
                    (newMode) => setState(() {
                      _relayMode = newMode;
                      _selectedTimerValue ??= 5.0;
                    }),
              ),
              if (_relayMode is TimerRelayMode) ...[
                const Gap(10),
                Container(
                  width: 160,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<double>(
                    alignment: Alignment.centerLeft,
                    isExpanded: true,
                    value:
                        (_relayMode as TimerRelayMode).timerType.timerValue ??
                        5.0,
                    hint: Text(
                      'شماره رله را وارد کنید',
                      style: TextTheme.of(
                        context,
                      ).bodyMedium!.copyWith(color: Colors.black38),
                    ),
                    items:
                        [5, 10, 15, 20].map((value) {
                          return DropdownMenuItem<double>(
                            value: value.toDouble(),
                            child: Text('$value ثانیه'),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _relayMode = TimerRelayMode(TimerType(value));
                        _selectedTimerValue = value;
                      });
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
              ],
            ],
          ),
          Spacer(),
          CustomButtonWidget(
            title: 'ثبت',
            onTap: () {
              final updatedRelay = RelayModel(
                id: widget.relayModel.id,
                deviceName: widget.relayModel.deviceName,
                serialNumber: widget.relayModel.serialNumber,
                icon: widget.relayModel.icon,
                relayType: SingleChannelRelay(
                  relayName: _relayNameController.text,
                  relayNumber: selectedRelayNumber.value,
                  relayMode: _relayMode,
                ),
              );
              Navigator.pop(context, updatedRelay);
            },
          ),
        ],
      ),
    );
  }
}
