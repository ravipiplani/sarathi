import 'package:json_annotation/json_annotation.dart';
import 'package:login_boilerplate/models/auth_state.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  final bool isLoading;
  final AuthState authState;

  AppState({
    this.isLoading,
    this.authState
  });

  AppState copyWith({bool isLoading, bool isNewUser, AuthState authState}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      authState: authState ?? this.authState
    );
  }

  static AppState fromJson(dynamic json) => _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, authState: $authState}';
  }
}