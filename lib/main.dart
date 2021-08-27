import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/agreement.dart';
import 'package:huofu/game/home.dart';
import 'package:huofu/innovation.dart';
import 'package:huofu/login/register.dart';
import 'package:huofu/mine/setting.dart';
import 'package:huofu/mine/share.dart';
import 'package:huofu/notification.dart';
import 'package:huofu/state/user.dart';
import 'package:huofu/tabControl.dart';
import 'package:huofu/login/login.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: StyledToast(
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: RefreshConfiguration(
            child: MaterialApp(
              localizationsDelegates: [
                RefreshLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [Locale('zh', 'CN')],
              navigatorKey: navigatorKey,
              title: 'HuoFu',
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  shadowColor: Color(0x21C7C3D0),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  textTheme: TextTheme(
                    headline6: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              // initialRoute: Platform.isIOS ? '/game' : '/',
              routes: {
                '/game': (BuildContext context) {
                  return HomePage();
                },
                '/': (BuildContext context) {
                  return TabControl();
                },
                '/login': (BuildContext context) {
                  return Login();
                },
                '/register': (BuildContext context) {
                  return Register();
                },
                '/agreement': (BuildContext context) {
                  return Agreement();
                },
                '/setting': (BuildContext context) {
                  return Setting();
                },
                '/notice': (BuildContext context) {
                  return Notice();
                },
                '/innovation': (BuildContext context) {
                  return Innovation();
                },
                '/share': (BuildContext context) {
                  return Share();
                }
              },
            ),
          ),
        ),
        locale: Locale('zh', 'CN'),
        toastAnimation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.fade,
        textStyle: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        backgroundColor: Color(0xFF5F6173),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
