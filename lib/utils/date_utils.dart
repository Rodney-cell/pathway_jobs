class DateUtilsHelper {
  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static String formatTime(DateTime date) {
    return "${date.hour}:${date.minute}";
  }
}