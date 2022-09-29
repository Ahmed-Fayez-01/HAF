import 'dart:async';

import 'package:admin/UserRegistration/cubit/states.dart';
import 'package:admin/UserRegistration/login-screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home/home-page.dart';
import '../componants/componants.dart';
import '../componants/constant.dart';
import 'cubit/cuibt.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool load = false;
  List<String> itemsAcademic = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];
  List<String> itemsDepartment = [
    'IT Department',
    'IS Department',
    'CS Department',
    'MM Department',
  ];
  String? dropValAcademicYear;
  String? dropValDepartment;
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var codeController = TextEditingController();

  // late StreamSubscription<InternetConnectionStatus> subscription;

  // @override
  // initState() {
  //   super.initState();
  //
  //   subscription = InternetConnectionChecker().onStatusChange.listen(
  //         (InternetConnectionStatus status) {
  //       switch (status) {
  //         case InternetConnectionStatus.connected:
  //           setState(() {
  //             load = false;
  //             hasInternet = true;
  //           });
  //           print(hasInternet);
  //           break;
  //         case InternetConnectionStatus.disconnected:
  //         // ignore: avoid_print
  //           setState(() {
  //             hasInternet = false;
  //           });
  //           print(hasInternet);
  //           break;
  //       }
  //     },
  //   );
  // }

