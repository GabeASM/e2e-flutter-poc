import 'package:end2endpoc/home/repository/form_repository.dart';
import 'package:end2endpoc/home/repository/form_repository_impl.dart';
import 'package:end2endpoc/home/services/form_serivice_impl.dart';
import 'package:end2endpoc/home/services/form_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerSingleton<FormRepository>(FormRepositoryImpl());
  getIt.registerFactory<FormService>(() => FormServiceImpl(getIt<FormRepository>()));

}
