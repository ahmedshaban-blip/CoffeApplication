// home_state.dart
import 'package:equatable/equatable.dart';
import '../../models/coffee_model.dart';

class HomeState extends Equatable {
  final List<CoffeeModel> coffees;
  final CoffeeCategory selectedCategory;
  final String searchQuery;
  final bool isPromoVisible;
  final bool isLoading;

  const HomeState({
    required this.coffees,
    this.selectedCategory = CoffeeCategory.all,
    this.searchQuery = '',
    this.isPromoVisible = true,
    this.isLoading = false,
  });

  HomeState copyWith({
    List<CoffeeModel>? coffees,
    CoffeeCategory? selectedCategory,
    String? searchQuery,
    bool? isPromoVisible,
    bool? isLoading,
  }) {
    return HomeState(
      coffees: coffees ?? this.coffees,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isPromoVisible: isPromoVisible ?? this.isPromoVisible,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
    coffees,
    selectedCategory,
    searchQuery,
    isPromoVisible,
    isLoading,
  ];
}
