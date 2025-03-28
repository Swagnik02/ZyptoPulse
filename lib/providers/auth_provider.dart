import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zypto_pulse/models/user_model.dart';
import 'package:zypto_pulse/services/auth_service.dart';
import 'package:zypto_pulse/services/secure_storage_service.dart';

/// **Auth State Model**
class AuthState {
  final UserModel? user;
  final bool isAuthenticated;
  final bool isLoading;
  final bool isSignIn; // Toggle Sign-in / Sign-up
  final String errorMessage;

  AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.isSignIn = true,
    this.errorMessage = '',
  });

  AuthState copyWith({
    UserModel? user,
    bool? isAuthenticated,
    bool? isLoading,
    bool? isSignIn,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      isSignIn: isSignIn ?? this.isSignIn,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// **Auth Notifier**
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  final AuthService _authService = AuthService();

  /// **Load User from Secure Storage**
  Future<void> loadUser() async {
    state = state.copyWith(isLoading: true);
    String? token = await SecureStorage.readToken();

    state = state.copyWith(isAuthenticated: token != null, isLoading: false);
  }

  /// **Toggle Sign-in / Sign-up**
  void toggleAuth() {
    state = state.copyWith(isSignIn: !state.isSignIn);
  }

  /// **Login**
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    final response = await _authService.loginUser(email, password);
    if (response.containsKey("access_token")) {
      final user = UserModel(
        email: email,
        firstName: response["first_name"] ?? "",
        token: response["access_token"],
      );
      await SecureStorage.writeToken(response["access_token"]);
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
      );
      return true;
    }

    state = state.copyWith(
      errorMessage: response["error"] ?? "Login failed",
      isLoading: false,
    );
    return false;
  }

  /// **Sign Up**
  Future<bool> signup(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    final response = await _authService.signupUser(name, email, password);
    state = state.copyWith(isLoading: false);

    if (response["success"] == true) {
      return true;
    }
    state = state.copyWith(errorMessage: response["error"] ?? "Signup failed");
    return false;
  }

  /// **Logout**
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    String? token = await SecureStorage.readToken();
    if (token != null) {
      await _authService.logoutUser(token);
    }
    await SecureStorage.deleteToken();
    state = AuthState();
  }
}

/// **Provider**
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
