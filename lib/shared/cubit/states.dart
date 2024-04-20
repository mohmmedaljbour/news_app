abstract class NewsStates{}
class NewsInitialState extends NewsStates {}
class NewsBottomNavState extends NewsStates {}
class NewGetBusinessSuccessState extends NewsStates {}
class NewGetBusinessLoadingState extends NewsStates {}
class NewGetBusinessErrorState extends NewsStates
{
  late final String error;
  NewGetBusinessErrorState(this.error);

}class NewGetSportsSuccessState extends NewsStates {}
class NewGetSportsLoadingState extends NewsStates {}
class NewGetSportsErrorState extends NewsStates
{
  late final String error;
  NewGetSportsErrorState(this.error);

}
class NewGetScienceSuccessState extends NewsStates {}
class NewGetScienceLoadingState extends NewsStates {}
class NewGetScienceErrorState extends NewsStates
{
  late final String error;
  NewGetScienceErrorState(this.error);

}
class NewGetSearchSuccessState extends NewsStates {}
class NewGetSearchLoadingState extends NewsStates {}
class NewGetSearchErrorState extends NewsStates
{
  late final String error;
  NewGetSearchErrorState(this.error);

}
class NewsChangeModeState extends NewsStates{}