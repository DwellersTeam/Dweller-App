import 'package:get_storage/get_storage.dart';





class LocalStorage {

  /// use this to [saveTokenExpDate] to local storage
  static saveTokenExpDate(int expDate) {
    return GetStorage().write("tokenExp", expDate);
  }

  /// use this to [getTokenExpDate] from local storage
  static getTokenExpDate() {
    return GetStorage().read("tokenExp");
  }


  /// use this to [saveToken] to local storage
  static saveFCMToken(String tokenValue) {
    return GetStorage().write("FCMToken", tokenValue);
  }

  /// use this to [getToken] from local storage
  static getFCMToken() {
    return GetStorage().read("FCMToken") ?? "non";
  }

  /// use this to know if the user is a new user so you get to show onboarding screen
  static isNewUser(String value) {
    return GetStorage().write("isNewUser", value);
  }

  /// use this to know if the user is a new user so you get to show onboarding screen
  static getIsNewUser() {
    return GetStorage().read("isNewUser") ?? "no";
  }

  /// use this to [saveDwellerType] to local storage
  static saveDwellerType(String value) {
    return GetStorage().write("dweller_type", value);
  }

  /// use this to [getDwellerType] from local storage
  static getDwellerType() {
    return GetStorage().read("dweller_type") ?? "non";
  }

  /// use this to [deleteDwellerType] from local storage
  static deleteDwellerType() {
    return GetStorage().remove("dweller_type");
  }

  

  /// use this to [saveDoc] to local storage
  static saveKYCDoc(String value) {
    return GetStorage().write("KYC", value);
  }

  /// use this to [getDoc] from local storage
  static getKYCDoc() {
    return GetStorage().read("KYC") ?? "non";
  }

  /// use this to [deleteDoc] from local storage
  static deleteKYCDoc() {
    return GetStorage().remove("KYC");
  }



  /// use this to [saveToken] to local storage
  static saveToken(String tokenValue) {
    return GetStorage().write("token", tokenValue);
  }

  /// use this to [getToken] from local storage
  static getToken() {
    return GetStorage().read("token");
  }

  /// use this to [deleteToken] from local storage
  static deleteToken() {
    return GetStorage().remove("token");
  }

  /// use this to [saveToken] to local storage
  static saveXrefreshToken(String tokenValue) {
    return GetStorage().write("xtoken", tokenValue);
  }

  /// use this to [getToken] from local storage
  static getXrefreshToken() {
    return GetStorage().read("xtoken");
  }

  /// use this to [deleteToken] from local storage
  static deleteXrefreshToken() {
    return GetStorage().remove("xtoken");
  }



  /// use this to [saveUseremail] to local storage
  static saveUserEmail(String userEmail) {
    return GetStorage().write('email', userEmail);
  }
  /// use this to [getUseremail] from local storage
  static getUserEmail() {
    return GetStorage().read('email') ?? "non";
  }

  /// use this to [deleteUseremail] from local storage
  static deleteUserEmail() {
    return GetStorage().remove('email',);
  }



  /// use this to [saveUsername] to local storage
  static saveUsername(String userName) {
    return GetStorage().write('name', userName);
  }

  /// use this to [getUsername] from local storage
  static getUsername() {
    return GetStorage().read('name') ?? "non";
  }

  /// use this to [deleteUsername] from local storage
  static deleteUsername() {
    return GetStorage().remove('name',);
  }


  /// use this to [saveUserID] to local storage
  static saveUserID(String userId) {
    return GetStorage().write('id', userId);
  }

  /// use this to [getUserID] from local storage
  static getUserID() {
    return GetStorage().read('id') ?? "dummy-id";
  }

  /// use this to [deleteUserID] from local storage
  static deleteUserID() {
    return GetStorage().remove('id');
  }

  /// use this to save cloudinary secure url [imageUrl] temporarily to local storage
  static saveCloudinaryUrl(String imageUrl) {
    return GetStorage().write('image', imageUrl);
  }

  /// use this to [getImageUrl] from local storage
  static getCloudinaryUrl() {
    return GetStorage().read('image') ?? "non";
  }

  /// use this to [deleteImageURL] from local storage
  static deleteCloudinaryUrl() {
    return GetStorage().remove('image');
  }



  /// use this to [save device longitude] to local storage
  static saveDeviceLongitude(double longitude) {
    return GetStorage().write('long', longitude);
  }

  /// use this to [get device longitude] from local storage
  static getDeviceLongitude() {
    return GetStorage().read('long') ?? 0.0;
  }

  /// use this to [delete device longitude] from local storage
  static deleteDeviceLongitude() {
    return GetStorage().remove('long');
  }

  /// use this to [save device latitude] to local storage
  static saveDeviceLatitude(double latitude) {
    return GetStorage().write('lat', latitude);
  }

  /// use this to [get device latitude] from local storage
  static getDeviceLatitude() {
    return GetStorage().read('lat') ?? 0.0;
  }

  /// use this to [delete device latitude] from local storage
  static deleteDeviceLatitude() {
    return GetStorage().remove('lat');
  }

}
