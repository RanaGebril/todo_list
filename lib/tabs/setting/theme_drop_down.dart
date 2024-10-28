import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/AppColors.dart';
import 'package:todo_list/providers/My_provider.dart';


class ThemeDropDown extends StatelessWidget {
  const ThemeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    var provider_object = Provider.of<MyProvider>(context);
    ThemeMode currentTheme = Provider.of<MyProvider>(context).AppTheme;//access theme from the provider
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: provider_object.AppTheme==ThemeMode.light
        ?Appcolors.whiteColor
        :Appcolors.primary_dark,
        border: Border.all(color: Appcolors.blueColor, width: 2),
      ),
      child: DropdownButton<ThemeMode>(
        value: currentTheme,//set the curent theme value
        items: [
          DropdownMenuItem(
            child: Text(
              'light'.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Appcolors.blueColor
              )),
            value: ThemeMode.light,
          ),
          DropdownMenuItem(
            child: Text(
              'dark'.tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Appcolors.blueColor
                )
            ),
            value: ThemeMode.dark,
          )
        ],
        //change theme mode
        onChanged: (modeToChange) {
          provider_object.changeTheme(modeToChange!);
        },
        iconSize: 20,
        iconEnabledColor: Appcolors.blueColor,
         icon: Icon(Icons.keyboard_arrow_down),
        borderRadius: BorderRadius.circular(25),
        hint: Text(
            provider_object.AppTheme == ThemeMode.light ? 'light'.tr() : 'dark'.tr()),
        style: Theme.of(context).textTheme.labelLarge,
        dropdownColor: provider_object.AppTheme==ThemeMode.light
        ? Appcolors.whiteColor
        :Appcolors.secondary_dark,
        underline: SizedBox.shrink(),
        isExpanded: true,
      ),
    );
  }
}
