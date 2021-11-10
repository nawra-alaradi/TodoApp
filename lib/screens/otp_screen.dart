import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey_flutter/extension.dart';
import 'package:todoey_flutter/widgets/my-text_form_field.dart';
import 'package:todoey_flutter/widgets/my_elevated_button.dart';
import 'package:todoey_flutter/screens/tasks_screen.dart';
import 'package:todoey_flutter/services.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  static const String id = 'OTPScreen';
  const OTPScreen({Key? key}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  //global keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments
        as String; //we will receive either 'patient' or 'doctor'
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
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: MyTextFormField(
                    validator: (String? value) {
                      if (value == null) {
                        return null;
                      } else if (value.isEmpty) {
                        return 'This field is required*';
                      } else if (value.isValidOtp) {
                        return null;
                      } else {
                        return 'OTP must be six digits long';
                      }
                    },
                    hintText: "Enter one time verification code",
                    errorText: null,
                    labelText: 'OTP',
                    textInputType: TextInputType.phone,
                    maxLength: 6,
                    onChnaged: (String val) {},
                    onTap: () {},
                    icon: null,
                    controller: _otpController,
                    isObsecure: false,
                  ),
                ),
                SizedBox(
                  height: 122.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: MyElevatedButton(
                      text: 'Verify',
                      color: const Color(0xFF000000).withOpacity(0.58),
                      onPressed: (_formKey.currentState != null &&
                              _formKey.currentState!.validate() &&
                              _isButtonEnabled)
                          ? () async {
                              bool res = await Provider.of<Auth>(context,
                                      listen: false)
                                  .confirmSignUp(email, _otpController.text);
                              print(res);
                              if (res) {
                                Navigator.pushNamed(context, TasksScreen.id);
                              } else {
                                print('Wrong OTP');
                              }
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
    _otpController.dispose();
  }
}
