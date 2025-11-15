import 'package:flutter/material.dart';
import '../models/expense_model.dart';

class CarExpensesProvider extends InheritedWidget {
  final List<ExpenseModel> expenses;
  final double totalAmount;
  final Function(String title, double amount) addExpense;
  final Function(String id, BuildContext context) removeExpense;

  const CarExpensesProvider({
    super.key,
    required this.expenses,
    required this.totalAmount,
    required this.addExpense,
    required this.removeExpense,
    required super.child,
  });

  static CarExpensesProvider of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<CarExpensesProvider>()!;
    }
    return context.findAncestorWidgetOfExactType<CarExpensesProvider>()!;
  }

  @override
  bool updateShouldNotify(CarExpensesProvider oldWidget) {
    return expenses != oldWidget.expenses || totalAmount != oldWidget.totalAmount;
  }
}
