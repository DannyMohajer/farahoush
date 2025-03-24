import 'package:farahoush/common/widgets/buttons/custom_normal_button.dart';
import 'package:farahoush/core/styles/app_theme.dart';
import 'package:farahoush/features/relay/model/relay.dart';
import 'package:farahoush/features/relay/views/single_channel_screen.dart';
import 'package:farahoush/features/relay/views/two_channel_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class BottomSheetWidget extends StatefulWidget {
  final String deviceName;
  final String relaySerial;

  const BottomSheetWidget({
    super.key,
    required this.deviceName,
    required this.relaySerial,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  IconData? selectedIcon;
  String? selectedRelayType = 'single';
  final List<IconData> icons = [
    Icons.laptop,
    Icons.light,
    Icons.gas_meter,
    Icons.heat_pump,
    Icons.garage,
    Icons.device_thermostat_outlined,
    Icons.devices_other,
  ];

  void _onSave() async {
    if (selectedIcon != null && selectedRelayType != null) {
      RelayModel? newRelay;
      if (selectedRelayType == 'single') {
        newRelay = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              var uuid = Uuid();
              return SingleChannelScreen(
                relayModel: RelayModel(
                  id: uuid.v4(),
                  deviceName: widget.deviceName,
                  serialNumber: widget.relaySerial,
                  icon: selectedIcon,
                  quickAccess: false,
                ),
              );
            },
          ),
        );
      } else {
        newRelay = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              var uuid = Uuid();
              return TwoChannelScreen(
                relayModel: RelayModel(
                  id: uuid.v4(),
                  deviceName: widget.deviceName,
                  serialNumber: widget.relaySerial,
                  icon: selectedIcon,
                  quickAccess: false,
                ),
              );
            },
          ),
        );
      }
      if (newRelay != null) {
        Navigator.pop(context, newRelay);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(24),
            Container(width: 30, height: 2, color: Colors.grey[300]),
            Gap(24),
            Text(
              'انتخاب تصویر',
              style: AppTextTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(24),
            Container(
              height: 58,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: ToggleButtons(
                  isSelected: [
                    selectedRelayType == 'single',
                    selectedRelayType == 'two',
                  ],
                  borderColor: Colors.transparent,
                  disabledBorderColor: Colors.transparent,
                  selectedBorderColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  onPressed: (index) {
                    setState(() {
                      selectedRelayType = index == 0 ? 'single' : 'two';
                    });
                  },
                  children: [
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 2,
                            offset: Offset(0, 0),
                          ),
                        ],
                        color:
                            selectedRelayType == 'single'
                                ? Colors.blueAccent
                                : Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.control_point,
                              color:
                                  selectedRelayType == 'single'
                                      ? Colors.white
                                      : Colors.amber,
                            ),
                            Gap(6),
                            Text(
                              'تک کاناله',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color:
                                    selectedRelayType == 'single'
                                        ? Colors.white
                                        : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 2,
                            offset: Offset(0, 0),
                          ),
                        ],
                        color:
                            selectedRelayType == 'two'
                                ? Colors.blueAccent
                                : Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.control_point_duplicate_sharp,
                              color:
                                  selectedRelayType == 'two'
                                      ? Colors.white
                                      : Colors.amber,
                            ),
                            Gap(6),
                            Text(
                              'دو کاناله',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color:
                                    selectedRelayType == 'two'
                                        ? Colors.white
                                        : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(16),
            GridView.builder(
              shrinkWrap: true,
              itemCount: icons.length,
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisExtent: 70,
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
              ),
              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icons[index];
                      });
                    },
                    child: Container(
                      height: 56,
                      width: 56,
                      margin: EdgeInsets.only(left: 6),
                      decoration: BoxDecoration(
                        color: HexColor('#586474'),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          icons[index],
                          size: 27,
                          color:
                              selectedIcon == icons[index]
                                  ? Colors.blue
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ),
            ),
            Gap(16),
            CustomNormalButton(
              onPressed: () {
                (selectedIcon != null && selectedRelayType != null)
                    ? _onSave()
                    : null;
              },
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),

                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(child: Text('ادامه')),
              ),
            ),
            Gap(16),
          ],
        ),
      ),
    );
  }
}
