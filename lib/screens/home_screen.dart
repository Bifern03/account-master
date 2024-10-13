import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> foodMenu = [
    'ผัดไทย',
    'ส้มตำ',
    'แกงเขียวหวาน',
    'ต้มยำกุ้ง',
    'ข้าวมันไก่',
    'ผัดกระเพรา',
    'ข้าวผัด',
    'หมูปิ้ง',
  ];

  String getRandomFood() {
    final random = Random();
    return foodMenu[random.nextInt(foodMenu.length)];
  }

  void showRandomFoodDialog(BuildContext context) {
    String randomFood = getRandomFood(); 
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('เมนูอาหารที่สุ่มได้'),
          content: Text(randomFood, style: const TextStyle(fontSize: 24)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("สุ่มเมนูอาหาร"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.transactions.isEmpty) {
            return const Center(
              child: Text('ไม่มีรายการ'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                var statement = provider.transactions[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(statement.title),
                    subtitle: Text(DateFormat('dd MMM yyyy hh:mm:ss')
                        .format(statement.date)),
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text('${statement.amount}'),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.deleteTransaction(statement.keyID);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(statement: statement);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showRandomFoodDialog(context);
        },
        child: const Icon(Icons.restaurant_menu),
        tooltip: 'สุ่มเมนูอาหาร',
      ),
    );
  }
}
