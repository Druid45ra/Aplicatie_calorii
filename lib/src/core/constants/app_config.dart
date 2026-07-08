/// Application configuration constants for performance tuning and environment settings
abstract class AppConfig {
  // API Configuration
  static const String apiBaseUrl = 'https://api.example.com';
  static const Duration apiConnectTimeout = Duration(seconds: 15);
  static const Duration apiReceiveTimeout = Duration(seconds: 15);

  // Performance tuning
  /// Maximum number of meals to load in memory at once
  static const int mealsPaginationLimit = 100;
  
  /// Debounce duration for search and filters (ms)
  static const Duration searchDebounce = Duration(milliseconds: 300);
  
  /// Cache invalidation duration for meal lists
  static const Duration mealsCacheDuration = Duration(minutes: 5);
  
  /// Chart data refresh interval
  static const Duration chartRefreshInterval = Duration(seconds: 2);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Validation Rules
  static const int minCaloriesPerMeal = 0;
  static const int maxCaloriesPerMeal = 10000;
  static const int minMacroNutrient = 0;
  static const int maxProtein = 500;
  static const int maxCarbs = 1000;
  static const int maxFat = 500;

  // Meal Types
  static const List<String> mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
}
