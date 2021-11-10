import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey_flutter/screens/otp_screen.dart';
import 'package:todoey_flutter/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/modals/task_data.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
//import 'amplifyconfiguration.dart';
//import 'package:amplify_flutter/amplify.dart';
import 'package:todoey_flutter/screens/registration_screen.dart';
import 'package:todoey_flutter/screens/login_screen.dart';
import 'configure_amplify.dart';
import 'services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool _amplifyConfigured = false;
  //
  // Future<void> _configureAmplify() async {
  //   try {
  //     AmplifyAuthCognito auth = AmplifyAuthCognito();
  //     Amplify.addPlugin(AmplifyAuthCognito());
  //     await Amplify.configure(amplifyconfig);
  //
  //     setState(() => _amplifyConfigured = true);
  //   } catch (e) {
  //     print(e);
  //     setState(() => _amplifyConfigured = false);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _configureAmplify();
  }

  // void _configureAmplify() async {
  //   // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
  //   // AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
  //   AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  //   await Amplify.addPlugins([authPlugin]);
  //
  //   // Once Plugins are added, configure Amplify
  //   // Note: Amplify can only be configured once.
  //   try {
  //     await Amplify.configure(amplifyconfig);
  //   } on AmplifyAlreadyConfiguredException {
  //     print(
  //         "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(
            create: (BuildContext context) => TaskData()),
        ChangeNotifierProvider<Auth>(create: (BuildContext context) => Auth())
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 640),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id: (context) => const LoginScreen(),
            RegistrationScreen.id: (context) => const RegistrationScreen(),
            TasksScreen.id: (context) => TasksScreen(),
            OTPScreen.id: (context) => const OTPScreen(),
          },
        ),
      ),
    );
  }

  // void someMethod() async {
  //   try {
  //     Map<String, String> userAttributes = {
  //       'email': 'email@domain.com',
  //       'phone_number': '+15559101234',
  //       // additional attributes as needed
  //     };
  //     SignUpResult res = await Amplify.Auth.signUp(
  //         username: 'myusername',
  //         password: 'mysupersecurepassword',
  //         options: CognitoSignUpOptions(userAttributes: userAttributes));
  //     setState(() {
  //       var isSignUpComplete = res.isSignUpComplete;
  //     });
  //   } on AuthException catch (e) {
  //     print(e.message);
  //   }
  // }
}
