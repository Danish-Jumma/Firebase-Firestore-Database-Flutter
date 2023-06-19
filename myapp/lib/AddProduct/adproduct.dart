import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AddProducts());
}

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  addProducts() {
    CollectionReference products =
        FirebaseFirestore.instance.collection('product');
    products.add({'name': productName.text, 'price': productPrice.text}).then(
        (value) {
      SnackBar(content: Text('Product Added Successfully.'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(
                controller: productName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Product Name'),
                    hintText: 'Add New Product Name'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(
                controller: productPrice,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Product Price'),
                    hintText: 'Add New Product Price'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: ElevatedButton(
                  onPressed: () {
                    addProducts();
                  },
                  child: const Text('Add Product')),
            )
          ],
        ),
      ),
    );
  }
}
