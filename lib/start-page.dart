import 'package:flutter/material.dart';

import 'UserRegistration/login-screen.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * .1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Learning",
                style: TextStyle(
                    fontSize: width * .08,
                    fontWeight: FontWeight.bold,
                   ),
              ),
              Text(
                "Makes",
                style: TextStyle(
                    fontSize: width * .08,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              Text(
                "Me Happy",
                style: TextStyle(
                    fontSize: width * .08,
                    fontWeight: FontWeight.bold,
                    ),
              ),
              Expanded(
                  child: Center(
                      child: Image.asset(
                "assets/images/splash1.gif",
                width: width * .75,
              ))),
              Center(
                child: Container(
                  width: width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * .12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(.7),
                        blurRadius: 5,
                        offset: const Offset(.2, 1),
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
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
