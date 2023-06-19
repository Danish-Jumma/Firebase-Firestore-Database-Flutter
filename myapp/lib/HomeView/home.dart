import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HomeView());
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CollectionReference _product =
      FirebaseFirestore.instance.collection('product');
  getProduct() async {
    return await _product.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Crud'),
        ),
        body: FutureBuilder(
            future: getProduct(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.amber.shade100,
                        child: ListTile(
                          title: Center(
                              child: Text(snapshot.data.docs[index]['name'])),
                          subtitle: Center(
                              child: Text(snapshot.data.docs[index]['price'])),
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
