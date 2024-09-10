import 'package:flutter/material.dart';

/*

SETTINGS LIST TILE

this is a simple tile for each item in the settings page.AboutDialog


to use this idget, you need:

-title ( e.g "Dark Mode")
-action ( e.g toggleTheme() )

*/

class MySettingsTile extends StatelessWidget {
  final String title;
  final Widget action;

  const MySettingsTile({
    super.key,
    required this.title,
    required this.action,
  });

  //build ui
  @override
  Widget build(BuildContext context) {
    //container
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),

      //Padding inside
      padding: const EdgeInsets.all(25),

      //padding outside
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),

      //padding insideRow
      child: Row(
        children: [
          //title
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),

          //action
          action,
        ],
      ),
    );
  }
}
