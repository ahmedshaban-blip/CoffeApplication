import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class OrderState extends Equatable {
  final bool isDelivery;
  final int quantity;
  final bool isLoading;
  final String paymentMethod;
  final String? selectedAddress;
  final LatLng? selectedPosition;

  const OrderState({
    this.isDelivery = true,
    this.quantity = 1,
    this.isLoading = false,
    this.paymentMethod = 'Credit Card',
    this.selectedAddress,
    this.selectedPosition,
  });

  OrderState copyWith({
    bool? isDelivery,
    int? quantity,
    bool? isLoading,
    String? paymentMethod,
    String? selectedAddress,
    LatLng? selectedPosition,
  }) {
    return OrderState(
      isDelivery: isDelivery ?? this.isDelivery,
      quantity: quantity ?? this.quantity,
      isLoading: isLoading ?? this.isLoading,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPosition: selectedPosition ?? this.selectedPosition,
    );
  }

  @override
  List<Object?> get props => [
    isDelivery,
    quantity,
    isLoading,
    paymentMethod,
    selectedAddress,
    selectedPosition,
  ];
}
