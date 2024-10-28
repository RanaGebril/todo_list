import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/home_screen.dart';
import 'package:todo_list/providers/My_provider.dart';
import 'AppColors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      var providerObject = Provider.of<MyProvider>(context, listen: false);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<MyProvider>(
      builder: (context, provider_object, child) {
        return Container(
          color: provider_object.AppTheme==ThemeMode.light?
          Appcolors.primary_light
              :Appcolors.primary_dark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/logo.png",
                  height: MediaQuery.of(context).size.height * 0.715),
              Image.asset(
                "assets/images/routeBlue.png",
              )
            ],
          ),
        );
      },
    );
  }
}
