import 'package:flutter/material.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:yathaarth/app.dart';
import 'package:yathaarth/middlewares/auth_middleware.dart';
import 'package:yathaarth/models/app_state.dart';
import 'package:yathaarth/models/auth_state.dart';
import 'package:yathaarth/models/user.dart';
import 'package:yathaarth/reducers/app_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() async {
  // Create Persistor
  final persistor = Persistor<AppState>(
    // storage: FileStorage(File("state.json")),
    storage: FlutterStorage(location: FlutterSaveLocation.documentFile),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  AppState initialState;
  try {
    initialState = await persistor.load();
    initialState = initialState.copyWith(isLoading: false);
    if (!initialState.authState.isAuthenticated) {
      initialState = initialState.copyWith(
        authState: initialState.authState.copyWith(
          isNewUser: false,
          user: User()
        )
      );
    }
  }
  catch (e) {
    initialState = AppState(
      isLoading: false,
      authState: AuthState(
        isNewUser: false,
        isAuthenticated: false
      )
    );
  }

  //create store
  final store = Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: []
      ..add(persistor.createMiddleware())
      ..add(thunkMiddleware)
      ..addAll(createAuthMiddleware())
      ..add(LoggingMiddleware.printer())
  );

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(

  //   )
  // );

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  return runApp(AppRoot(store: store));
}