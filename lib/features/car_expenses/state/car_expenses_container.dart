import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/expense_model.dart';
import 'car_expenses_provider.dart';

class CarExpensesContainer extends StatefulWidget {
  final Widget child;
  const CarExpensesContainer({super.key, required this.child});

  @override
  State<CarExpensesContainer> createState() => _CarExpensesContainerState();
}

class _CarExpensesContainerState extends State<CarExpensesContainer> {
  final List<ExpenseModel> _expenses = [];
  final _uuid = const Uuid();

  ExpenseModel? _recentlyRemovedExpense;
  int? _recentlyRemovedExpenseIndex;

  double get _totalAmount {
    return _expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  void _saveExpense(String title, double amount) {
    final newExpense = ExpenseModel(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _removeExpense(String id, BuildContext context) {
    final expenseIndex = _expenses.indexWhere((expense) => expense.id == id);
    if (expenseIndex < 0) {
      return;
    }

    setState(() {
      _recentlyRemovedExpenseIndex = expenseIndex;
      _recentlyRemovedExpense = _expenses.removeAt(expenseIndex);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Расход удален'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'ОТМЕНИТЬ',
            onPressed: _undoRemove,
          ),
        ),
      );
    });
  }

  void _undoRemove() {
    if (_recentlyRemovedExpense != null && _recentlyRemovedExpenseIndex != null) {
      setState(() {
        _expenses.insert(
            _recentlyRemovedExpenseIndex!, _recentlyRemovedExpense!);
        _recentlyRemovedExpense = null;
        _recentlyRemovedExpenseIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarExpensesProvider(
      expenses: _expenses,
      totalAmount: _totalAmount,
      addExpense: _saveExpense,
      removeExpense: _removeExpense,
      child: widget.child,
    );
  }
}

