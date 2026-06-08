import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/model/auth_model.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;
  final createScreen = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Create Account',
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: createScreen,
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Enter Your Name :",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Name is Required";
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.abc),
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter Your Email :",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "E-mail is Required";
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
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Password is Required";
                    }
                    if(value.length < 6 ){
                      return "Password must be 6 Digits";
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
                  children: [
                    isLoading?CircularProgressIndicator():
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0a50fc),
                        foregroundColor: Color(0xffffffff),
                        minimumSize: Size(150, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        if(createScreen.currentState!.validate()){
                        CreateModel authModel = CreateModel(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await FirebaseFirestore.instance
                              .collection("users")
                              .add(authModel.toJson());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("User Created SuccessFully")),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
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
