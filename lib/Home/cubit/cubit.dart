

import 'package:admin/Home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../componants/constant.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context)=> BlocProvider.of(context);

changeIndex(index)
{
  selectedIndex=index;
  emit(ChangeIndex());
}
}