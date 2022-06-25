
class ApiEndPoint {

  static String BASE_URL = "https://ehr-app.azurewebsites.net/api/v1/";


  static Uri login = Uri.parse(BASE_URL + "account/login");
  static Uri otpVeryfy = Uri.parse(BASE_URL + "account/verify-access");
  static Uri resendOtp = Uri.parse(BASE_URL + "account/resend-code");
  static Uri getProfile = Uri.parse(BASE_URL + "account/profile");
  static Uri updateProfile = Uri.parse(BASE_URL + "account/update-profile");
  static Uri uploadPhoto = Uri.parse(BASE_URL + "account/upload-photo");


  static Uri countryCode = Uri.parse(BASE_URL + "shared/get-country-codes");
  static Uri getBodyParts = Uri.parse(BASE_URL + "shared/get-body-parts");
  static Uri getTestResultType = Uri.parse(BASE_URL + "shares/get-test-result-types");
  static Uri getMedicationContent = Uri.parse(BASE_URL + "shares/get-medication-content");
  static Uri getImagineTypes = Uri.parse(BASE_URL + "shares/get-imagine-types");


  static Uri getNotification = Uri.parse(BASE_URL + "users/get-notifications");
  static Uri savePain = Uri.parse(BASE_URL + "users/save-pain");
  static Uri saveComment = Uri.parse(BASE_URL + "users/save-comment");
  static Uri getComment = Uri.parse(BASE_URL + "users/get-comments");
  static Uri getDashboard = Uri.parse(BASE_URL + "users/dashboard");
  static Uri saveTestResult = Uri.parse(BASE_URL + "users/save-test-result");
  static Uri saveMedication = Uri.parse(BASE_URL + "users/save-medication");
  static Uri saveTestImagine = Uri.parse(BASE_URL + "users/save-test-imagine");

}