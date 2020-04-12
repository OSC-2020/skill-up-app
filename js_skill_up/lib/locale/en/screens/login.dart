class LoginLocale {
  static String title = "JS Skill Up";

  static String googleImageIcon = "assets/icons/google.png";
  static String facebookImageIcon = "assets/icons/facebook.png";
  static String githubImageIcon = "assets/icons/github.png";

  static String googleLoginToolTip = "Login with Google";
  static String facebookLoginToolTip = "Login with Facebook";
  static String githubLoginToolTip = "Login with Github";

  static Function successSnack = (email) => "Welcome back $email";
  static String failure = "Failed to log you in.";
  static String retryLabel = "Retry";

  // Config changes
  static String configTitleFont = "Calibre-Semibold";
  static const int configLoginFailSnackBarDuration = 1;
}
