class AppStates {}

class AppInitialState extends AppStates {}

class changeBottomNavPageState extends AppStates {}

class AppLoadingHomeState extends AppStates {}

class AppSuccessHomeState extends AppStates {}

class AppErrorHomeState extends AppStates {}

class AppSuccessCategoriesState extends AppStates {}

class AppErrorCategoriesState extends AppStates {}

class AppAddSuccessFavoritesState extends AppStates {
  final message;

  AppAddSuccessFavoritesState(this.message);
}

class AppAddErrorFavoritesState extends AppStates {}

class AppSuccessFavoritesListState extends AppStates {}

class AppErrorFavoritesListState extends AppStates {}

class AppSuccessProfileState extends AppStates {}

class AppErrorProfileState extends AppStates {}

class AppSuccessUpdateState extends AppStates {
  final data;

  AppSuccessUpdateState(this.data);
}

class AppLoadingUpdateState extends AppStates {}

class AppErrorUpdateState extends AppStates {}

class AppChangeEnabledState extends AppStates {}

