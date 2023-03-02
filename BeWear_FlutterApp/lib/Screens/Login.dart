import 'package:clothewardrobe/Screens/Swipe.dart';
import 'package:clothewardrobe/Screens/WardrobeSelector.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D0DF),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(left: 71,right: 71,top: 40),
            child: Image(
              image: AssetImage("images/logo.png"),
              height: 251,
              width: 412,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 139, right: 140, top: 17),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                  color: Color(0xfff5f5f5)),
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 81, right: 81),
            child: Text(
              "Create your account below",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff878787)),
            ),
          ),
          const SizedBox(
            height: 49,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff5f5f5),
                hintText: "Email address or phone number",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.transparent, width: 343),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.transparent, width: 343),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 23,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff5F5F5),
                hintText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.transparent, width: 343),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.transparent, width: 343),
                  borderRadius: BorderRadius.circular(16),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xff878787)),
                  onPressed: () {
                    setState(
                          () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SwipeCardPage()),
              );
            },
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xffFFFFFF)),
                fixedSize: const Size(343, 60),
                backgroundColor: const Color(0xffef8100),
                onPrimary: const Color(0xffFFFFFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
            child: const Text("To Log In"),
          ),
        )
        ]),
      ),
    );
  }
}
