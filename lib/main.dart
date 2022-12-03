import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'package:say_hello_to_world/providers/user_provider.dart';
import 'package:say_hello_to_world/responses/mobile_screen_layout.dart';
import 'package:say_hello_to_world/responses/responsive_layout_screen.dart';
import 'package:say_hello_to_world/responses/web_screen_layout.dart';
import 'package:say_hello_to_world/screens/log_in.dart';
import 'package:say_hello_to_world/screens/sign_up.dart';
import 'package:say_hello_to_world/screens/to_post.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if(kIsWeb){
    await Firebase.initializeApp();
  }
  else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: SignUp(),
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        // home: ResponsiveLayout(webScreenLayout: WebScreenLayout(),mobileScreenLayout: MobileScreenLayout(),),
          home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
      // Checking if the snapshot has any data or not
      if (snapshot.hasData) {
        // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
        return const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        );
      }
      else if (snapshot.hasError) {
        return Center(
          child: Text('${snapshot.error}'),
        );
      }
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return const Login();
  },

      ),

      ),
    );


        }
  }
