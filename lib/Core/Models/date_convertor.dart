// import 'package:shamsi_date/shamsi_date.dart';

class DateConvertor {
  static String dateFormatter(String date) {
    String result = '';
    try {
      DateTime dateValue = DateTime.parse(date);
      result =
          '${dateValue.year}-${dateValue.month}-${dateValue.day}, ${dateValue.hour}:${dateValue.minute}';
    } catch (_) {}
    return result;
  }

  static String dateFromNow(String date) {
    // Jiffy(date, "yyyy/MM/dd h:mm:ss").fromNow();
    // return Jiffy(date).fromNow();
    String result = '';
    date = date.replaceAll('/', '-');
    try {
      DateTime dateValue = DateTime.parse(date);
      result =
          '${dateValue.year}/${dateValue.month}/${dateValue.day}, ${dateValue.hour}:${dateValue.minute}';
    } catch (_) {}
    return result;
  }
  // static dateToJalali(
  //   String date,
  // ) {
  //   int year = int.parse(date.split('/')[0]);
  //   int month = int.parse(date.split('/')[1]);
  //   int day = int.parse(date.split('/')[2]);
  //   DateTime dat = DateTime(year, month, day);
  //   Jalali g = Jalali.fromDateTime(dat);
  //   print(g.month);

  //   return g.year.toString() +
  //       '/' +
  //       g.month.toString() +
  //       '/' +
  //       g.day.toString();
  // }

  // static int compareDateFromNow(String date) {
  //   DateTime dat = DateTime.parse(date);
  //   DateTime curDat = dat.toLocal();
  //   return curDat.compareTo(DateTime.now());
  // }
}
