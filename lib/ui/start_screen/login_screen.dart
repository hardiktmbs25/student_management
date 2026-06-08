import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_management_app/ui/home_screen/dash_bord.dart';
import 'create_account.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = false;
  bool isLoading = false;
  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xffffffff),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff00beff), Color(0xff0042c3)],
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: loginKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 15),
              Text(
                "Enter Your Email :",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(height: 5),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "E-mail is required";
                  }
                },
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Enter Your Password :",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(height: 5),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                },
                controller: passwordController,
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                children: [
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0a50fc),
                            foregroundColor: Color(0xffffffff),
                            minimumSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashBord(),
                              ),
                            );
                            if (loginKey.currentState!.validate()) {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              setState(() {
                                isLoading = true;
                              });
                              final data = await FirebaseFirestore.instance
                                  .collection('users')
                                  .where('email', isEqualTo: email)
                                  .where('password', isEqualTo: password)
                                  .get();
                              setState(() {
                                isLoading = false;
                              });
                              if (data.docs.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashBord(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("User Login SuccessFully"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Email or Password Did Not Match",
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text("Login"),
                        ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: .center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffffffff),
                      foregroundColor: Color(0xff0a50fc),
                      minimumSize: Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15),
                        side: BorderSide(color: Color(0xff0a50fc)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccount(),
                        ),
                      );
                    },
                    child: Text("Create Account"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
