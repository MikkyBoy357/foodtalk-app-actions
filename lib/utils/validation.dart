class Validations {
  static String? validateName(String? value) {
    if (value!.isEmpty) return 'Field is required.';
    final RegExp nameExp = RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value!.isEmpty) return 'Field is required.';
    final RegExp nameExp =
        RegExp(r'^(?=.{4,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');
    if (value.length < 4) {
      return 'Username must be more than 4 characters.';
    }
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateEmail(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) return 'Invalid email address';
  }

  static String? validateUrl(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return 'URL is required.';
    final RegExp nameExp = RegExp(
        r'^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&\(\)\*\+,;=.]+$'
        // r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?',
        );
    if (!nameExp.hasMatch(value) && isRequried) return 'Invalid URL';
  }

  static String? validateNumber(String? value) {
    if (value!.isEmpty) return 'Field is required.';
    final RegExp nameExp = RegExp('([0-9]+(\.[0-9]+)?)');
    if (!nameExp.hasMatch(value)) return 'Invalid Number';
    return null;
  }

  static String? validateString(String? value) {
    if (value!.isEmpty) return 'Field is required.';
    // final RegExp nameExp = new RegExp('([0-9]+(\.[0-9]+)?)');
    // if (!nameExp.hasMatch(value) && isRequired) return 'Invalid Number';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Please enter a valid password.';
    }
    return null;
  }
}
