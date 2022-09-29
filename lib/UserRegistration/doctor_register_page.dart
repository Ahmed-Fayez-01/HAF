import 'package:admin/UserRegistration/cubit/cubit.dart';
import 'package:admin/UserRegistration/cubit/states.dart';
import 'package:admin/componants/componants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorRegisterScreen extends StatelessWidget {
  DoctorRegisterScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>UserRegistrationCubit(),
      child: BlocConsumer<UserRegistrationCubit,UserRegistrationStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=UserRegistrationCubit.get(context);
          return Scaffold(
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
                              fontSize: 40,
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
                        height: 30,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           const Text(
                              'Register As a Doctor',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'We are Happy to Join In Our Community',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Email Must not be Empty";
                                }
                                return null;
                              },
                              label: "Email",
                              prefix: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Password Must not be Empty";
                                }
                                return null;
                              },
                              label: "Password",
                              prefix: Icons.lock_outline,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: nameController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Name Must not be Empty";
                                }
                                return null;
                              },
                              label: "Name",
                              prefix: Icons.person_outline,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Phone Must not be Empty";
                                }
                                return null;
                              },
                              label: "Phone",
                              prefix: Icons.phone,
                            ),
                            const SizedBox(
                              height: 20,
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
                            )
                          ],
                        ),
                      ),
                    ],
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
