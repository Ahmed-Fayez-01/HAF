import 'dart:async';

import 'package:admin/UserRegistration/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../componants/constant.dart';
import 'cuibt.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool load = false;
  List<String> itemsGender = [
    'ذكر',
    'أنثى',
  ];
  List<String> itemsCountry = [
    'مصر',
    'المملكة العربيه السعودية',
    'المملكة العربيه المتحدة',
    "سلطنة عمان",
    'الجزائر',
    'تونس',
    'العراق',
    "البحرين",
    'جيبوتي',
    'الصومال',
    'السودان',
    "ليبيا"
  ];
  List<String> itemsAge = ['18-19', '20-29', "30-39", "40-49", 'أكبر من 50'];
  List<String> itemsEducation = [
    'شهادة الثانوية او أدني',
    'الباكالوريوس',
    "الماجستير",
    "الدكتوراة"
  ];
  List<String> itemsWork = [
    'طالب',
    'موظف حكومى او قطاع خاص',
    "لا أعمل",
    "أخري"
  ];
  List<String> itemsLives = [
    'مدينة',
    'قريب من الشاطئ أو البحر',
    "منطقة زراعية",
    "منطقة جبلية"
  ];
  List<String> itemsHome = ['بيت شعبي', 'شقة', "فيلا", "أخري"];
  String? dropValGender;
  String? dropValAge;
  String? dropValEducation;
  String? dropValWork;
  String? dropValLives;
  String? dropValHome;
  String? dropValCountry;
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var userNameController = TextEditingController();
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
              padding:  EdgeInsets.all(width*.03),
              content: const Text('Email Verification Sent'),
              action: SnackBarAction(
                label: 'Go',
                onPressed: () async {
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            // userId=FirebaseAuth.instance.currentUser!.uid;

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const VerifyPage()));
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
              title:  Text("البيانات الاساسية",style:TextStyle(
                  fontSize: width*.045
              )),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultFormField(
                                context: context,
                                controller: userNameController,
                                type: TextInputType.text,
                                validate: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "الحقل فارغ";
                                  }
                                  return null;
                                },
                                label: "أسم المستخدم",
                                prefix: Icons.person_outline),
                            SizedBox(
                              height: height*.03,
                            ),
                            defaultFormField(
                                context: context,
                                controller: nameController,
                                type: TextInputType.text,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "الحقل فارغ";
                                  }
                                  return null;
                                },
                                label: "أسمك بالكامل",
                                prefix: Icons.person_outlined),
                            SizedBox(
                              height: height*.03,
                            ),
                            defaultFormField(
                                context: context,
                                controller: passwordController,
                                isPassword: cubit.isFirstPasswordShow,
                                type: TextInputType.visiblePassword,
                                validate: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "الحقل فارغ";
                                  } else if (val.length < 8) {
                                    return "8 حروف أو أكثر";
                                  }
                                  return null;
                                },
                                label: "الرقم السرى",
                                prefix: Icons.lock_open,
                                suffixPressed: cubit.toggleFirstPass,
                                suffix: cubit.isFirstPasswordShow
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                            SizedBox(
                              height: height*.03,
                            ),
                            defaultFormField(
                                context: context,
                                controller: confirmPasswordController,
                                isPassword: cubit.isConfirmPasswordShow,
                                type: TextInputType.visiblePassword,
                                validate: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "الحقل فارغ";
                                  }
                                  if (val != passwordController.text) {
                                    return "الرقم السرى غير متطابق";
                                  }
                                  return null;
                                },
                                label: "أعاده كتابة الرقم السرى",
                                prefix: Icons.lock_open,
                                suffixPressed: cubit.toggleSecondPass,
                                suffix: cubit.isConfirmPasswordShow
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                            SizedBox(
                              height: height*.03,
                            ),
                            defaultFormField(
                                context: context,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (val) =>
                                EmailValidator.validate(val!)
                                    ? null
                                    : "أدخل الايميل بطريقه صحيحة",
                                label: "البريد الالكتروني",
                                prefix: Icons.email_outlined),
                            SizedBox(
                              height: height*.03,
                            ),
                            defaultFormField(
                                context: context,
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "الحقل فارغ";
                                  } else if (val.length < 11) {
                                    return "الرقم اللذي ادخلته غير صحيح";
                                  }

                                  return null;
                                },
                                label: "رقم الهاتف",
                                prefix: Icons.phone),
                            SizedBox(
                              height: height*.03,
                            ),
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(width*.025),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint:  Text(
                                'أختر الدولة',
                                style: TextStyle(fontSize: width*0.045),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: width*0.07,
                              buttonHeight: height*0.07,
                              buttonPadding:
                              EdgeInsets.only(left: width*.045, right: width*.045),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width*.025),
                              ),
                              items: itemsCountry
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style:  TextStyle(
                                    fontSize: width*.045,
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'لابد من أختيار دولة';
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  dropValCountry = value as String;
                                });
                              },
                              onSaved: (value) {
                                dropValCountry = value.toString();
                              },
                            ),
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
              title:  Text("عرف نفسك",style: TextStyle(
                  fontSize: width*.045
              ),),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Form(
                  key: formKey2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*.025),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint:  Text(
                            'أختر الجنس',
                            style: TextStyle(fontSize: width*.045),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: width*.07,
                          buttonHeight: height*0.07,
                          buttonPadding:
                          EdgeInsets.only(left: width*.045, right: width*.045),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*.025),
                          ),
                          items: itemsGender
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  TextStyle(
                                fontSize: width*.045,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'لابد من أختيار عنصر';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              dropValGender = value as String;
                            });
                          },
                          onSaved: (value) {
                            dropValGender = value.toString();
                          },
                        ),
                        SizedBox(height: height*.03),
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*.025),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint:  Text(
                            'أختر العمر',
                            style: TextStyle(fontSize: width*.045),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: width*.07,
                          buttonHeight: height*0.07,
                          buttonPadding:
                          EdgeInsets.only(left: width*.045, right: width*.045),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*.025),
                          ),
                          items: itemsAge
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  TextStyle(
                                fontSize: width*.045,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'لابد من أختيار عنصر';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              dropValAge = value as String;
                            });
                          },
                          onSaved: (value) {
                            dropValAge = value.toString();
                          },
                        ),
                        SizedBox(height: height*.03),
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.



                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*.025),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint:  Text(
                            'أختر المستوى التعليمى',
                            style: TextStyle(fontSize: width*.045),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: width*.07,
                          buttonHeight: height*0.07,
                          buttonPadding:
                          EdgeInsets.only(left: width*.045, right: width*.045),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*.025),
                          ),
                          items: itemsEducation
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  TextStyle(
                                fontSize: width*.045,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'لابد من أختيار عنصر';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              dropValEducation = value as String;
                            });
                          },
                          onSaved: (value) {
                            dropValEducation = value.toString();
                          },
                        ),
                        SizedBox(height: height*.03),
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*.025),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint:  Text(
                            'أختر العمل',
                            style: TextStyle(fontSize: width*.045),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: width*.07,
                          buttonHeight: height*0.07,
                          buttonPadding:
                          EdgeInsets.only(left: width*.045, right: width*.045),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*.025),
                          ),
                          items: itemsWork
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  TextStyle(
                                fontSize: width*.045,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'لابد من أختيار عنصر';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              dropValWork = value as String;
                            });
                          },
                          onSaved: (value) {
                            dropValWork = value.toString();
                          },
                        ),
                        SizedBox(height: height*.03),
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*.025),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint:  Text(
                            'أختر مكان المعيشة',
                            style: TextStyle(fontSize: width*.045),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: width*.07,
                          buttonHeight: height*0.07,
                          buttonPadding:
                          EdgeInsets.only(left: width*.045, right: width*.045),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*.025),
                          ),
                          items: itemsLives
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  TextStyle(
                                fontSize: width*.045,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'لابد من أختيار عنصر';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              dropValLives = value as String;
                            });
                          },
                          onSaved: (value) {
                            dropValLives = value.toString();
                          },
                        ),
                        SizedBox(height: height*.03),
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*.025),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint:  Text(
                            'أختر مكان السكن',
                            style: TextStyle(fontSize: width*.045),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: width*.07,
                          buttonHeight: height*0.07,
                          buttonPadding:
                          EdgeInsets.only(left: width*.045, right: width*.045),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*.025),
                          ),
                          items: itemsHome
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:  TextStyle(
                                fontSize: width*.045,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'لابد من أختيار عنصر';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              dropValHome = value as String;
                            });
                          },
                          onSaved: (value) {
                            dropValHome = value.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];

          return Directionality(
            textDirection: TextDirection.rtl,
            child: WillPopScope(
              onWillPop: ()async{
                return false;
              },
              child: Scaffold(
                body:  SafeArea(
                  child:state is RegisterLoadingState?const Center(
                    child: CircularProgressIndicator(),
                  ):
                  Stepper(
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
                        if (formKey2.currentState!.validate()) {
                          if(hasInternet){
                            cubit.signUp(
                              context,
                              email: emailController.text,
                              age:dropValAge!,
                              name: nameController.text,
                              phone: phoneController.text,
                              userName: userNameController.text,
                              liveIn: dropValLives!,
                              live: dropValHome!,
                              education: dropValEducation!,
                              country: dropValCountry!,
                              gender: dropValGender!,
                              work: dropValWork!,
                              password: passwordController.text,
                            );
                          }else{
                            Fluttertoast.showToast(
                              msg: "No Internet Connection",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.transparent,
                              textColor: const Color(0xff1bbd9d),
                            );
                          }

                        }
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
                        margin: EdgeInsets.only(top: height*.02),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                if (cubit.currentStep != 0)
                                  Expanded(
                                    child: ElevatedButton(
                                      child:  Text(
                                        'السابق',
                                        style:
                                        TextStyle(color: Colors.white,fontSize: width*.045),
                                      ),
                                      onPressed: details.onStepCancel,
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey[500],
                                        padding:  EdgeInsets.symmetric(
                                            horizontal: width*.045, vertical: width*.025),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(width*.1),
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: cubit.currentStep !=0 ?width*.025 : 0 ,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    child: const Text(
                                      'التالي',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: details.onStepContinue,
                                    style: ElevatedButton.styleFrom(
                                      textStyle:
                                      TextStyle(fontSize: width*.045),
                                      padding:  EdgeInsets.symmetric(
                                          horizontal:  width*.045, vertical: width*.025),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(width*.1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height*.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "لديك حساب بالفعل؟",
                                  style: TextStyle(
                                    fontSize: width*.045,
                                  ),
                                ),
                                SizedBox(
                                  width: width*.02,
                                ),
                                InkWell(
                                  child:  Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: Color(0xff1bbd9d),
                                      fontSize:  width*.045,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginPage()));
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
            ),
          );
        },
      ),
    );
  }
}
