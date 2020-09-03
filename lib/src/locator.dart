import 'package:click_up_tasks/src/services/click_up_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

registerLocatorItems(String _clickUpAPIKey) {
  locator.registerLazySingleton(() => ClickUpService(_clickUpAPIKey));
}
