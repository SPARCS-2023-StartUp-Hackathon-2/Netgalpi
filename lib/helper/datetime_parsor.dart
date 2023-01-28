import 'package:intl/intl.dart';

String datetimeParsor(DateTime input) {
  DateTime nowTime = DateTime.now();
  input = input.toLocal();

  Duration diff = nowTime.difference(input);
  String convertedDateTime;

  if (diff.inDays >= 1) {
    convertedDateTime = DateFormat('yyyy년 MM월 dd일').format(input);
  } else if (diff.inHours >= 1) {
    convertedDateTime = '${diff.inHours}시간 전';
  } else if (diff.inMinutes >= 1) {
    convertedDateTime = '${diff.inMinutes}분 전';
  } else {
    convertedDateTime = '방금 전';
  }

  return convertedDateTime;
}
