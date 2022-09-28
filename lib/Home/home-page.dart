

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componants/componants.dart';
import '../componants/constant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener:(context, state) {} ,
        builder:(context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            drawer: const SafeArea(child: Drawer()),
            backgroundColor:  const Color.fromRGBO(244, 243, 243, 1),
            appBar: AppBar(
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 0,
              leading: IconButton(onPressed: (){
                scaffoldKey.currentState!.openDrawer();
              }, icon:  Icon(Icons.menu ,color:Colors.black.withOpacity(.7))),
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none),color: Colors.black.withOpacity(.7)),
              ],
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding:  EdgeInsets.all(width*.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                         Text("Find Your",style: TextStyle(fontSize: width*.05,color: Colors.black87),),
                        SizedBox(
                          height: height*.005,
                        ),
                        Text("Subject Material",style: TextStyle(fontSize: width*.07,color: Colors.black87,fontWeight: FontWeight.bold),),
                        SizedBox(
                          height:  height*.02,
                        ),
                        Container(
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(244, 243, 243, 1),
                            borderRadius: BorderRadius.circular( width*.05,),
                          ),
                          child:  TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: const Icon(Icons.search,color: Colors.black87,),
                                hintText: "Search you're looking for",
                                hintStyle: TextStyle(color: Colors.grey,fontSize: width*.04)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: width*.05),
                      child: SizedBox(
                        height:  height*.03,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap:(){
                                cubit.changeIndex(index);
                              },child: buildCategory(index,width*.07)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*.03,
                  ),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width*.04,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Suggested Material ",style: TextStyle(fontSize: width*.04,fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: height*.02,
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                promoCard(image: 'assets/images/data.png',title: "Data Communication",description: "Section about the topology and types of configuration.",price: "350 L.E",border: width*.08),
                                 SizedBox(height: height*.015,),
                                promoCard(image: 'assets/images/wifi.png',title: "Wireless and Mobile Computing",description: "Best chair design with good quality and good price.",price: "2500 L.E",border: width*.08),
                                SizedBox(height: height*.015,),
                                promoCard(image: 'assets/images/structure.png',title: "Data Structure",description: "Best chair design with good quality and good price.",price: "1200 L.E",border: width*.08),
                                SizedBox(height: height*.015,),
                                promoCard(image: 'assets/images/databases.png',title: "Advanced Database",description: "Best chair design with good quality and good price.",price: "1250 L.E",border: width*.08),

                              ],
                            ),
                          ),
                          SizedBox(
                            height:  height*.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } ,
      ),
    );
  }
}
