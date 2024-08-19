import 'package:flutter/material.dart';
import 'package:multi_vendor_app_provider/models/auth_provider.dart';
import 'package:multi_vendor_app_provider/views/buyers/auth/register_screen.dart';
import 'package:multi_vendor_app_provider/views/buyers/main_view.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _toggle = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    Future _loginUsers() async {
      if (_formKey.currentState!.validate()) {
        String res = await authProvider.loginUsers(
          _emailController.text,
          _passwordController.text,
        );
        _emailController.clear();
        _passwordController.clear();

        if (res == "You Are Now Logged In") {
          return Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return MainView();
            },
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.yellow.shade900,
            content: Text(
              res,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow.shade900,
          content: Text(
            'Please Fields Must Not Be Empty.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
      }
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login Customer's Account",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration:
                        InputDecoration(labelText: "Enter Email Address"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: _toggle,
                    builder: (BuildContext context, value, Widget? child) {
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: "Enter Password",
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                  onTap: () {
                                    _toggle.value = !_toggle.value;
                                  },
                                  child: Icon(_toggle.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility))),
                          obscureText: _toggle.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _loginUsers,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: authProvider.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                              ),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Need An Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return RegisterScreen();
                          },
                        ));
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
