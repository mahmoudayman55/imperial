bool isUkPhoneNumber(String input) {
  RegExp regex = RegExp(r'^(\+44|0)[1-9][0-9]{8,9}$');
  return regex.hasMatch(input);
}