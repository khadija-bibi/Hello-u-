import 'package:flutter/material.dart';
import 'package:say_hello_to_world/resources/authentication.dart';
import 'package:say_hello_to_world/screens/sign_up.dart';
import 'package:say_hello_to_world/widgets/text_field_input.dart';

import '../responses/mobile_screen_layout.dart';
import '../responses/responsive_layout_screen.dart';
import '../responses/web_screen_layout.dart';
import '../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  bool loading=false;
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void loginUser()async{
    setState(() {
      loading=true;
    });
    String res = await Authentication().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      loading=false;
    });
if(res=="success"){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
  const ResponsiveLayout(
    mobileScreenLayout: MobileScreenLayout(),
    webScreenLayout: WebScreenLayout(),
  )
  ),
  );

}
else{
  showSnackBar(context,res);
}
  }
  void navigateSignUp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignUp(),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 34),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Text("Hello U",
                    style: TextStyle(
                      fontFamily: 'DancingScript',
                      color: Colors.deepPurple,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 64,
                ),
                TextFieldInput(
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,

                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,

                ),
                SizedBox(
                  height: 24,
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),

                  child: InkWell(
                    onTap:loginUser,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Color(0XFFA679CA)),
                        color: Color(0XFFA679CA),
                      ),
                      child:loading? const Center(
                        child:CircularProgressIndicator(
                          color:Colors.black87,
                        ),)
                          :Center(
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      child: Text(
                        "Dont have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                        ),

                      ),
                      padding: EdgeInsets.symmetric(
                      vertical: 8
                      ),
                    ),
                    GestureDetector(
                      onTap: navigateSignUp,
                      child: Container(

                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.deepPurple

                          ),
                          textAlign: TextAlign.justify,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 8
                      )
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
