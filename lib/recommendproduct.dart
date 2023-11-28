import 'dart:math';
import 'package:flutter/material.dart';

// 먼저 제품 정보를 저장할 모델 클래스를 정의합니다.
class Product {
  final String imagePath;
  final String title;
  final String description;

  Product({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class RecommendedProductsPage extends StatefulWidget {
  const RecommendedProductsPage({super.key});

  @override
  State<RecommendedProductsPage> createState() =>
      _RecommendedProductsPageState();
}

class _RecommendedProductsPageState extends State<RecommendedProductsPage> {
  // 전체 제품 목록을 생성합니다.
  final List<Product> products = [
    Product(
        imagePath: 'assets/images/boldman.png',
        title: '제품 1',
        description: '설명 1'),
    Product(
        imagePath: 'assets/images/Googleimage.png',
        title: '제품 1',
        description: '설명 1'),
    Product(
        imagePath: 'assets/images/hairlossman.png',
        title: '제품 1',
        description: '설명 1'),
    Product(
        imagePath: 'assets/images/myphoto.png',
        title: '제품 1',
        description: '설명 1'),
    Product(
        imagePath: 'assets/images/Kakaoimage.png',
        title: '제품 1',
        description: '설명 1'),
    // ... 10개의 제품을 여기에 추가...
    Product(
        imagePath: 'assets/images/newman.png',
        title: '제품 10',
        description: '설명 10'),
  ];

  // 랜덤으로 5개의 제품을 선택할 목록입니다.
  late List<Product> displayedProducts;

  @override
  void initState() {
    super.initState();
    displayedProducts = getRandomProducts();
  }

  // 랜덤으로 제품을 선택하는 함수입니다.
  List<Product> getRandomProducts() {
    var random = Random();
    // 제품 목록을 셔플하고 앞에서부터 5개를 선택합니다.
    List<Product> shuffledProducts = [...products]..shuffle(random);
    return shuffledProducts.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E7),
      appBar: AppBar(
        title: const Text(
          '추천 제품',
          style:
              TextStyle(color: Color(0xFF51370E), fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: displayedProducts
              .map((product) => Card(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image.asset(
                          product.imagePath,
                          width: width * 0.3,
                          height: height * 0.2,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(product.description),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
