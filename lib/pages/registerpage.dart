import 'package:flutter/material.dart';
import 'package:pet_app/components/my_button.dart';
import 'package:pet_app/components/my_loading_circle.dart';
import 'package:pet_app/components/my_text_field.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/auth/database/database_service.dart';

/*REGISTER PAGE

ON THIS PAGE NEW USER CAN create an account
*/

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //access auth and db services
  final _auth = AuthService();
  final _db = DatabaseService();

  //register button tapped
  void register() async {
    //passwords match then create user

    if (pwController.text == confirmPwcontroller.text) {
      //show loading circle
      showLoadingCircle(context);

      //attempt to register new user
      try {
        //trying to register
        await _auth.registerEmailPassword(
          emailController.text,
          pwController.text,
        );

        //finished loading
        if (mounted) hideLoadingCircle(context);

        //once registered , create and save userprofile in database

        await _db.saveUserInfoInFirebase(
            name: nameController.text, email: emailController.text);

        //btw
      }

      //catch any errors
      catch (e) {
        //finished loading
        if (mounted) hideLoadingCircle(context);

        //let user know of the error

        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      }
    }

    //passwords dont match then show error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
    }
  }

  //text field controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,

        //BODY
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_open_rounded,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(height: 25),

                  //create an account message
                  Text(
                    "Create an account for you",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //name textfield
                  MyTextField(
                    controller: nameController,
                    hintText: "Enter name",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Enter your email",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //password textfield
                  MyTextField(
                    controller: pwController,
                    hintText: "Enter password",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //confirm Password textfield
                  MyTextField(
                    controller: confirmPwcontroller,
                    hintText: "confirm password",
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),

                  //sign up button
                  MyButton(
                    text: "Register",
                    onTap: register,
                  ),

                  //already a member? login here.
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a Member?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),

                      const SizedBox(width: 5),

                      //user can tap on this to go to register page
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "login now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  //bottom links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Terms of Service",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
