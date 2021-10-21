import 'package:ekuabo/binding/forgot_password_binding.dart';
import 'package:ekuabo/binding/home_binding.dart';
import 'package:ekuabo/binding/otp_verification_binding.dart';
import 'package:ekuabo/binding/payment_binding.dart';
import 'package:ekuabo/pages/forgot_password.dart';
import 'package:ekuabo/pages/home_page.dart';
import 'package:ekuabo/binding/sign_in_binding.dart';
import 'package:ekuabo/pages/otp_verification.dart';
import 'package:ekuabo/pages/payment_webview.dart';
import 'package:ekuabo/pages/splash.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import 'binding/sign_up_binding.dart';
import 'pages/sign_in.dart';
import 'pages/sign_up.dart';
import 'utils/log.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initLog();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(EkuaboApp());
  });
}

void _initLog() {
  Log.init();
  Log.setLevel(Level.ALL);
}

class EkuaboApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: EkuaboString.appName,
      initialRoute: EkuaboRoute.rootName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: EkuaboAsset.CERA_PRO_FONT,
        brightness: Brightness.light,
        primaryColor: MyColor.mainColor,
        primaryColorDark: MyColor.mainColor,
        primaryColorLight: MyColor.mainColor,
        colorScheme: const ColorScheme.light(secondary: MyColor.accentColor),
        dividerColor: MyColor.accentColor,
        focusColor: MyColor.accentColor,
        hintColor: MyColor.secondColor,
        unselectedWidgetColor: MyColor.lightBlueColor,
        textTheme: const TextTheme(
          headline5: TextStyle(fontSize: 20.0, color: MyColor.secondColor),
          headline4: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: MyColor.secondColor),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: MyColor.secondColor),
          headline2: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: MyColor.secondColor),
          headline1: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w200,
              color: MyColor.secondColor),
          subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: MyColor.secondColor),
          headline6: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: MyColor.mainColor),
          bodyText2: TextStyle(fontSize: 12.0, color: MyColor.secondColor),
          bodyText1: TextStyle(fontSize: 14.0, color: MyColor.secondColor),
          caption: TextStyle(fontSize: 12.0, color: MyColor.accentColor),
        ),
      ),
     getPages: [
       GetPage(name: EkuaboRoute.rootName,page: ()=>SplashScreen()),
       GetPage(name: EkuaboRoute.signInScreen,page: ()=>SignInScreen(),binding: SignInBinding()),
       GetPage(name: EkuaboRoute.forgotPasswordScreen,page: ()=>ForgotPassword(),binding: ForgotPasswordBinding()),
       GetPage(name: EkuaboRoute.signUpScreen,page: ()=>SignUpScreen(),binding: SignUpBinding()),
       GetPage(name: EkuaboRoute.otpVerificationScreen,page: ()=>OtpVerification(),binding: OtpVerificationBinding()),
       GetPage(name: EkuaboRoute.homeScreen,page: ()=>HomePage(),binding: HomeBinding()),
       GetPage(name: EkuaboRoute.payment_web_view,page: ()=>PaymentWebView(),binding: PaymentBinding()),
     ],
     /* onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (context) => makeRoute(
                context: context,
                routeName: settings.name,
                argument: settings.arguments),
            maintainState: true);
      },*/
    );
  }

  Widget makeRoute({BuildContext context, String routeName, Object argument}) {
    switch (routeName) {
       case EkuaboRoute.rootName:
        return  SplashScreen();
      case EkuaboRoute.signInScreen:
        return SignInScreen();
      case EkuaboRoute.signUpScreen:
        return SignUpScreen();
      case EkuaboRoute.homeScreen:
        return  HomePage();
     default:
        return const Text("Loading...");
    }
  }
}
