import 'package:farahoush/core/styles/app_theme.dart';
import 'package:farahoush/features/relay/model/relay.dart';
import 'package:farahoush/features/relay/widgets/empty_state_widget.dart';
import 'package:farahoush/features/relay/widgets/list_item_edit_button_widget.dart';
import 'package:farahoush/features/relay/widgets/switch_button_widget.dart';
import 'package:farahoush/features/relay/widgets/toggle_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';

class RelayListWidget extends StatefulWidget {
  final List<RelayModel> relayList;
  final bool editMode;
  final Function(int)? onEdit;
  final Function(int)? onDelete;
  final Function(int)? onToggleQuickAccess;

  const RelayListWidget({
    super.key,
    required this.relayList,
    this.editMode = true,
    this.onEdit,
    this.onDelete,
    this.onToggleQuickAccess,
  });

  @override
  State<RelayListWidget> createState() => _RelayListWidgetState();
}

class _RelayListWidgetState extends State<RelayListWidget> {
  Map<int, bool> _switchStates = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.relayList.length; i++) {
      _switchStates[i] = false;
    }
  }

  @override
  void didUpdateWidget(covariant RelayListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.relayList.length != widget.relayList.length) {
      for (int i = 0; i < widget.relayList.length; i++) {
        _switchStates.putIfAbsent(i, () => false);
      }
    }
  }

  void _toggleSwitchForIndex(int index, bool value) {
    setState(() {
      _switchStates[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return widget.relayList.isEmpty
        ? EmptyStateWidget()
        : ListView.builder(
          key: UniqueKey(),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.relayList.length,
          itemBuilder: (context, index) {
            var relay = widget.relayList[index];
            RelayType? relayType = relay.relayType;
            int? relay1Number;
            int? relay2Number;
            RelayMode? relayMode;

            if (relayType is SingleChannelRelay) {
              relayMode = relayType.relayMode;
              relay1Number = relayType.relayNumber;
            } else if (relayType is TwoChannelRelay) {
              relay1Number = relayType.firstRelayNumber;
              relay2Number = relayType.secondRelayNumber;
              relayMode = null;
            }

            return Container(
              height: 79,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [HexColor('#FCFCFC'), HexColor('#F7F7F7')],
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 57,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: HexColor('#E9E9E9'),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            relay.icon,

                            size: 30,
                            color: HexColor('#8A8E92'),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: relay.deviceName ?? '',
                                          ),
                                          WidgetSpan(
                                            child:
                                                relay.quickAccess == true
                                                    ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            bottom: 2,
                                                            right: 2,
                                                          ),
                                                      child: Icon(
                                                        Icons.bolt,
                                                        color: Colors.orange,
                                                        size: 16,
                                                      ),
                                                    )
                                                    : SizedBox.shrink(),
                                          ),
                                        ],
                                      ),

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextTheme.labelLarge.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                        fontSize:
                                            13 *
                                            MediaQuery.textScaleFactorOf(
                                              context,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              widget.editMode
                                  ? Row(
                                    children: [
                                      Text(
                                        'رله شماره $relay1Number',
                                        style: AppTextTheme.labelMedium
                                            .copyWith(
                                              fontSize:
                                                  12 * (screenWidth / 400),
                                              color: Colors.grey[500],
                                            ),
                                      ),
                                      if (relay2Number != null)
                                        Padding(
                                          padding: EdgeInsets.only(right: 2),
                                          child: Text(
                                            '| رله شماره $relay2Number',
                                            style: AppTextTheme.labelMedium
                                                .copyWith(
                                                  fontSize:
                                                      12 * (screenWidth / 400),
                                                  color: Colors.grey[500],
                                                ),
                                          ),
                                        ),
                                    ],
                                  )
                                  : Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            relayMode is OnOffRelayMode
                                                ? Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timer,
                                                      size: 18,
                                                      color: HexColor(
                                                        '#8A8E92',
                                                      ),
                                                    ),
                                                    Gap(2),
                                                    Text(
                                                      '4 ثانیه ',
                                                      style: AppTextTheme
                                                          .labelMedium
                                                          .copyWith(
                                                            fontSize:
                                                                13 *
                                                                (screenWidth /
                                                                    400),
                                                            color: HexColor(
                                                              '#8A8E92',
                                                            ),
                                                          ),
                                                    ),
                                                  ],
                                                )
                                                : Icon(
                                                  Icons.power_settings_new,
                                                  size: 16,
                                                  color: HexColor('#8A8E92'),
                                                ),
                                          ],
                                        ),
                                        Gap(4),
                                        Text(
                                          'رله شماره $relay1Number',
                                          style: AppTextTheme.labelMedium
                                              .copyWith(
                                                fontSize:
                                                    13 * (screenWidth / 400),
                                                color: HexColor('#8A8E92'),
                                              ),
                                        ),
                                        if (relay2Number != null)
                                          Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              '| رله شماره $relay2Number',
                                              style: AppTextTheme.labelMedium
                                                  .copyWith(
                                                    fontSize:
                                                        13 *
                                                        (screenWidth / 400),
                                                    color: HexColor('#8A8E92'),
                                                  ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  !widget.editMode
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          relayMode is OnOffRelayMode
                              ? SwitchButtonWidget(onPressed: () {})
                              : ToggleButtonWidget(
                                value: _switchStates[index] ?? false,
                                onChanged:
                                    (bool value) =>
                                        _toggleSwitchForIndex(index, value),
                              ),
                        ],
                      )
                      : ListItemEditButtonWidget(
                        relayMode: relayMode,
                        onActionSelected: (action) {
                          if (action == 'edit') {
                            widget.onEdit!(index);
                          } else if (action == 'delete') {
                            widget.onDelete!(index);
                          } else if (action == 'quickAccess') {
                            widget.onToggleQuickAccess!(index);
                          }
                        },
                      ),
                ],
              ),
            );
          },
        );
  }
}
