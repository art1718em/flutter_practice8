import 'package:flutter_practice8/features/service_history/state/service_history_state.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton(ServiceHistoryState());
}
