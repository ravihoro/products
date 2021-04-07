import 'package:get_it/get_it.dart';
import 'package:products/viewmodel/base_model.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseModel());
}
