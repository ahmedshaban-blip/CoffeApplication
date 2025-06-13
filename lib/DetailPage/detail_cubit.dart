// detail_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(const DetailState());

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void selectSize(CoffeeSize size) {
    emit(state.copyWith(selectedSize: size));
  }

  void buyNow() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isLoading: false));
    // Navigation or success logic handled in view
  }
}
