import 'package:yathaarth/models/app_state.dart';
import 'package:yathaarth/reducers/auth_reducer.dart';
import 'package:yathaarth/reducers/loading_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    authState: authReducer(state.authState, action)
  );
}