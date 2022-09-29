import 'package:admin/componants/componants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cuibt.dart';
import 'cubit/states.dart';
import 'login-screen.dart';

class DoctorRegisterScreen extends StatelessWidget {
  DoctorRegisterScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var RepasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=RegisterCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                                  "assets/images/splach.png",
                                  width: 100,
                                )),
                            const Text(
                              'H.A.F',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Community',
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 6,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             const Text(
                                'Sign Up as a Doctor',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'We are Happy To Join In Our Community',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultFormField(
                                context: context,
                                controller: nameController,
                                type: TextInputType.text,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Must not be Empty";
                                  }
                                  return null;
                                },
                                label: "Full Name",
                                prefix: Icons.person_outline,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                context: context,
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Must not be Empty";
                                  }
                                  return null;
                                },
                                label: "Department",
                                prefix: CupertinoIcons.home,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                context: context,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Must not be Empty";
                                  }
                                  return null;
                                },
                                label: "Email",
                                prefix: Icons.email_outlined,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                context: context,
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Must not be Empty";
                                  }
                                  return null;
                                },
                                label: "Password",
                                prefix: Icons.lock_outline,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                context: context,
                                controller: RepasswordController,
                                type: TextInputType.visiblePassword,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Must not be Empty";
                                  }
                                  return null;
                                },
                                label: "Re-Password",
                                prefix: Icons.lock_outline,
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Upload Your National Id",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        cubit.getCameraImage();
                                      }, icon: const Icon(Icons.camera_alt)),
                                  IconButton(
                                      onPressed: () {
                                        cubit.getGalleryImage();
                                      },
                                      icon: const Icon(Icons.file_copy_outlined)),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              if(cubit.image !=null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),

                                    ),
                                    child: Image.file(cubit.image!,height: 100,),
                                  ),
                                  const SizedBox(height: 5,),

                                  Text(cubit.imageName.toString()),
                                ],
                              ),


                              const SizedBox(height: 20,),
                              defaultButton(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                text: "Sign Up",
                                onTap: (){

                                  if(formKey.currentState!.validate()){
                                    if(cubit.image ==null){
                                      toast(text: "Please Upload Your National Id");
                                    }
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already Have an Account?",
                                    style: TextStyle(
                                      fontSize: width*.045,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width*.02,
                                  ),
                                  InkWell(
                                    child:  Text(
                                      'LogIn',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:  width*.045,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const LoginScreen()));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
