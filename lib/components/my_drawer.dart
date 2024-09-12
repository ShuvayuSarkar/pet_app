import 'package:flutter/material.dart';
import 'package:pet_app/components/my_drawer_tile.dart';
import 'package:pet_app/pages/profile_page.dart';
import 'package:pet_app/pages/settings_page.dart';
import 'package:pet_app/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  //access auth service
  final _auth = AuthService();

  //logouts
  void logout() {
    _auth.logout();
  }

  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Icon(
                    Icons.person,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                //divider line
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                const SizedBox(height: 10),

                //home list tile

                MyDrawerTile(
                  title: "C H A T  P A G E",
                  icon: Icons.chat_bubble,
                  onTap: () {
                    //pop up menu drawer since we are already at home
                    Navigator.pop(context);
                  },
                ),
                //profile list tile
                MyDrawerTile(
                  title: "P R O F I L E",
                  icon: Icons.person,
                  onTap: () {
                    //pop meny drawer
                    Navigator.pop(context);

                    //go to profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(uid: _auth.getCurrentUid()),
                      ),
                    );
                  },
                ),
                //search list tile

                //settings list tile
                MyDrawerTile(
                  title: "S E T T I N G S",
                  icon: Icons.settings,
                  onTap: () {
                    //pop menu drawer
                    Navigator.pop(context);

                    //go to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),

                const Spacer(),

                //logout list tile
                MyDrawerTile(
                  title: "L O G O U T",
                  icon: Icons.logout,
                  onTap: logout,
                ),
              ],
            ),
          ),
        ));
  }
}
