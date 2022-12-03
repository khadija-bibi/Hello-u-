import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:say_hello_to_world/models/userModel.dart';
import 'package:say_hello_to_world/providers/user_provider.dart';
import 'package:say_hello_to_world/utils/utils.dart';
import 'dart:typed_data';
import 'package:say_hello_to_world/resources/firestore_methods.dart';

import '../resources/firestore_methods.dart';


class ToPost extends StatefulWidget {
  const ToPost({Key? key}) : super(key: key);

  @override
  State<ToPost> createState() => _ToPostState();
}

class _ToPostState extends State<ToPost> {
  Uint8List? _file;
  bool _loading = false;
  final _inscriptionController = TextEditingController();


  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(

        title: const Text("Make a Post"),
        children: [SimpleDialogOption(
          padding: EdgeInsets.all(21),
          child: Text("Take Photo"),
          onPressed: () async {
            Navigator.of(context).pop();
            Uint8List file = await pickImage(ImageSource.camera);
            setState(() {
              _file = file;
            });
          },
        ),
          SimpleDialogOption(
            padding: EdgeInsets.all(21),
            child: Text("Choose image from gallery"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(21),
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  void postImage(String userId, String name, String profImage) async {
    setState(() {
      _loading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _inscriptionController.text,
        _file!,
        userId,
        name,
        profImage,
      );
      if (res == "success") {
        setState(() {
          _loading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        _loading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _inscriptionController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final User user = Provider
        .of<UserProvider>(context)
        .getUser;
    return _file == null
        ? Center(
      child: IconButton(
        icon: Icon(Icons.upload),
        onPressed: () => _selectImage(context),
      ),
    )
        : Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () =>clearImage,
          ),
          title: Text("New Post"),
          actions: [
            IconButton(
              onPressed: () =>
                  postImage(
                    user.uid,
                    user.name,
                    user.photoUrl,
                  ),
              icon: Icon(Icons.check_circle),


              color: Colors.white,
              iconSize: 32,
            ),
          ]
      ),
      body: Column(
        children: [
          _loading? const LinearProgressIndicator()
          :const Padding(
            padding: EdgeInsets.only(top:0),
          ),
          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 32,


              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3,
                child: TextField(
                  controller: _inscriptionController,
                  decoration: InputDecoration(
                    hintText: "Write inscription....",
                    border: InputBorder.none,

                  ),

                  maxLines: 5,

                ),

              ),
              Divider(),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter),

                    ),
                  ),
                ),
              )
            ],
          )
        ],

      ),


    );
  }
}
