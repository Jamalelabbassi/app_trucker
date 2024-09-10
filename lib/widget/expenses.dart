import 'dart:math';

import 'package:app_trucker/model/expense.dart';
import 'package:app_trucker/widget/expense_list/expenses_list.dart';
import 'package:app_trucker/widget/new_expense.dart';
import 'package:flutter/material.dart';



class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registerExpenses = [

    Expense(
    title: 'Flutter Course', 
    amount: 19.99, 
    date: DateTime.now(),
    category: Category.work,
     ),
     Expense(title: 'Cinema', 
    amount: 13.69, 
    date: DateTime.now(),
    category: Category.leisure,
     ),

  ];

   void _openAddExpenseOverlay(){
     showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx){
      return  NewExpense(onAddExpense: _addExpense);
     });
  }

  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense);
    });
    
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Expense deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: (){
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ));
  }


  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No expenses found, Start adding some!"),);

    if(_registerExpenses.isNotEmpty){
      mainContent = ExpensesList(
              expenses: _registerExpenses,
              onRemovedExpense: _removeExpense,
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ExpenseTracker"),
        actions: [
        IconButton(
         onPressed: _openAddExpenseOverlay,
         icon: const Icon(Icons.add)),
      ],),
      body: Column(
        children: [
          const Text('The Char'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    
    );
  }}