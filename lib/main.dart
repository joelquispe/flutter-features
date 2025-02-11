// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class ProductModel {
  String name;
  String description;
  double price;
  ProductModel({
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      price: double.parse(map['price'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: ExamplePaginationScreen(),
    );
  }
}

class ExamplePaginationScreen extends StatefulWidget {
  const ExamplePaginationScreen({
    super.key,
  });

  @override
  State<ExamplePaginationScreen> createState() =>
      _ExamplePaginationScreenState();
}

class _ExamplePaginationScreenState extends State<ExamplePaginationScreen> {
  List<ProductModel> products = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  bool hasMore = true;
  int page = 1;
  int limit = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProducts();
    scrollController.addListener(onScroll);
  }

  onScroll() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      log("obtener productos");
      loadProducts();
    }
  }

  Future<void> loadProducts() async {
    if (!hasMore) return;
    setLoading(true);
    try {
      final dio = Dio();
      final response = await dio.get(
          "http://10.0.2.2:3000/api/products/get-by-page?page=$page&limit=$limit");
      log(response.toString());
      log(response.data.toString());
      page++;

      final newProducts = List.from(response.data['data'])
          .map((product) => ProductModel.fromMap(product))
          .toList();
      hasMore = newProducts.length == limit;
      products.addAll(newProducts);
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    setLoading(false);
  }

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paginación'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: isLoading && page == 1
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    if (index == products.length) {
                      if (!hasMore){
                        return SizedBox();
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final product = products[index];
                      return ListTile(
                        title: Text("$index - ${product.name}"),
                        subtitle: Text("Precio: S/${product.price}"),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.shade300,
                      height: 10,
                      thickness: 1,
                    );
                  },
                  itemCount: products.length + 1,
                ),
        ),
      ),
    );
  }
}
