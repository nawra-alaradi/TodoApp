import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey_flutter/extension.dart';
import 'package:todoey_flutter/widgets/my-text_form_field.dart';
import 'package:todoey_flutter/widgets/my_elevated_button.dart';
import 'package:todoey_flutter/services.dart';
import 'package:provider/provider.dart';
import 'otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //global keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool isSignedIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //Container used to fill a background screen image
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/cool-background.png'),
                fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () {
              if (_formKey.currentState != null) {
                setState(() {
                  _isButtonEnabled = _formKey.currentState!.validate();
                });
              }
            },
            child: ListView(
              padding: EdgeInsets.only(top: 17.h, bottom: 53.h),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 23.w),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25.h,
                        ),
                      )),
                ),
                SizedBox(
                  height: 23.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null) {
                        return null;
                      } else if (value.isEmpty) {
                        return 'This field is required*';
                      } else if (value.isValidEmail) {
                        return null;
                      } else {
                        return 'Enter a valid email';
                      }
                    },
                    hintText: "Enter your email",
                    errorText: null,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    maxLength: 30,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _emailController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null) {
                        return null;
                      } else if (value.isEmpty) {
                        return 'This field is required*';
                      } else if (value.isValidPassword) {
                        return null;
                      } else {
                        return 'Enter a valid password';
                      }
                    },
                    hintText: "Enter your password",
                    errorText: null,
                    labelText: 'Password',
                    textInputType: TextInputType.text,
                    maxLength: 12,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _passwordController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 122.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: MyElevatedButton(
                      text: 'Register',
                      color: const Color(0xFF000000).withOpacity(0.58),
                      onPressed: (_formKey.currentState != null &&
                              _formKey.currentState!.validate() &&
                              _isButtonEnabled)
                          ? () async {
                              bool res = await Provider.of<Auth>(context,
                                      listen: false)
                                  .signup(_emailController.text,
                                      _passwordController.text);
                              print(res);
                              if (res) {
                                Navigator.pushNamed(context, OTPScreen.id,
                                    arguments: _emailController.text);
                              } else {
                                print('Could not sign user up');
                              }
                              // try {
                              //   SignInResult res = await Amplify.Auth.signIn(
                              //       username: _phoneController.text,
                              //       password: _phoneController.text,
                              //       options: CognitoSignInOptions(
                              //           clientMetadata: {
                              //             "phone_number": _phoneController.text
                              //           }));
                              //   setState(() {
                              //     isSignedIn = res.isSignedIn;
                              //     print(isSignedIn);
                              //     print("Res value: $res");
                              //   });
                              // } on AuthException catch (e) {
                              //   print(e.message);
                              // }
                              // // Navigator.pushNamed(context, OTPScreen.id);
                            }
                          : null),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