// Be sure to cancel subscription after you are done
//   @override
//   dispose() {
//     super.dispose();
//
//     subscription.cancel();
//   }

  var nameController = TextEditingController();

  var selectedIndex;

  var countryIndex;

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  String? country;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            pageNum = 0;
            final snackBar = SnackBar(
              padding: EdgeInsets.all(width * .03),
              content: const Text('Email Verification Sent'),
              action: SnackBarAction(
                label: 'Go',
                onPressed: () async {},
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            // userId=FirebaseAuth.instance.currentUser!.uid;

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => const VerifyPage()));
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          List<Step> getSteps() => [
                Step(
                  state: cubit.currentStep > 0
                      ? StepState.complete
                      : StepState.indexed,
                  isActive: cubit.currentStep >= 0,
                  title: Text("Basic Info",
                      style: TextStyle(fontSize: width * .045)),
                  content: SingleChildScrollView(
                    child: Column(
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
                        Container(
                          alignment: Alignment.center,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Sign Up as a Student',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'We are Happy To Join In Our Community',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                    context: context,
                                    controller: codeController,
                                    type: TextInputType.number,
                                    validate: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Must not be empty";
                                      }
                                      return null;
                                    },
                                    label: "Code",
                                    prefix: Icons.person_outline),
                                SizedBox(
                                  height: height * .015,
                                ),
                                defaultFormField(
                                    context: context,
                                    controller: nameController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Must not be empty";
                                      }
                                      return null;
                                    },
                                    label: "Full Name",
                                    prefix: Icons.person_outlined),
                                SizedBox(
                                  height: height * .015,
                                ),
                                defaultFormField(
                                    context: context,
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    validate: (val) =>
                                        EmailValidator.validate(val!)
                                            ? null
                                            : "Enter Valid Email",
                                    label: "Email",
                                    prefix: Icons.email_outlined),
                                SizedBox(
                                  height: height * .015,
                                ),
                                defaultFormField(
                                    context: context,
                                    controller: passwordController,
                                    isPassword: cubit.isFirstPasswordShow,
                                    type: TextInputType.visiblePassword,
                                    validate: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Must not be empty";
                                      } else if (val.length < 8) {
                                        return "8 Letters or More";
                                      }
                                      return null;
                                    },
                                    label: "Password",
                                    prefix: Icons.lock_open,
                                    suffixPressed: cubit.toggleFirstPass,
                                    suffix: cubit.isFirstPasswordShow
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                SizedBox(
                                  height: height * .015,
                                ),
                                defaultFormField(
                                    context: context,
                                    controller: confirmPasswordController,
                                    isPassword: cubit.isConfirmPasswordShow,
                                    type: TextInputType.visiblePassword,
                                    validate: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Must not be empty";
                                      }
                                      if (val != passwordController.text) {
                                        return "Not Identical";
                                      }
                                      return null;
                                    },
                                    label: "Re-Password",
                                    prefix: Icons.lock_open,
                                    suffixPressed: cubit.toggleSecondPass,
                                    suffix: cubit.isConfirmPasswordShow
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                SizedBox(
                                  height: height * .015,
                                ),

                                // defaultFormField(
                                //     context: context,
                                //     controller: phoneController,
                                //     type: TextInputType.phone,
                                //     validate: (val) {
                                //       if (val == null || val.isEmpty) {
                                //         return "Must not be empty";
                                //       } else if (val.length < 11) {
                                //         return "الرقم اللذي ادخلته غير صحيح";
                                //       }
                                //
                                //       return null;
                                //     },
                                //     label: "رقم الهاتف",
                                //     prefix: Icons.phone),
                                // SizedBox(
                                //   height: height*.015,
                                // ),
                                // DropdownButtonFormField2(
                                //   decoration: InputDecoration(
                                //     //Add isDense true and zero Padding.
                                //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                //     isDense: true,
                                //     contentPadding: EdgeInsets.zero,
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(width*.025),
                                //     ),
                                //     //Add more decoration as you want here
                                //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                //   ),
                                //   isExpanded: true,
                                //   hint:  Text(
                                //     'أختر الدولة',
                                //     style: TextStyle(fontSize: width*0.045),
                                //   ),
                                //   icon: const Icon(
                                //     Icons.arrow_drop_down,
                                //     color: Colors.black45,
                                //   ),
                                //   iconSize: width*0.07,
                                //   buttonHeight: height*0.07,
                                //   buttonPadding:
                                //   EdgeInsets.only(left: width*.045, right: width*.045),
                                //   dropdownDecoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(width*.025),
                                //   ),
                                //   items: itemsCountry
                                //       .map((item) => DropdownMenuItem<String>(
                                //     value: item,
                                //     child: Text(
                                //       item,
                                //       style:  TextStyle(
                                //         fontSize: width*.045,
                                //       ),
                                //     ),
                                //   ))
                                //       .toList(),
                                //   validator: (value) {
                                //     if (value == null) {
                                //       return 'لابد من أختيار دولة';
                                //     }
                                //   },
                                //   onChanged: (value) {
                                //     setState(() {
                                //       dropValCountry = value as String;
                                //     });
                                //   },
                                //   onSaved: (value) {
                                //     dropValCountry = value.toString();
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  state: cubit.currentStep > 1
                      ? StepState.complete
                      : StepState.indexed,
                  isActive: cubit.currentStep >= 1,
                  title: Text(
                    "About You",
                    style: TextStyle(fontSize: width * .045),
                  ),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Form(
                      key: formKey2,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * .025),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Academic year',
                                style: TextStyle(fontSize: width * .045),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: width * .07,
                              buttonHeight: height * 0.07,
                              buttonPadding: EdgeInsets.only(
                                  left: width * .045, right: width * .045),
                              dropdownDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(width * .025),
                              ),
                              items: itemsAcademic
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: width * .045,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Must Select One Item';
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  dropValAcademicYear = value as String;
                                });
                              },
                              onSaved: (value) {
                                dropValAcademicYear = value.toString();
                              },
                            ),
                            SizedBox(height: height * .03),
                            dropValAcademicYear == "Third Year" ||
                                    dropValAcademicYear == "Fourth Year"
                                ? DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(width * .025),
                                      ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      'Department',
                                      style: TextStyle(fontSize: width * .045),
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: width * .07,
                                    buttonHeight: height * 0.07,
                                    buttonPadding: EdgeInsets.only(
                                        left: width * .045,
                                        right: width * .045),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * .025),
                                    ),
                                    items: itemsDepartment
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: width * .045,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Must Select One Item';
                                      }
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        dropValDepartment = value as String;
                                      });
                                    },
                                    onSaved: (value) {
                                      dropValDepartment = value.toString();
                                    },
                                  )
                                : const SizedBox(),
                            dropValAcademicYear == "Third Year" ||
                                    dropValAcademicYear == "Fourth Year"
                                ? SizedBox(height: height * .03)
                                : const SizedBox(),
                            Text(
                              "Select Your Doctors",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(height: height * .015),
                           cubit.getNotecheckList(),

                            // 00000000000000000000000000
                            // DropdownButtonFormField2(
                            //   decoration: InputDecoration(
                            //     //Add isDense true and zero Padding.
                            //
                            //
                            //
                            //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            //     isDense: true,
                            //     contentPadding: EdgeInsets.zero,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(width*.025),
                            //     ),
                            //     //Add more decoration as you want here
                            //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            //   ),
                            //   isExpanded: true,
                            //   hint:  Text(
                            //     'أختر المستوى التعليمى',
                            //     style: TextStyle(fontSize: width*.045),
                            //   ),
                            //   icon: const Icon(
                            //     Icons.arrow_drop_down,
                            //     color: Colors.black45,
                            //   ),
                            //   iconSize: width*.07,
                            //   buttonHeight: height*0.07,
                            //   buttonPadding:
                            //   EdgeInsets.only(left: width*.045, right: width*.045),
                            //   dropdownDecoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(width*.025),
                            //   ),
                            //   items: itemsEducation
                            //       .map((item) => DropdownMenuItem<String>(
                            //     value: item,
                            //     child: Text(
                            //       item,
                            //       style:  TextStyle(
                            //         fontSize: width*.045,
                            //       ),
                            //     ),
                            //   ))
                            //       .toList(),
                            //   validator: (value) {
                            //     if (value == null) {
                            //       return 'لابد من أختيار عنصر';
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     setState(() {
                            //       dropValEducation = value as String;
                            //     });
                            //   },
                            //   onSaved: (value) {
                            //     dropValEducation = value.toString();
                            //   },
                            // ),
                            // SizedBox(height: height*.03),
                            // DropdownButtonFormField2(
                            //   decoration: InputDecoration(
                            //     //Add isDense true and zero Padding.
                            //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            //     isDense: true,
                            //     contentPadding: EdgeInsets.zero,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(width*.025),
                            //     ),
                            //     //Add more decoration as you want here
                            //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            //   ),
                            //   isExpanded: true,
                            //   hint:  Text(
                            //     'أختر العمل',
                            //     style: TextStyle(fontSize: width*.045),
                            //   ),
                            //   icon: const Icon(
                            //     Icons.arrow_drop_down,
                            //     color: Colors.black45,
                            //   ),
                            //   iconSize: width*.07,
                            //   buttonHeight: height*0.07,
                            //   buttonPadding:
                            //   EdgeInsets.only(left: width*.045, right: width*.045),
                            //   dropdownDecoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(width*.025),
                            //   ),
                            //   items: itemsWork
                            //       .map((item) => DropdownMenuItem<String>(
                            //     value: item,
                            //     child: Text(
                            //       item,
                            //       style:  TextStyle(
                            //         fontSize: width*.045,
                            //       ),
                            //     ),
                            //   ))
                            //       .toList(),
                            //   validator: (value) {
                            //     if (value == null) {
                            //       return 'لابد من أختيار عنصر';
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     setState(() {
                            //       dropValWork = value as String;
                            //     });
                            //   },
                            //   onSaved: (value) {
                            //     dropValWork = value.toString();
                            //   },
                            // ),
                            // SizedBox(height: height*.03),
                            // DropdownButtonFormField2(
                            //   decoration: InputDecoration(
                            //     //Add isDense true and zero Padding.
                            //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            //     isDense: true,
                            //     contentPadding: EdgeInsets.zero,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(width*.025),
                            //     ),
                            //     //Add more decoration as you want here
                            //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            //   ),
                            //   isExpanded: true,
                            //   hint:  Text(
                            //     'أختر مكان المعيشة',
                            //     style: TextStyle(fontSize: width*.045),
                            //   ),
                            //   icon: const Icon(
                            //     Icons.arrow_drop_down,
                            //     color: Colors.black45,
                            //   ),
                            //   iconSize: width*.07,
                            //   buttonHeight: height*0.07,
                            //   buttonPadding:
                            //   EdgeInsets.only(left: width*.045, right: width*.045),
                            //   dropdownDecoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(width*.025),
                            //   ),
                            //   items: itemsLives
                            //       .map((item) => DropdownMenuItem<String>(
                            //     value: item,
                            //     child: Text(
                            //       item,
                            //       style:  TextStyle(
                            //         fontSize: width*.045,
                            //       ),
                            //     ),
                            //   ))
                            //       .toList(),
                            //   validator: (value) {
                            //     if (value == null) {
                            //       return 'لابد من أختيار عنصر';
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     setState(() {
                            //       dropValLives = value as String;
                            //     });
                            //   },
                            //   onSaved: (value) {
                            //     dropValLives = value.toString();
                            //   },
                            // ),
                            // SizedBox(height: height*.03),
                            // DropdownButtonFormField2(
                            //   decoration: InputDecoration(
                            //     //Add isDense true and zero Padding.
                            //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            //     isDense: true,
                            //     contentPadding: EdgeInsets.zero,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(width*.025),
                            //     ),
                            //     //Add more decoration as you want here
                            //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            //   ),
                            //   isExpanded: true,
                            //   hint:  Text(
                            //     'أختر مكان السكن',
                            //     style: TextStyle(fontSize: width*.045),
                            //   ),
                            //   icon: const Icon(
                            //     Icons.arrow_drop_down,
                            //     color: Colors.black45,
                            //   ),
                            //   iconSize: width*.07,
                            //   buttonHeight: height*0.07,
                            //   buttonPadding:
                            //   EdgeInsets.only(left: width*.045, right: width*.045),
                            //   dropdownDecoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(width*.025),
                            //   ),
                            //   items: itemsHome
                            //       .map((item) => DropdownMenuItem<String>(
                            //     value: item,
                            //     child: Text(
                            //       item,
                            //       style:  TextStyle(
                            //         fontSize: width*.045,
                            //       ),
                            //     ),
                            //   ))
                            //       .toList(),
                            //   validator: (value) {
                            //     if (value == null) {
                            //       return 'لابد من أختيار عنصر';
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     setState(() {
                            //       dropValHome = value as String;
                            //     });
                            //   },
                            //   onSaved: (value) {
                            //     dropValHome = value.toString();
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ];

          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: SafeArea(
                child: state is RegisterLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stepper(
                        physics: const ClampingScrollPhysics(),
                        type: StepperType.horizontal,
                        steps: getSteps(),
                        currentStep: cubit.currentStep,
                        onStepTapped: (step) {
                          if (cubit.currentStep == 0 &&
                              step > cubit.currentStep) {
                            if (formKey.currentState!.validate()) {
                              cubit.onStepTap(step);
                            }
                          } else if (cubit.currentStep == 1 &&
                              step < cubit.currentStep) {
                            cubit.onStepTap(step);
                          }
                        },
                        onStepContinue: () {
                          if (cubit.currentStep == 0) {
                            if (formKey.currentState!.validate()) {
                              cubit.onStepContinue();
                            }
                          } else if (cubit.currentStep == 1) {
                            // if (formKey2.currentState!.validate()) {
                            //   if(hasInternet){
                            //     cubit.signUp(
                            //       context,
                            //       email: emailController.text,
                            //       age:dropValAge!,
                            //       name: nameController.text,
                            //       phone: phoneController.text,
                            //       userName: userNameController.text,
                            //       liveIn: dropValLives!,
                            //       live: dropValHome!,
                            //       education: dropValEducation!,
                            //       country: dropValCountry!,
                            //       gender: dropValGender!,
                            //       work: dropValWork!,
                            //       password: passwordController.text,
                            //     );
                            //   }else{
                            //     Fluttertoast.showToast(
                            //       msg: "No Internet Connection",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.BOTTOM,
                            //       backgroundColor: Colors.transparent,
                            //       textColor: const Color(0xff1bbd9d),
                            //     );
                            //   }
                            //
                            // }
                          }
                        },
                        onStepCancel: () {
                          if (cubit.currentStep == 0) {
                            return;
                          } else {
                            cubit.onStepCancel();
                          }
                        },
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return Container(
                            // margin: EdgeInsets.only(top: height*.01),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (cubit.currentStep != 0)
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                            width: width / 2,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * .12),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(.7),
                                                  blurRadius: 1,
                                                  offset: const Offset(1, 2),
                                                ),
                                              ],
                                            ),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              onPressed: details.onStepCancel,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height * .015),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: height * .04,
                                                      width: width * .1,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(12.0),
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        size: width * .045,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * .05,
                                                    ),
                                                    Text(
                                                      'Previous',
                                                      style: TextStyle(
                                                        fontSize: width * .04,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      width: cubit.currentStep != 0
                                          ? width * .025
                                          : 0,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          width: width / 2,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                width * .12),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(.7),
                                                blurRadius: 1,
                                                offset: const Offset(1, 2),
                                              ),
                                            ],
                                          ),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            onPressed: details.onStepContinue,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: height * .015),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    cubit.currentStep != 0 ? 'Sign Up':'Next',
                                                    style: TextStyle(
                                                      fontSize: width * .04,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * .05,
                                                  ),
                                                  Container(
                                                    height: height * .04,
                                                    width: width * .1,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Icon(
                                                      cubit.currentStep != 0? Icons.workspaces:Icons.arrow_forward_ios,
                                                      size: width * .045,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .015,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already Have an Account?",
                                      style: TextStyle(
                                        fontSize: width * .045,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .02,
                                    ),
                                    InkWell(
                                      child: Text(
                                        'LogIn',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * .045,
                                            fontWeight: FontWeight.bold),
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
                          );
                        },
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
