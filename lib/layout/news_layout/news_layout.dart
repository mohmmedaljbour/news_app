 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/serach/serach_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (BuildContext context) =>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context , state)
        {
          var cubit = NewsCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'News App',
                ),
                actions: [
                  IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      NewsCubit.get(context).changeAppMode();
                      print('ksfgklshflgh');
                    },
                    icon: Icon(
                      Icons.brightness_4_outlined,
                    ),
                  ),
                ],

              ),
              body: cubit.screen[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeBottomNavBar(index);

                },
                items: cubit.bottomItems,
              )
          );
        },
      ),
    );
  }
}
