import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/AppColors.dart';
import 'package:todo_list/firebase_functions.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/providers/My_provider.dart';
import 'package:todo_list/tabs/tasks/edit_tab.dart';

class TaskItem extends StatefulWidget {
  TaskModel task;

  TaskItem({required this.task, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var provider_object = Provider.of<MyProvider>(context);
    return Container(
      //padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: provider_object.AppTheme == ThemeMode.light
            ? Appcolors.whiteColor
            : Appcolors.secondary_dark,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(widget.task.id);
              setState(() {});
            },
            backgroundColor: Appcolors.redColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "delete".tr(),
            borderRadius: context.locale==Locale("en")
          ?BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10))
            :BorderRadius.only(
                bottomLeft: Radius.circular(0),
                topLeft: Radius.circular(0)),
            padding: EdgeInsets.zero,
            autoClose: true,
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditTab.routeName,arguments: widget.task);
            },
            backgroundColor: Appcolors.blueColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "edit".tr(),
            borderRadius: context.locale==Locale("ar")
                ?BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))
                :BorderRadius.only(
                bottomRight: Radius.circular(0),
                topRight: Radius.circular(0)),
            autoClose: true,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.task.isDone==true
                    ?Appcolors.greenColor
                      : Appcolors.blueColor,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: widget.task.isDone == true
                                ? Appcolors.greenColor
                                : Appcolors.blueColor,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.task.subTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              widget.task.isDone
                  ? Text(
                      "done".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Appcolors.greenColor),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        widget.task.isDone = true;
                        FirebaseFunctions.editTask(widget.task);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.task.isDone
                            ? Appcolors.greenColor
                            : Appcolors.blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Icon(
                        Icons.done,
                        color: Appcolors.whiteColor,
                        size: 25,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
