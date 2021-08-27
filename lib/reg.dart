bool passwordCheck(String password) {
  var reg = RegExp(r'^(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,15}$');
  return reg.hasMatch(password);
}
