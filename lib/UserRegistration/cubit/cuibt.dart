
import 'dart:io';
import 'package:path/path.dart';
import 'package:admin/UserRegistration/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../componants/constant.dart';
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  ListView getNotecheckList() {
    return ListView.builder(
      physics : const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (_, int index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.2, 1.0), //(x,y)
                  blurRadius: 1,
                ),
              ],
            ),
            child: CheckboxListTile(
              title: const Text("Doctor Name",style: TextStyle(
                fontSize: 18,
              ),),
              subtitle: Text("Department Name"),
              value: selectedIndexes.contains(index),
              onChanged: (_) {
                if (selectedIndexes.contains(index)) {
                  selectedIndexes.remove(index);   // unselect
                } else {
                  selectedIndexes.add(index);  // select
                }
                emit(selectedIndexesUpdatState());
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        );
      },
    );
  }
  int currentStep = 0;
  onStepCancel() {
    currentStep--;
    emit(OnStepCancelState());
  }
  void onStepContinue() {
    currentStep++;
    emit(OnStepContinueState());
  }
  onStepTap(int step) {
    currentStep = step;
    emit(OnStepTapState());
  }
  bool isConfirmPasswordShow = true;
  bool isFirstPasswordShow = true;
  void toggleFirstPass() {
    isFirstPasswordShow = !isFirstPasswordShow;
    emit(ChangeSuffixIconState());
  }
  void toggleSecondPass() {
    isConfirmPasswordShow = !isConfirmPasswordShow;
    emit(ChangeSuffixIconState());
  }
  final formKey = GlobalKey<FormState>();
  ImagePicker pickedImage=ImagePicker();
  File? image;
  String? imageName;
  Future getGalleryImage() async {
    final selectedImage = await pickedImage.pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      image = File(selectedImage.path);
      imageName = basename(selectedImage.path);
      print(imageName);
      emit(PickedImageSuccessState());
    } else {}
  }
  Future getCameraImage() async {
    final selectedImage = await pickedImage.pickImage(
      source: ImageSource.camera,
    );
    if (selectedImage != null) {
      image = File(selectedImage.path);
      imageName = basename(selectedImage.path);
      print(imageName);
      emit(PickedImageSuccessState());
    } else {}
  }

  // signUp(context)async{
  //   try{
  //     emit(RegisterLoadingState());
  //     UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  //     emit(RegisterSuccessState());
  //   } on FirebaseAuthException catch(e){
  //     emit(RegisterErrorState(e));
  //     if(e.code=="weak-password")
  //     {
  //       AwesomeDialog(
  //           context: context,
  //           dialogType: DialogType.ERROR,
  //           animType: AnimType.BOTTOMSLIDE,
  //           title: 'Error',
  //           desc: 'Password Is Too Weak!!',
  //           btnOkColor: Colors.red,
  //           btnOkOnPress: (){}
  //       ).show();
  //     }else if(e.code=="email-already-in-use")
  //     {
  //       AwesomeDialog(
  //           context: context,
  //           dialogType: DialogType.ERROR,
  //           animType: AnimType.BOTTOMSLIDE,
  //           title: 'Error',
  //           desc: 'Email Already In Use!!',
  //           btnOkOnPress: () {},
  //           btnOkColor: Colors.red
  //       ).show();
  //     }
  //   }catch(e){
  //     emit(RegisterErrorState(e));
  //     print(e);
  //   }
  // }


}