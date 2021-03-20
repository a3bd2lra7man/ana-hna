import 'dart:convert';

import 'package:ana_hna/data/db/models/User.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/ui/widgets/LoginButton.dart';
import 'package:ana_hna/ui/widgets/LoginEditText.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m7utils/m7utils.dart';
class ProfileEditing extends StatefulWidget {
  
  @override
  _ProfileEditingState createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  String _image64;
  User _user;
  @override
  void initState() {
    _user = context.provider<AppP>().user.copyWith();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Material(
      color: context.provider<AppP>().primary[200],

      child: ListView(
        padding: EdgeInsets.all(10),
        children: [

          Center(
            child: Stack(
              children: [
                _user.image != null
                    ? CircleImage(
                  size: context.height *.25,
                  image:MemoryImage( base64Decode( _user.image)),
                )
                    : Icon(Icons.account_circle,size: context.height * .25,color: context.provider<AppP>().second[300],),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: CircleAvatar(
                      backgroundColor: AppColors.third[200],
                      child: IconButton(
                          icon: Icon(Icons.image,color: Colors.blue[900],),
                          onPressed: ()=>_changePicture(ImageSource.gallery),
                      ),
                    ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: AppColors.third[200],
                      child: IconButton(
                          icon: Icon(Icons.linked_camera,color: Colors.green[900],),
                          onPressed: ()=>_changePicture(ImageSource.camera),
                      ),
                    ),
                ),
              ],
            ),
          ),


          SizedBox(height: context.height * .1,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: LoginEditText(
                borderColor: Colors.cyan,
                hint: _user.name,
                radius: 10,
                height:context.height *.03,
                label:context.translate('Change_Name') ,
                  prefixIcon: null,
                  controller: _nameController,
                  editTextValidator: (str)=>str.length > 5 ? null : context.translate('Enter_6_Character'),
              ),
            ),
          ),

          SizedBox(height: context.height * .1,),

          // use limitedBox
          Flex(
            direction: Axis.vertical,
            children: [
              LoginButton(
                color: Colors.cyan,
                width: .4,
                height: .08,
                label: context.translate('Save'),

                onClicked:(){
                  if(_formKey.currentState.validate() || _nameController.text.isEmpty){
                    context.provider<AppP>().updateUserInfo(context, _user.copyWith(name: _nameController.text.isEmpty ? null : _nameController.text));
                  }
//                  if(_formKey.currentState.validate())
                },
                radius: 10,
              ),
            ],
          ),

        ],
      ),
    );
  }

  void _changePicture(ImageSource imageSource)async{
    PickedFile pickedFile = await ImagePicker().getImage(source: imageSource,imageQuality: 20);
    if(pickedFile != null){
      List<int> bytes = await pickedFile.readAsBytes();
      _image64 = base64Encode(bytes);
      print(_image64.length);
    }
    setState(() {
      _user = _user.copyWith(image: _image64);
    });
  }
}
