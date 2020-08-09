import 'package:socioGram/helpers/auth_method_helper.dart';

class ThisUserHelper {
  static String _userName;
  static String _userPassword;
  static String _userEmail;
  static String _userBio;
  static String _userid;
  static String _userPhoneNumber;
  static String _userImage;
  static DateTime _userProfileLastUpdated;

  static void getUserData(Map<String, dynamic> data) {
    _userName = data["userName"];
    _userImage = data["image"];
    _userBio = data["bio"];
    _userEmail = data["email"];
    _userPhoneNumber = data["phoneNumber"];
    print(data["timeStamp"].runtimeType);
    // _userProfileLastUpdated = data["timeStamp"];
  }

  static String get globalUserName {
    return _userName;
  }

  static String get globalUserImage {
    return _userImage;
  }

  static String get globalUserBio {
    return _userBio;
  }

  static String get globalUserPassword {
    return _userPassword;
  }

  static String get globalUserPhonrNumber {
    return _userPhoneNumber;
  }

  static String get globalUserEmail {
    return _userEmail;
  }

  static void setGlobalUserEmail(String userEmail) {
    _userEmail = userEmail;
  }

  static void setGlobalUserPassword(String userPassword) {
    _userPassword = userPassword;
  }

  static void setGlobalUserUserName(String userName) {
    _userName = userName;
  }

  static void initializeUserCredentials() {
    _userName = '';
    _userPassword = '';
    _userEmail = '';
  }
}
