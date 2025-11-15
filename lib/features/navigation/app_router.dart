import 'package:flutter/material.dart';
import 'package:flutter_practice8/features/car_expenses/screens/add_expense_screen.dart';
import 'package:flutter_practice8/features/car_expenses/screens/car_expenses_screen.dart';
import 'package:flutter_practice8/features/car_expenses/state/car_expenses_container.dart';
import 'package:flutter_practice8/features/service_history/screens/add_service_record_screen.dart';
import 'package:flutter_practice8/features/service_history/screens/service_history_screen.dart';
import 'package:flutter_practice8/features/vehicle_info/screens/vehicle_info_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/expenses',
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return CarExpensesContainer(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/expenses',
          builder: (BuildContext context, GoRouterState state) {
            return const CarExpensesScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'add',
              builder: (BuildContext context, GoRouterState state) {
                return const AddExpenseScreen();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/info',
      builder: (context, state) => const VehicleInfoScreen(),
    ),
    GoRoute(
        path: '/history',
        builder: (BuildContext context, GoRouterState state) {
          return const ServiceHistoryScreen();
        },
        routes: [
          GoRoute(
            path: 'add',
            builder: (BuildContext context, GoRouterState state) {
              return const AddServiceRecordScreen();
            },
          ),
        ]),
  ],
);
