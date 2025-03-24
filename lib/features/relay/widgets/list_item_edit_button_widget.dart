import 'package:farahoush/core/config/assets/colors.dart';
import 'package:farahoush/core/styles/app_theme.dart';
import 'package:farahoush/features/relay/model/relay.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';

class ListItemEditButtonWidget extends StatelessWidget {
  final RelayMode? relayMode;
  final Function(String) onActionSelected;

  const ListItemEditButtonWidget({
    super.key,
    required this.relayMode,
    required this.onActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final timerValue =
        relayMode is TimerRelayMode
            ? (relayMode as TimerRelayMode).timerType.timerValue?.round()
            : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (relayMode != null) ...[
          Row(
            children: [
              Icon(
                relayMode is OnOffRelayMode
                    ? Icons.power_settings_new_rounded
                    : Icons.timer,
                size: 15,
                color: Colors.grey[400],
              ),
              const Gap(4),
              Text(
                relayMode is OnOffRelayMode
                    ? 'روشن / خاموش'
                    : 'لحظه ای ${timerValue ?? ''} ثانیه',
                style: AppTextTheme.labelMedium.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          const Gap(6),
        ],
        PopupMenuButton<String>(
          onSelected: onActionSelected,
          color: Colors.white,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(7),
          constraints: BoxConstraints(
            maxWidth: 140, // Constrain total menu width
          ),
          elevation: 4,
          itemBuilder:
              (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_document, color: AppColors.primaryColor),
                      Gap(6),
                      Text(
                        'ویرایش',
                        style: AppTextTheme.labelMedium.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'quickAccess',
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      Gap(6),
                      Text(
                        'دسترسی سریع',
                        style: AppTextTheme.labelMedium.copyWith(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: HexColor('#FF2B2B'),
                      ),
                      Gap(6),
                      Text(
                        'حذف',
                        style: AppTextTheme.labelMedium.copyWith(
                          color: HexColor('#FF2B2B'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          child: Icon(Icons.more_vert, size: 16, color: HexColor('#8A8E92')),
        ),
        const Gap(4),
      ],
    );
  }
}
