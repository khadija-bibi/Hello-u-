import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:say_hello_to_world/resources/authentication.dart';

import '../responses/mobile_screen_layout.dart';
import '../responses/responsive_layout_screen.dart';
import '../responses/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool loading=false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
void signUpUser()async{
    setState(() {
      loading=true;
    });
  String res = await Authentication().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      bio: _bioController.text,
      file: _image!);
    setState(() {
      loading=false;
    });
  if(res!="success"){
    showSnackBar(context,res);

  } else{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
    const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
      webScreenLayout: WebScreenLayout(),
    )
    ),
    );
  }

}
  void navigateLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Login(),
    ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 34),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column (
              mainAxisSize: MainAxisSize.min,
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 64,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEammMOQs3IJqbPrHVM-AjSgXJX1jLucdpZA&usqp=CAU"),
                          ),
                    Positioned(
                      bottom: -15,
                      left: 70,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo_rounded,
                          size: 24,
                          color: Colors.indigo,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 64,
                ),
                TextFieldInput(
                  hintText: "Enter your name",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _nameController,
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                TextFieldInput(
                  hintText: "Enter your Bio",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _bioController,
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: InkWell(
                    onTap: signUpUser,
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
                      : Center(
                          child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      )),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 24,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //
                //       child: Text(
                //         "Dont have an account?",
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //
                //         ),
                //
                //       ),
                //       padding: EdgeInsets.symmetric(
                //           vertical: 8
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: (){
                //
                //       },
                //       child: Container(
                //
                //           child: Text(
                //             "SIGN UP",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 15,
                //                 color: Colors.deepPurple
                //
                //             ),
                //             textAlign: TextAlign.justify,
                //           ),
                //           padding: EdgeInsets.symmetric(
                //               vertical: 8
                //           )
                //       ),
                //     ),
                //   ],
                // ),
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
