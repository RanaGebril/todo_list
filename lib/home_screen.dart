import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/bottom_sheets/add_Task_bottom_sheet.dart';
import 'package:todo_list/providers/My_provider.dart';
import 'package:todo_list/tabs/setting/setting_tab.dart';
import 'package:todo_list/tabs/tasks/tasks_tab.dart';
import 'AppColors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider_object=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
        selectedIndex==1
            ?'setting'.tr()
            :"${'appBarTitle'.tr()} ",
                ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30)
        ),
        child: BottomAppBar(
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "my list"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "setting")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           showModalBottomSheet(context: context,
             // to allow it to space bigger than defult
             backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) {
                return Padding(
                  //increase padding equal to the size add from the bottom
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskBottomSheet(),
                );
              },);
        },
        child: Icon(Icons.add, color: Appcolors.whiteColor, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      extendBody: true,
      //allow the body to be appear under the bottom navigation bar
      body:  taps[selectedIndex],
    );
  }

  List<Widget> taps = [TasksTab(), SettingTab()];
}
