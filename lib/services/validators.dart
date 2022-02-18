bool validateEmail(String value) {
  String regex =
      // r'...' - строка без обработки
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  return value.isNotEmpty && RegExp(regex).hasMatch(value);
}
//value != null &&
