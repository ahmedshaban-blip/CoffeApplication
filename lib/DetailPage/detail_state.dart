// detail_state.dart
import 'package:equatable/equatable.dart';

enum CoffeeSize { small, medium, large }

class DetailState extends Equatable {
  final bool isFavorite;
  final CoffeeSize selectedSize;
  final bool isLoading;

  const DetailState({
    this.isFavorite = false,
    this.selectedSize = CoffeeSize.medium,
    this.isLoading = false,
  });

  DetailState copyWith({
    bool? isFavorite,
    CoffeeSize? selectedSize,
    bool? isLoading,
  }) {
    return DetailState(
      isFavorite: isFavorite ?? this.isFavorite,
      selectedSize: selectedSize ?? this.selectedSize,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [isFavorite, selectedSize, isLoading];
}
