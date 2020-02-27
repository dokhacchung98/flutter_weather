import 'package:flutter/foundation.dart';

class ConvertWindDirection {
  static String Convert({@required double direction}) {
    if( direction >= 11.25 && direction <= 78.75) {
      return "↙";
    } else if( direction >= 78.75 && direction < 101.25) {
      return "←";
    } else if( direction >= 101.25 && direction < 146.25) {
      return "↖";
    } else if( direction >= 146.25 && direction < 191.25) {
      return "↓";
    } else if( direction >= 191.25 && direction < 236.25) {
      return "↗";
    } else if( direction >= 236.25 && direction < 281.25) {
      return "→";
    } else if( direction >= 281.25 && direction < 326.25) {
      return "↘";
    } else {
      return "↑";
    }
  }
}