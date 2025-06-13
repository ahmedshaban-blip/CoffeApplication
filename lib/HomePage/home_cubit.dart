// home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';
import '../../models/coffee_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(coffees: CoffeeModel.sampleData));

  void changeCategory(CoffeeCategory category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void togglePromoVisibility() {
    emit(state.copyWith(isPromoVisible: !state.isPromoVisible));
  }

  void searchCoffee(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void addToCart(CoffeeModel coffee) {
    // snackbar logic handled in view
  }
}
