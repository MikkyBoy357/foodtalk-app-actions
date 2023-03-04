import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_storage/local_db.dart';

final GetIt locator = GetIt.instance;

class AppDependencies {
  static Future<void> reset() async {
    await locator.reset();
    await register();
  }

  static Future<void> register() async {
    _registerBaseDependencies();
    // _registerAuthenticationDependencies();
    // _registerNDADependencies();
    await locator.isReady<SharedPreferences>();
    await locator.allReady();
  }

  ///
  ///
  /// BASE DEPENDENCIES
  ///
  ///
  static _registerBaseDependencies() {
    locator.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
    locator.registerLazySingleton<AppDataBaseService>(
      () => AppDataBaseService(),
    );
  }

  ///
  ///
  /// AUTHENTICATION DEPENDENCIES
  ///
  ///
  // static _registerAuthenticationDependencies() {
  //   locator.registerLazySingleton<AppAuthentication>(
  //     () => AuthenticationData(
  //       fireStoreService: locator(),
  //     ),
  //   );
  //   locator.registerLazySingleton<UserData>(
  //     () => UserDataImplementation(
  //       fireStoreService: locator(),
  //       fireBaseStorageService: locator(),
  //       apiRequestsHelper: locator(),
  //     ),
  //   );
  //   locator.registerLazySingleton<AuthenticationViewModel>(
  //     () => AuthenticationViewModel(
  //       authData: locator(),
  //       userData: locator(),
  //       localStorageService: locator(),
  //     ),
  //   );
  //   locator.registerLazySingleton<CustomNavVM>(
  //     () => CustomNavVM(),
  //   );
  //   locator.registerLazySingleton<UserProfileViewModel>(
  //     () => UserProfileViewModel(
  //       userData: locator(),
  //       authData: locator(),
  //       localStorageService: locator(),
  //     ),
  //   );
  // }

  ///
  ///
  /// NDA FEATURE DEPENDENCIES
  ///
  ///
  // static _registerNDADependencies() {
  //   locator.registerLazySingleton<NDAData>(
  //     () => NDADataImplementation(
  //       fireStoreService: locator(),
  //       appStorage: locator(),
  //       apiRequestsHelper: locator(),
  //     ),
  //   );
  //   locator.registerLazySingleton<NDAViewModel>(
  //     () => NDAViewModel(
  //       ndaData: locator(),
  //     ),
  //   );
  //   locator.registerLazySingleton<SearchViewModel>(
  //     () => SearchViewModel(
  //       localStorageService: locator(),
  //       ndaData: locator(),
  //     ),
  //   );
  //   locator.registerLazySingleton<EventProvider>(
  //     () => EventProvider(locator(), locator(), locator()),
  //   );
  //   locator.registerLazySingleton<ServiceProvider>(
  //     () => ServiceProvider(locator(), locator(), locator()),
  //   );
  //   locator.registerLazySingleton<HangoutProvider>(
  //     () => HangoutProvider(locator(), locator(), locator()),
  //   );
  //   locator.registerLazySingleton<BusinessProvider>(
  //     () => BusinessProvider(locator(), locator(), locator()),
  //   );
  // }
}
