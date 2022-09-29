import 'package:admin/Home/home-page.dart';
import 'package:admin/UserRegistration/doctor_register_page.dart';
import 'package:admin/UserRegistration/user-register-pagee.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componants/componants.dart';
import 'cubit/cuibt.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isDisabled = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (state, context) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/images/splach.png",
                            width: 150,
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
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome Back!',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Enter your credentials to continue',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         border: Border.all(
                          //           color: Colors.grey.shade400,
                          //           width: 1,
                          //         ),
                          //         borderRadius: BorderRadius.circular(25),
                          //       ),
                          //       child: Image.asset(
                          //           'assets/images/facebook.png', width: 32),
                          //     ),
                          //     const SizedBox(
                          //       width: 15,
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {},
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           border: Border.all(
                          //             color: Colors.grey.shade400,
                          //             width: 1,
                          //           ),
                          //           borderRadius: BorderRadius.circular(50),
                          //         ),
                          //         child: Image.asset(
                          //             'assets/images/google.png', width: 32),
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 15,
                          //     ),
                          //     const Text('OR'),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                              context: context,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (val) => EmailValidator.validate(val!)
                                  ? null
                                  : "Please enter a valid email",
                              label: "Email",
                              prefix: Icons.email_outlined),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              context: context,
                              controller: passwordController,
                              isPassword: cubit.isFirstPasswordShow,
                              type: TextInputType.visiblePassword,
                              validate: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Must Not Be Empty";
                                } else if (val.length < 8) {
                                  return "Must Not Be Less Than 8 Char";
                                }
                                return null;
                              },
                              label: "Password",
                              prefix: Icons.lock_open,
                              suffixPressed: cubit.toggleFirstPass,
                              suffix: cubit.isFirstPasswordShow
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Forgot password',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          Center(
                            child: Container(
                              width: width / 2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(width * .12),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.7),
                                    blurRadius: 1,
                                    offset: const Offset(1, 2),
                                  ),
                                ],
                              ),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                onPressed: () async {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (route) => false);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * .015),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'LogIn',
                                        style: TextStyle(
                                          fontSize: width * .04,
                                          fontWeight: FontWeight.normal,
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
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Icon(
                                          Icons.workspaces,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Don't Have An Account? ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "SignUp as :",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()),
                                      (route) => false);
                                },
                                child: const Text(
                                  "Student",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  "or",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorRegisterScreen()),
                                      (route) => false);
                                },
                                child: const Text(
                                  "Doctor",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
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
