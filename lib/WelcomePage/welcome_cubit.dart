// welcome_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());

  void getStarted() async {
    emit(WelcomeLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(WelcomeSuccess());
  }
}
