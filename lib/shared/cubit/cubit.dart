import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)=> BlocProvider.of(context);
  int currentIndex =0;

  List<BottomNavigationBarItem> bottomItems =
  [
     BottomNavigationBarItem(
        icon: Icon(
          Icons.business
        ),
    label: 'Business'
    ),
     BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
    label: 'Sports'
    ),
     BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
    label: 'Science'
    ),
    /*const BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
    label: 'Settings'
    ),*/
  ];
  List<Widget> screen =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  //  SettingsScreen()
  ];
void changeBottomNavBar(int index )
{
currentIndex = index;
if (index==1) {
  getSports();
}
if (index==2) {
  getScience();
}
emit(NewsBottomNavState());
}
List<dynamic> business =[];
void getBusiness()
{
  emit(NewGetBusinessLoadingState());
  DioHelper.getData(
    url: 'v2/top-headlines',
    query: {
      'country':'us',
      'category':'business',
      'apiKey':'f4af1ac7da7f41a3a4446da298b387be'
    },
  ).then((value){
   // print(value.data['articles'][1]['description']);
    business=value.data['articles'];
    print(business[5]['title']);
    emit(NewGetBusinessSuccessState());
  }
  ).catchError((error){
    print(error.toString());
    emit(NewGetBusinessErrorState(error.toString()));
  });
}

List<dynamic> sports =[];
void getSports()
{
  emit(NewGetSportsLoadingState());
  if(sports.length==0){
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'f4af1ac7da7f41a3a4446da298b387be'
      },
    ).then((value){
      // print(value.data['articles'][1]['description']);
      sports=value.data['articles'];
      print(sports[5]['title']);
      emit(NewGetSportsSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewGetSportsErrorState(error.toString()));
    });

  }
  else {
    emit(NewGetSportsSuccessState());
  }

}
List<dynamic> science =[];
void getScience()
{
  emit(NewGetScienceLoadingState());
  if (science.length==0)
  {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'science',
        'apiKey':'f4af1ac7da7f41a3a4446da298b387be'
      },
    ).then((value){
      // print(value.data['articles'][1]['description']);
      science=value.data['articles'];
      print(science[5]['title']);
      emit(NewGetScienceSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewGetScienceErrorState(error.toString()));
    });
  }
  else  {
    emit(NewGetScienceSuccessState());
  }

}
  List<dynamic> search =[];
  void getSearch(String value)
  {
    emit(NewGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'f4af1ac7da7f41a3a4446da298b387be'
      },
    ).then((value){
      // print(value.data['articles'][1]['description']);
      search=value.data['articles'];
      print(search[5]['title']);
      emit(NewGetSearchSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewGetSearchErrorState(error.toString()));
    });

  }
bool isDark = false;
// ignore: non_constant_identifier_names
void changeAppMode( {bool? FromShared})
{
  if (FromShared != null) {
    isDark=FromShared;
  } else {
    isDark =!isDark;
  }

 CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
   print(isDark);
   emit(NewsChangeModeState());
 });


}
}