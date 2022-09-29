
import 'package:athath/modules/register/cuibt/states.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var userNameController = TextEditingController();
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

  signUp(context)async{
    try{
      emit(RegisterLoadingState());
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch(e){
      emit(RegisterErrorState(e));
      if(e.code=="weak-password")
      {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Error',
            desc: 'Password Is Too Weak!!',
            btnOkColor: Colors.red,
            btnOkOnPress: (){}
        ).show();
      }else if(e.code=="email-already-in-use")
      {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Error',
            desc: 'Email Already In Use!!',
            btnOkOnPress: () {},
            btnOkColor: Colors.red
        ).show();
      }
    }catch(e){
      emit(RegisterErrorState(e));
      print(e);
    }
  }


}