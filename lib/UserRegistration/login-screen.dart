import 'package:admin/Home/home-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isDisabled = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
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
          SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Text(
                'Enter your credentials to continue',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset(
                        'assets/images/facebook.png', width: 32),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset(
                          'assets/images/google.png', width: 32),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text('OR'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  focusColor: Colors.black,
                  fillColor: Colors.black,
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Email',
                ),
                controller: _emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                    prefixIcon: Icon(Icons.lock_outlined),
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.remove_red_eye)),
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: .9,
                        child: CupertinoSwitch(
                          trackColor: Colors.grey,
                          activeColor: Colors.black,
                          value: isDisabled,
                          onChanged: (value) {
                            setState(() {
                              isDisabled = value;
                            });
                          },
                        ),
                      ),
                      const Text("Remember Me", style: TextStyle(
                          color: Colors.grey
                      ),),
                    ],
                  ),
                  const Spacer(),
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
                    borderRadius: BorderRadius.circular(width * .12),
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
                              builder: (context) =>  HomePage()),
                              (route) => false);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height *
                          .015),
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
                              borderRadius: BorderRadius.circular(12.0),
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
                children: [
                  const Text(
                    "Don't Have An Account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Signup",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],
        ),
        ),
      ),)
    ,
    );
  }
}
