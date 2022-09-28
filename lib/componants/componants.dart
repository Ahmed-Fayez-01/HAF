import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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