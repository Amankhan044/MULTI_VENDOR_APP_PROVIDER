import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_app_provider/controllers/auth_controller.dart';
import 'package:multi_vendor_app_provider/models/auth_provider.dart';
import 'package:multi_vendor_app_provider/views/buyers/auth/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ValueNotifier<bool> _toggle = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    Future<void> _signUpUsers() async {
      if (_formKey.currentState!.validate()) {
        String res = await authProvider.signUpUsers(
          _emailController.text,
          _nameController.text,
          _phoneController.text,
          _passwordController.text,
        );

        if (res != "success") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.yellow.shade900,
            content: Text(
              res,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.yellow.shade900,
            content: Text(
              'Congratulations! Account has been created for you.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ));

          // Clear text fields
          _emailController.clear();
          _nameController.clear();
          _phoneController.clear();
          _passwordController.clear();
        }
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
                  "Create Customer's Account",
                  style: TextStyle(fontSize: 20),
                ),
                Stack(children: [
                  authProvider.image != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(authProvider.image!),
                          backgroundColor: Colors.yellow.shade900,
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://imgs.search.brave.com/5cAi-jXDh0PdCGuh2vvsggwMUWvGlmTFmbCQ7jYJ9OI/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAyLzE1Lzg0LzQz/LzM2MF9GXzIxNTg0/NDMyNV90dFg5WWlJ/SXllYVI3TmU2RWFM/TGpNQW15NEd2UEM2/OS5qcGc'),
                          backgroundColor: Colors.yellow.shade900,
                          radius: 64,
                        ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                          onPressed: () {
                            authProvider.selectGalleryImage();
                          },
                          icon: Icon(
                            CupertinoIcons.photo,
                          )))
                ]),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Enter Email"),
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
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Enter Full Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration:
                        InputDecoration(labelText: "Enter Phone Number"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
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
                              labelText: "Password",
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
                GestureDetector(
                  onTap: _signUpUsers,
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
                              'Register',
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
                    Text('Already Have An Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ));
                      },
                      child: Text('Login'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
