// tracking_state.dart
import 'package:equatable/equatable.dart';

class TrackingState extends Equatable {
  final bool isDelivered;
  final int timeLeftMinutes;

  const TrackingState({this.isDelivered = false, this.timeLeftMinutes = 10});

  TrackingState copyWith({bool? isDelivered, int? timeLeftMinutes}) {
    return TrackingState(
      isDelivered: isDelivered ?? this.isDelivered,
      timeLeftMinutes: timeLeftMinutes ?? this.timeLeftMinutes,
    );
  }

  @override
  List<Object> get props => [isDelivered, timeLeftMinutes];
}
