
class ApiEndPoint {

  static String BASE_URL = "https://hindustanbrassindustries.com/api/";


  static Uri REGISTER = Uri.parse(BASE_URL + "register");
  static Uri login = Uri.parse(BASE_URL + "login");
  static Uri ForgetPassword = Uri.parse(BASE_URL + "forgot-password");
  static Uri socialmediasignup = Uri.parse(BASE_URL + "social-media-signup");
  static Uri getJobCategory = Uri.parse(BASE_URL + "job-categories");
  static Uri AppliedJob = Uri.parse(BASE_URL + "candidate/applied-jobs");
  static Uri getRecentJob = Uri.parse(BASE_URL + "latest-jobs");
  static Uri getJobDetails = Uri.parse(BASE_URL + "job/");
  static Uri applyJob = Uri.parse(BASE_URL + "apply-job");
  static Uri logout = Uri.parse(BASE_URL + "logout");
  static Uri refressToken = Uri.parse(BASE_URL + "refresh-token");
  // static Uri LOGIN = Uri.parse(BASE_URL + "/auth/login");


}