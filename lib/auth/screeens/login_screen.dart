import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_project/auth/utils/show_snack_bar.dart';

import '../../constants.dart';
import '../../home/screens/home_screen.dart';
import '../services/for_firebase_backend.dart';
import '../utils/text_field_validator.dart';
import '../widgets/custom_text_form_field.dart';

import 'dart:ui' as ui;

import '../widgets/loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Form Key
  final _formKey = GlobalKey<FormState>();

  //for animation
  bool _isSignInSide = true;
  double angle = 0;

  //for loader
  bool _isLoading = false;

  //Text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  //for animation
  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  //sign-in button press
  void signInButtonPress() {
    final isTextOk = _formKey.currentState!.validate();
    if (isTextOk) {
      firebaseSignIn();
    }
  }

  //register button press
  void registerButtonPress() {
    final isTextOk = _formKey.currentState!.validate();
    if (isTextOk) {
      firebaseRegister();
    }
  }

  //for firebase backend - Firebase sign-up
  Future<void> firebaseRegister() async {
    final FirebaseServices firebaseServices = FirebaseServices();

    setState(() {
      _isLoading = true;
    });

    final isOk = await firebaseServices.signUpWithEmail(
        email: _emailController.text,
        context: context,
        password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });

    if (isOk) {
      _flip();
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, text: "Register completed! Now you can Sign-IN");
    }
  }

  //for firebase backend - Firebase sign-in
  Future<void> firebaseSignIn() async {
    final FirebaseServices firebaseServices = FirebaseServices();

    setState(() {
      _isLoading = true;
    });

    final isOk = await firebaseServices.signInWithEmail(
        email: _emailController.text,
        context: context,
        password: _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (isOk) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: "Sign-in successfully!");

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const textStyle1 = TextStyle(
      fontSize: 20,
      color: primaryColor,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    SizedBox(
                        height: size.height * 0.3,
                        child: Image.asset(
                            'assets/images/flutterigenagamu_black&white.png')),
                    SizedBox(
                      height: size.height * 0.06,
                    ),

                    //For animation
                    TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: angle),
                        duration: const Duration(seconds: 1),
                        builder: (BuildContext context, double val, _) {
                          if (val >= (pi / 2)) {
                            _isSignInSide = false;
                          } else {
                            _isSignInSide = true;
                          }
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(val),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    width: 1,
                                  )),
                              child: _isSignInSide
                                  //signUp Widget
                                  ? signInWidget(textStyle1: textStyle1)
                                  //signIn Widget
                                  : Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..rotateY(pi),
                                      child: signUpWidget(
                                        textStyle1: textStyle1,
                                      ),
                                    ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              _isLoading
                  ? Positioned.fill(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: 3.0,
                          sigmaY: 3.0,
                        ),
                        child: const Loader(),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget signInWidget({required TextStyle textStyle1}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email', style: textStyle1),
                    Text(':', style: textStyle1),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              customTextFormField(
                controller: _emailController,
                textValidator: (typedText) {
                  return textValidator(
                    inputFieldType: InputFieldType.email,
                    typedText: typedText,
                  );
                },
                hintText: emailHintText,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Password', style: textStyle1),
                    Text(':', style: textStyle1),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              customTextFormField(
                obscureText: true,
                controller: _passwordController,
                textValidator: (typedText) {
                  return textValidator(
                    inputFieldType: InputFieldType.password,
                    typedText: typedText,
                  );
                },
                hintText: passwordHintText,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Don't have an Account? ",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => _flip(),
                      text: 'Register',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: secondaryColor,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => signInButtonPress(),
                child: const Text("Sign In"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget signUpWidget({required TextStyle textStyle1}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email', style: textStyle1),
                    Text(':', style: textStyle1),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              customTextFormField(
                controller: _emailController,
                textValidator: (typedText) {
                  return textValidator(
                    inputFieldType: InputFieldType.email,
                    typedText: typedText,
                  );
                },
                hintText: emailHintText,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Password', style: textStyle1),
                    Text(':', style: textStyle1),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              customTextFormField(
                obscureText: true,
                controller: _passwordController,
                textValidator: (typedText) {
                  return textValidator(
                    inputFieldType: InputFieldType.password,
                    typedText: typedText,
                  );
                },
                hintText: passwordHintText,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Already have an Account? ",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => _flip(),
                      text: 'Sign In',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80,
                height: 35,
                child: ElevatedButton(
                  onPressed: () => registerButtonPress(),
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
