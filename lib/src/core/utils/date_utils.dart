import 'package:intl/intl.dart';

class AppDateUtils {
<<<<<<< ours
<<<<<<< ours
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
=======
=======
>>>>>>> theirs
  static String formatDate(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  static DateTime normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
}
