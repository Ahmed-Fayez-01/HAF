import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constant.dart';

Widget promoCard(
    {context,
      required image,
      required double border,
      required String title,
      required String description,
      required String price}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(border),
    ),
    child: Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: border/2),
          child: Container(
            width: border*3,
            height: border*2.5,
            // margin:  EdgeInsets.only(right: border),
            decoration: BoxDecoration(
              image: DecorationImage(
                // fit: BoxFit.fill,
                image: AssetImage(image),
              ),
            ),
            // child: Container(
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       gradient: LinearGradient(
            //           begin: Alignment.bottomRight,
            //           stops: const [0.2,.9],
            //           colors: [
            //             Colors.black.withOpacity(.7),
            //             Colors.black.withOpacity(.1),
            //           ]
            //       )
            //   ),
            //
            // ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:  EdgeInsets.all(border/2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                        TextStyle(fontSize: border*.6, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: border/3,
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],

                ),
                SizedBox(
                  height: border/3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {

                      },
                      icon: Image.asset("assets/images/search.png",width: border,),
                    ),
                    IconButton(
                      onPressed: () {
                      },
                      icon: Image.asset("assets/images/file.png",width: border,),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
Future<bool?> toast({
  required String text,
})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String? Function(String? val)? validate,
  required String label,
  final void Function()? ontap,
  required IconData prefix,
  IconData? suffix,
  String? suffixText,
  final void Function()? suffixPressed, required BuildContext context,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      obscureText: isPassword,
      onTap: ontap,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixText: suffixText,
          suffixStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffix),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

Widget defaultButton({
  required width,
  required height,
  required String text,
  required void Function()? onTap,
})=>Center(
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
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height *
            .015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
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
);

Widget buildCategory(int index,double border) {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: border/2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? kTextColor : kTextLightColor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: border / 4), //top padding 5
          height: 2,
          width: border/2,
          color: selectedIndex == index ?  Colors.black.withOpacity(.7) : Colors.transparent,
        )
      ],
    ),
  );
}