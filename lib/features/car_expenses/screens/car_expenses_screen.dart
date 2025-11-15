import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../state/car_expenses_provider.dart';
import '../widgets/expense_table.dart';

class CarExpensesScreen extends StatelessWidget {
  const CarExpensesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final carExpensesProvider = CarExpensesProvider.of(context);
    final expenses = carExpensesProvider.expenses;
    final totalAmount = carExpensesProvider.totalAmount;
    final onRemove = carExpensesProvider.removeExpense;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Информация',
              onPressed: () => context.pushReplacement('/info'),
            ),
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'История',
              onPressed: () => context.pushReplacement('/history'),
            ),
          ],
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: "https://cdn-icons-png.flaticon.com/512/2921/2921222.png",
              width: 30,
              height: 30,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 8),
            Text('Расходы: ${totalAmount.toStringAsFixed(2)} руб.'),
          ],
        ),
      ),
      body: ExpenseTable(
        expenses: expenses,
        onRemove: (id) => onRemove(id, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/expenses/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

