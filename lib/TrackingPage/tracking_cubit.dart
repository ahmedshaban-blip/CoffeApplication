// tracking_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit() : super(const TrackingState());

  void updateDeliveryProgress() async {
    for (int i = state.timeLeftMinutes; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(timeLeftMinutes: i));
      if (i == 0) {
        emit(state.copyWith(isDelivered: true));
      }
    }
  }
}
