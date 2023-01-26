// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';

// class AppTheme {
//   static Color lightBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
//   static Color lightPrimaryColor = const Color.fromARGB(255, 119, 192, 79);
//   static Color lightSecondaryColor = const Color.fromARGB(255, 119, 192, 79);
//   static Color lightAccentColor = Colors.blueGrey.shade200;
//   static Color lightParticlesColor = const Color(0x44948282);
//   static Color lightTextColor = Colors.black54;

//   const AppTheme._();

//   static final lightTheme = ThemeData(
//       brightness: Brightness.light,
//       primaryColor: lightPrimaryColor,
//       backgroundColor: lightBackgroundColor,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       appBarTheme: AppBarTheme(backgroundColor: lightPrimaryColor),
//       colorScheme: ColorScheme.light(secondary: lightSecondaryColor),
//       textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(primary: lightBackgroundColor)));

//   static Brightness get currentSystemBrightness =>
//       SchedulerBinding.instance.window.platformBrightness;

//   static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//       systemNavigationBarIconBrightness: Brightness.light,
//       systemNavigationBarColor: lightBackgroundColor,
//       systemNavigationBarDividerColor: Colors.transparent,
//     ));
//   }
// }
