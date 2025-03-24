import 'package:farahoush/common/widgets/buttons/custom_button_widget.dart';
import 'package:farahoush/common/widgets/scaffold/custom_scaffold_widget.dart';
import 'package:farahoush/common/widgets/textfield/custom_textfield.dart';
import 'package:farahoush/features/relay/model/relay.dart';
import 'package:farahoush/features/relay/widgets/header_widget.dart';
import 'package:farahoush/features/relay/widgets/number_picker_drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TwoChannelScreen extends StatefulWidget {
  final RelayModel relayModel;

  const TwoChannelScreen({super.key, required this.relayModel});

  @override
  State<TwoChannelScreen> createState() => _TwoChannelScreenState();
}

class _TwoChannelScreenState extends State<TwoChannelScreen> {
  final TextEditingController _relayNameController = TextEditingController();
  ValueNotifier<int> selectedRelayNumber1 = ValueNotifier(1);
  ValueNotifier<int> selectedRelayNumber2 = ValueNotifier(1);

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
            selectedNumber: selectedRelayNumber1,
            title: 'شماره رله1',
          ),
          Gap(20),
          NumberPickerDropDownWidget(
            selectedNumber: selectedRelayNumber2,
            title: 'شماره رله 2',
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
                relayType: TwoChannelRelay(
                  relayName: _relayNameController.text,
                  firstRelayNumber: selectedRelayNumber1.value,
                  secondRelayNumber: selectedRelayNumber2.value,
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
