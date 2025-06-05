import 'package:flutter/material.dart';
import '../table/customer_table.dart';

class CustomerScreenMobile extends StatelessWidget {
  const CustomerScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: const CustomerTable(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // TODO: Thêm khách hàng mới
      //   },
      //   child: const Icon(Icons.person_add),
      // ),
    );
  }
}