class Helpers {

  static String getFormattedDateTime() {
    final DateTime now = DateTime.now();
    String twoDigit(int value) {
      return value.toString().padLeft(2, '0');
    }
    return '${now.year}_${twoDigit(now.month)}_${twoDigit(now.day)}_${twoDigit(now.hour)}_${twoDigit(now.minute)}_${twoDigit(now.second)}';
  }


}