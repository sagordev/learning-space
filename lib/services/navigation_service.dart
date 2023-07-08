import 'package:flutter/cupertino.dart';

class NavigationService{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  navigateTo(String routeName, bool? removeUntil) async {
    if(removeUntil != null && removeUntil != false){
         return await navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (route) => false);
    }
     return await navigatorKey.currentState?.pushNamed(routeName);
  }
}