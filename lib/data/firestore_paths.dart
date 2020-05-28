class FirestorePaths {

  static const PATH_USERS = "users";


  static String userPath(String userId) {
    return "$PATH_USERS/$userId";
  }


}
