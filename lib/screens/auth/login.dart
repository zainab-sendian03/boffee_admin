import 'package:boffee_admin/core/components/crud.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../core/constants/Customtextformfiled.dart';
import '../../core/constants/alerts.dart';
import '../../core/constants/linksapi.dart';
import '../../main.dart';
import '../home.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final User_name = TextEditingController();
  final password = TextEditingController();
  bool passwordVisible = true;
  Crud _crud = Crud();
  GlobalKey<FormState> formstats = GlobalKey();
  late final String? Function(String?) valid;
  logIn() async {
    if (formstats.currentState!.validate()) {
      try {
        var response = await _crud.postrequest(linklogin, {
          "user_name": User_name.text,
          "password": password.text,
        });
        if (response is Map && response['success'] == true) {
          pref.setString("id", response['data']['id'].toString());
          pref.setString("user_name", response['data']['user_name']);
          pref.setString("password", response['data']['password']);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => home()),
          );
        } else {
          wrongLogin(formstats.currentContext!);
        }
      } catch (e) {
        print("ERROR $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "asset/images/admin1.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                    width: 350,
                    height: 430,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4C6444).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: ListView(children: [
                        Form(
                            key: formstats,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 50,
                                  left: 50,
                                ),
                                child: Column(children: [
                                  const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 35),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CustomTextFormField(
                                    hintText: "User name",
                                    controller: User_name,
                                    min: 2,
                                    max: 8,
                                    visPassword: false,
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  CustomTextFormField(
                                    showVisPasswordToggle: true,
                                    hintText: "Password",
                                    controller: password,
                                    min: 7,
                                    max: 20,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forget password?",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await logIn();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                        )),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xFF4C6444)),
                                    ),
                                  ),
                                ])))
                      ]),
                    )),
              ),
            ),
          ],
        ));
  }
}
