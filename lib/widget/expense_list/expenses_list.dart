import 'package:app_trucker/model/expense.dart';
import 'package:app_trucker/widget/expense_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemovedExpense});

  final List<Expense> expenses;  
  final void Function(Expense expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
      return Dismissible(
        key:ValueKey(expenses[index]),
        onDismissed: (direction){
          onRemovedExpense(expenses[index]);
        },
       child: ExpensesItem(expenses[index]));
    });
  }
}