import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/tabs/setting/language_drop_down.dart';
import 'package:todo_list/tabs/setting/theme_drop_down.dart';

class SettingTab extends StatelessWidget {
  SettingTab({super.key});

  String dropDownBottomValue = "lang";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('language'.tr(), style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 10),
          LanguageDropDown(),
          SizedBox(height: 40),
          Text('mode'.tr(), style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 10),
          ThemeDropDown()
        ],
      ),
    );
  }
}
