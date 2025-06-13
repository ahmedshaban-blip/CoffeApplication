// coffee_model.dart
enum CoffeeCategory { all, machiato, latte, americano }

class CoffeeModel {
  final String name;
  final String image;
  final double price;
  final double rating;
  final CoffeeCategory category;

  CoffeeModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.category,
  });

  static List<CoffeeModel> sampleData = [
    CoffeeModel(
      name: 'Cappuccino',
      image: 'assets/images/cappuccino.jpg',
      price: 4.99,
      rating: 4.7,
      category: CoffeeCategory.latte,
    ),
    CoffeeModel(
      name: 'Macchiato',
      image: 'assets/images/macchiato.jpg',
      price: 3.99,
      rating: 4.3,
      category: CoffeeCategory.machiato,
    ),
    CoffeeModel(
      name: 'Americano',
      image: 'assets/images/americano.jpg',
      price: 2.99,
      rating: 4.5,
      category: CoffeeCategory.americano,
    ),
    CoffeeModel(
      name: 'Caramel Latte',
      image: 'assets/images/latte.jpg',
      price: 5.29,
      rating: 4.8,
      category: CoffeeCategory.latte,
    ),
    CoffeeModel(
      name: 'Vanilla Macchiato',
      image: 'assets/images/macchiato2.jpg',
      price: 4.79,
      rating: 4.4,
      category: CoffeeCategory.machiato,
    ),
    CoffeeModel(
      name: 'Iced Americano',
      image: 'assets/images/americano2.jpg',
      price: 3.29,
      rating: 4.2,
      category: CoffeeCategory.americano,
    ),
  ];

  static List<CoffeeModel> filterBy(
    List<CoffeeModel> list,
    CoffeeCategory category,
    String searchQuery,
  ) {
    return list.where((coffee) {
      final matchCategory =
          category == CoffeeCategory.all || coffee.category == category;
      final matchSearch = coffee.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchCategory && matchSearch;
    }).toList();
  }
}
