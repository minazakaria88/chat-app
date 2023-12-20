abstract class AppState{}

class AppInitState extends AppState{}

class AppGetDataSuccessState extends AppState{}


class AppGetDataErrorState extends AppState{
  String ? error;
  AppGetDataErrorState(this.error);
}


class AppGetMessageSuccessState extends AppState{}

class AppSendMessageSuccessState extends AppState{}