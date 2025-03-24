import 'package:farahoush/common/widgets/buttons/custom_button_widget.dart';
import 'package:farahoush/common/widgets/scaffold/custom_scaffold_widget.dart';
import 'package:farahoush/common/widgets/textfield/custom_textfield.dart';
import 'package:farahoush/features/relay/model/relay.dart';
import 'package:farahoush/features/relay/views/saved_relay_screen.dart';
import 'package:farahoush/features/relay/views/single_channel_screen.dart';
import 'package:farahoush/features/relay/views/two_channel_screen.dart';
import 'package:farahoush/features/relay/widgets/adding_relay_widget.dart';
import 'package:farahoush/features/relay/widgets/bottom_sheet_widget.dart';
import 'package:farahoush/features/relay/widgets/relay_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RelayScreen extends StatefulWidget {
  final RelayModel? relayModel;
  const RelayScreen({super.key, this.relayModel});

  @override
  State<RelayScreen> createState() => _RelayScreenState();
}

class _RelayScreenState extends State<RelayScreen> {
  final TextEditingController relayNameController = TextEditingController();
  final TextEditingController relaySerialController = TextEditingController();
  static final List<RelayModel> relayList = [];

  @override
  void initState() {
    super.initState();
    relayNameController.text = 'تست';
    relaySerialController.text = 'تست';
    if (widget.relayModel != null) {
      _updateOrAddRelay(widget.relayModel!);
    }
  }

  void _updateOrAddRelay(RelayModel newRelay) {
    final index = relayList.indexWhere((relay) => relay.id == newRelay.id);
    if (index != -1) {
      setState(() {
        relayList[index] = newRelay;
      });
    } else {
      setState(() {
        relayList.add(newRelay);
      });
    }
  }

  void _openBottomSheet() {
    if (relayNameController.text.isNotEmpty &&
        relaySerialController.text.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder:
            (context) => BottomSheetWidget(
              deviceName: relayNameController.text,
              relaySerial: relaySerialController.text,
            ),
      ).then((newRelay) {
        if (newRelay != null) {
          setState(() {
            _updateOrAddRelay(newRelay as RelayModel);
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('نام و سریال دستگاه را وارد کنید')),
      );
    }
  }

  void _editRelay(int index) {
    final relay = relayList[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (relay.relayType is SingleChannelRelay) {
            return SingleChannelScreen(relayModel: relay);
          }
          return TwoChannelScreen(relayModel: relay);
        },
      ),
    ).then((updatedRelay) {
      if (updatedRelay != null) {
        setState(() {
          relayList[index] = updatedRelay;
        });
      }
    });
  }

  void _deleteRelay(int index) {
    setState(() => relayList.removeAt(index));
  }

  void _toggleQuickAccess(int index) {
    setState(() {
      final updatedRelay = relayList[index].copyWith(
        quickAccess: !(relayList[index].quickAccess ?? false),
      );
      relayList[index] = updatedRelay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      backButton: false,
      title: 'افزودن 8رله',
      child: Column(
        children: [
          Gap(10),
          Image.asset('assets/images/mobadel.jpg', width: 140),
          Gap(10),
          CustomTextfield(
            title: 'نام رله',
            hintText: 'نام دستگاه را وارد کنید',
            controller: relayNameController,
            keyboardType: TextInputType.text,
            onChanged: (p) {},
          ),
          Gap(16),
          CustomTextfield(
            title: 'سریال رله',
            hintText: 'سریال دستگاه را وارد کنید',
            controller: relaySerialController,
            keyboardType: TextInputType.number,
            onChanged: (p) {},
          ),
          Gap(16),
          AddingRelayWidget(onPressed: _openBottomSheet),
          Gap(24),
          Expanded(
            child: RelayListWidget(
              key: UniqueKey(),
              relayList: relayList,
              onEdit: _editRelay,
              onDelete: _deleteRelay,
              onToggleQuickAccess: _toggleQuickAccess,
            ),
          ),
          Gap(10),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomButtonWidget(
              isEnable: relayList.isNotEmpty,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavedRelayScreen(relays: relayList),
                  ),
                );
              },
              title: 'ثبت',
            ),
          ),
        ],
      ),
    );
  }
}
