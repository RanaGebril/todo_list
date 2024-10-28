import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/AppColors.dart';
import 'package:todo_list/providers/My_provider.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    var provider_object = Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: provider_object.AppTheme == ThemeMode.light
            ? Appcolors.whiteColor
            : Appcolors.secondary_dark,
        border: Border.all(color: Appcolors.blueColor, width: 2),
      ),
      child: DropdownButton<Locale>(
        value: context.locale,
          items: [
            DropdownMenuItem(
              child: Text('english'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Appcolors.blueColor)),
              value: Locale("en"),
            ),
            DropdownMenuItem(
              child: Text('arabic'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Appcolors.blueColor)),
              value: Locale("ar"),
            ),
          ],
          onChanged: (locale) {
            context.setLocale(locale!); // Set the locale based on selection from items
          },
          iconSize: 25,
          iconEnabledColor: Appcolors.blueColor,
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: provider_object.AppTheme == ThemeMode.light
              ? Appcolors.whiteColor
              : Appcolors.secondary_dark,
          borderRadius: BorderRadius.circular(20),
          hint: Text( context.locale == Locale("en")
              ?'english'.tr()
              :'arabic'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Appcolors.blueColor)),
          underline: SizedBox.shrink(),
          isExpanded: true),
    );
  }
}
