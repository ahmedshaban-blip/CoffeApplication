import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState());

  void toggleDelivery(bool isDelivery) {
    emit(state.copyWith(isDelivery: isDelivery));
  }

  void increaseQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decreaseQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void changePaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: method));
  }

  void updateAddress(String address, LatLng position) {
    emit(state.copyWith(selectedAddress: address, selectedPosition: position));
  }

  void placeOrder() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isLoading: false));
  }
}
