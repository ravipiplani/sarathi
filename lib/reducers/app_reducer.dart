import 'package:login_boilerplate/models/app_state.dart';
import 'package:login_boilerplate/reducers/auth_reducer.dart';
import 'package:login_boilerplate/reducers/loading_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    authState: authReducer(state.authState, action)
  );
}