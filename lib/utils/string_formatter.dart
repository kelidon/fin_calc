import 'package:decimal/decimal.dart';

class StringFormatter {


  static String beautifyOutput(String result) {
    var parts = result.split(".");
    return parts[1] == "000000"
        ? reverse(reverse(parts[0])
            .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} "))
        : [
            reverse(reverse(parts[0]).replaceAllMapped(
                RegExp(r".{3}"), (match) => "${match.group(0)} ")),
            removeEndZeros(parts[1])
          ].join('.');
  }

  static String reverse(String str) {
    return new String.fromCharCodes(str.runes.toList().reversed);
  }

  static String removeEndZeros(String last) {
    var res = "";
    var rev = reverse(last);
    bool notZeroMet = false;
    for (int i = 0; i < rev.length; i++) {
      if (rev[i] != '0' || notZeroMet) {
        notZeroMet = true;
        res += rev[i];
      }
    }
    return reverse(res);
  }
}
