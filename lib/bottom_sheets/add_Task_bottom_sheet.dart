
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/AppColors.dart';
import 'package:todo_list/firebase_functions.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/providers/My_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  static const String routeName = "add";

  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var subTitleController = TextEditingController();

  Widget build(BuildContext context) {
    //instead of call provider two times in & out build use consumer to access provider
    return Consumer<MyProvider>(
      builder: (context, provider_object, child) {
        return Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: provider_object.AppTheme == ThemeMode.light
                ? Appcolors.whiteColor
                : Appcolors.secondary_dark,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(35), topLeft: Radius.circular(35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'addNewTask'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  label: Text(
                    "enterNewTask".tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Appcolors.grayColor1,
                        ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Appcolors.blueColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Appcolors.blueColor, width: 2),
                  ),
                ),
                cursorColor: Appcolors.grayColor1,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: subTitleController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  label: Text(
                    "description".tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Appcolors.grayColor1,
                        ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Appcolors.blueColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Appcolors.blueColor, width: 2),
                  ),
                ),
                cursorColor: Appcolors.grayColor1,
              ),
              SizedBox(height: 20),
              Text(
                'selectTime'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  selectDateFun(provider_object);
                },
                child: Text(
                  selectedDate.toString().substring(0, 10),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Appcolors.grayColor1),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 120,
                child: ElevatedButton(
                    onPressed: () {
                      TaskModel task = TaskModel(
                          title: titleController.text,
                          subTitle: subTitleController.text,
                          // when adding the task start the time from the start of the day
                          date: DateUtils.dateOnly(selectedDate)
                              .millisecondsSinceEpoch);
                      if (task.title != "") {
                        FirebaseFunctions.addTask(task).then;
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        textStyle: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Appcolors.whiteColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        backgroundColor: Appcolors.blueColor),
                    child: Text(
                      "add".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Appcolors.whiteColor),
                    )),
              ),
              SizedBox(height: 30)
            ],
          ),
        );
      },
    );
  }

  //parameters came from consumer
  selectDateFun(MyProvider provider_object) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: selectedDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: provider_object.AppTheme == ThemeMode.dark
                ? ColorScheme.dark(
                    primary: Appcolors.blueColor,
                    onPrimary: Appcolors.whiteColor,
                    surface: Appcolors.secondary_dark,
                    onSurface: Appcolors.whiteColor,
                  )
                : ColorScheme.light(
                    primary: Appcolors.blueColor,
                    onPrimary: Appcolors.whiteColor,
                    surface: Appcolors.whiteColor,
                    onSurface: Appcolors.blackFontColor,
                  ),
            dialogBackgroundColor: provider_object.AppTheme == ThemeMode.dark
                ? Appcolors.secondary_dark
                : Appcolors.whiteColor,
          ),
          child: child!,
        );
      },
    );

    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
