import 'package:intl/intl.dart';

String formatTanggal(String dateString) {
  DateTime date = DateTime.parse(dateString);
  var formatter = DateFormat.yMMMMd('id_ID');
  String formattedDate = formatter.format(date);
  return formattedDate;
}
