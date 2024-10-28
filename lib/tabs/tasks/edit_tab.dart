import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/AppColors.dart';
import 'package:todo_list/firebase_functions.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/providers/My_provider.dart';

class EditTab extends StatefulWidget {
  static const String routeName="edit";
  EditTab({super.key});

  @override
  State<EditTab> createState() => _EditTabState();
}

class _EditTabState extends State<EditTab> {

  @override
  Widget build(BuildContext context) {
    var task=ModalRoute.of(context)?.settings.arguments as TaskModel;
    return Consumer<MyProvider>(
      builder: (context, provider_object, child) {
       return Scaffold(
          appBar: AppBar(
            title: Text("Edit".tr()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:  MediaQuery.of(context).size.height *0.8
                ),
                child: Card(

                  elevation: 50,
                  shadowColor: Appcolors.blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: provider_object.AppTheme==ThemeMode.light
                  ?Appcolors.whiteColor
                  :Appcolors.secondary_dark,
                  child:  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'editTask'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: task.title,
                          onChanged: (newTitle) {
                            task.title=newTitle;
                          },
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
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
                        SizedBox(height: 30),
                        TextFormField(
                          initialValue: task.subTitle,
                          onChanged: (newSubTitle) {
                            task.subTitle=newSubTitle;
                          },
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
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
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'selectTime'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                            onTap: () async{
                              DateTime? newDate=await selectDateFun(provider_object,task);
                              if(newDate != null){
                                task.date=newDate.millisecondsSinceEpoch;
                              }
                              setState(() {

                              });
                            },
                          child:  Text(
                            DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(task.date)),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: Appcolors.grayColor1),
                            textAlign: TextAlign.center,
                          ),

                        ),
                        SizedBox(height: 100),
                        ElevatedButton(
                            onPressed: (){
                              FirebaseFunctions.editTask(task);
                              Navigator.pop(context);
                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolors.blueColor,
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium,
                            ),
                            child: Text(
                              "saveChanges".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(color: Appcolors.whiteColor),
                            )),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  selectDateFun(MyProvider provider_object,TaskModel task) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.fromMillisecondsSinceEpoch(task.date),
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

    return chosenDate;
  }
}
