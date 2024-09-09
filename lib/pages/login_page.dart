import 'package:flutter/material.dart';
import 'package:pet_app/components/my_button.dart';
import 'package:pet_app/components/my_loading_circle.dart';
import 'package:pet_app/components/my_text_field.dart';
import 'package:pet_app/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //access auth service
  final _auth = AuthService();

  // Function to show error message
  void showErrorMessage(BuildContext context, String message) {
    // Show a dialog with the error message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //login method
  void login() async {
    //show loading circle
    showLoadingCircle(context);

    try {
      //trying to login
      await _auth.loginEmailPassword(emailController.text, pwController.text);

      //finished loading circle
      if (mounted) hideLoadingCircle(context);
    } catch (e) {
      //finished loading...
      if (mounted) hideLoadingCircle(context);

      //let user know there was an error
      if (e.toString().contains('ERROR_USER_NOT_FOUND')) {
        // User not found
        showErrorMessage(context, 'User not found. Please register first.');
      } else if (e.toString().contains('ERROR_WRONG_PASSWORD')) {
        // Wrong password
        showErrorMessage(context, 'Incorrect password. Please try again.');
      } else if (e.toString().contains('ERROR_INVALID_EMAIL')) {
        // Invalid email
        showErrorMessage(context,
            'Invalid email address. Please enter a valid email address.');
      } else {
        // Other error
        showErrorMessage(
            context, 'Credentials Do not match!. Please try again later.');
      }
    }
  }

  //text field controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController controller = TextEditingController();

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

                  //welcome back message
                  Text(
                    "Welcome back, you\'ve been missed!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Enter email..",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //password textfield
                  MyTextField(
                    controller: pwController,
                    hintText: "Enter Password",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //forgot password

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
                  ),

                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    text: "Login",
                    onTap: login,
                  ),

                  //not a member, sign up now,
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
                          "Register now",
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
