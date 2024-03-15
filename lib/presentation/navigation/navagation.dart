import 'package:go_router/go_router.dart';

import '../screens/history/history_screen.dart';
import '../screens/main/main_screen.dart';
import '../screens/add_pulse_records/add_pulse_records.dart';

class Navigation {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: MainScreen.path,
        name: MainScreen.name,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AddPulseRecords.path,
        name: AddPulseRecords.name,
        builder: (context, state) => const AddPulseRecords(),
      ),
      GoRoute(
        path: HistoryScreen.path,
        name: HistoryScreen.name,
        builder: (context, state) => const HistoryScreen(),
      ),
    ],
  );
}
