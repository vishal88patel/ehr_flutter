
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
  static Uri getDashboard = Uri.parse(BASE_URL + "users/dashboard");
  static Uri saveTestResult = Uri.parse(BASE_URL + "users/save-test-result");
  static Uri saveMedication = Uri.parse(BASE_URL + "users/save-medication");
  static Uri saveTestImagine = Uri.parse(BASE_URL + "users/save-test-imagine");

  static Uri getTestResult = Uri.parse(BASE_URL + "users/get-test-result");
  static Uri getMedications = Uri.parse(BASE_URL + "users/get-medications");
  static Uri getPain = Uri.parse(BASE_URL + "users/get-pains");
  static Uri saveFeedback = Uri.parse(BASE_URL + "users/submit-feedback");
  static Uri saveSchedule = Uri.parse(BASE_URL + "users/save-schedule");
  static Uri deleteSchedule = Uri.parse(BASE_URL + "users/delete-schedule");
  static Uri getSchedule = Uri.parse(BASE_URL + "users/get-schedules");
  static Uri painDashboard = Uri.parse(BASE_URL + "users/pain-dashboard");

  static Uri logout = Uri.parse(BASE_URL + "account/logout");

}