import 'package:farahoush/common/widgets/scaffold/custom_scaffold_widget.dart';
import 'package:farahoush/core/config/assets/app_images.dart';
import 'package:farahoush/core/styles/app_theme.dart';
import 'package:farahoush/features/relay/model/relay.dart';
import 'package:farahoush/features/relay/widgets/relay_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class SavedRelayScreen extends StatelessWidget {
  final List<RelayModel> relays;
  const SavedRelayScreen({super.key, required this.relays});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      title: '8رله کاربر',
      child: Column(
        children: [
          Gap(10),
          Row(
            children: [
              Image.asset('${AppImages.imageBasePath}mobadel.jpg', width: 88),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'سریال : ',
                        style: AppTextTheme.labelMedium.copyWith(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                      ),
                      Text('${relays.first.serialNumber?.toPersianDigit()}'),
                    ],
                  ),
                  Gap(4),
                  Text(
                    'رله های فعال : ${relays.length}',
                    style: AppTextTheme.labelMedium.copyWith(
                      fontSize: 13,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(20),
          Divider(color: HexColor('#F5F5F5'), height: 1),
          Gap(20),
          Expanded(child: RelayListWidget(relayList: relays, editMode: false)),
        ],
      ),
    );
  }
}
