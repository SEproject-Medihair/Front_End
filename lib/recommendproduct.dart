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
        imagePath: 'assets/images/sampoo/rinse1.png',
        title: '아미노 펩타이드 고영양 모발케어 트리트먼트',
        description:
            '잘게 쪼개져 모발에 잘 흡수되는 고영양 미세단백질 케어 엘라스틴 역사상 가장 효과적인 단백질 침투기술 적용!'),
    Product(
        imagePath: 'assets/images/sampoo/rinse2.png',
        title: '세라마이드 모이스처 수분케어 10X 트리트먼트',
        description: '10배 강화된 세라마이드 성분이 함유된 포뮬러로 건조하고 푸석해진 모발 수분케어'),
    Product(
        imagePath: 'assets/images/sampoo/rinse3.png',
        title: '아르간 오일 데미지 윤기케어 10X 트리트먼트',
        description: '10배 강화된 아르간 오일 성분이 함유된 포뮬러로 손상되고 갈라진 모발 영양케어'),
    Product(
        imagePath: 'assets/images/sampoo/rinse4.png',
        title: '아미노 펩타이드 볼륨 리프팅케어 트리트먼트',
        description:
            '잘게 쪼개져 모발에 잘 흡수되는 고영양 미세단백질 케어 엘라스틴 역사상 가장 효과적인 단백질 침투기술 적용!'),
    Product(
        imagePath: 'assets/images/sampoo/rinse5.png',
        title: '엘라스틴 실크테라피 바이오본드 17 케라틴 트리트먼트',
        description: '단 1회만에 단백질, 아미노산 등 모발에 핵심성분을 생체결합시켜 손상된 모발을 개선하는 트리트먼트'),
    Product(
        imagePath: 'assets/images/sampoo/rinse6.png',
        title: '엘라스틴 실크테라피 바이오본드 17 케라틴 본딩 앰플',
        description: '샴푸 후 젖은 모발에 뿌려주어 단백질을 모발 속까지 침투시키는 본딩 앰플'),
    Product(
        imagePath: 'assets/images/sampoo/rinse7.png',
        title: '프로틴클리닉 10000 헤어세럼',
        description:
            '시크릿 오일 & 저분자 단백질 콤플렉스 10,000 ppm을 담은  뚝뚝 끊어지고 갈라지는 극손상 모발용 고영양 헤어세럼'),
    Product(
        imagePath: 'assets/images/sampoo/rinse8.png',
        title: '엘라스틴 실크테라피 바이오본드 17 케라틴 헤어에센스',
        description: '모발 매끄러움 개선 만족도 100%! 모발 큐티클에 보호막을 형성해주는 헤어에센스'),
    Product(
        imagePath: 'assets/images/sampoo/rinse9.jpeg',
        title: '닥터그루트 밀도케어 고농축 트리트먼트',
        description: '탈모샴푸의 대혁명!  모발 속까지 채우는 닥터그루트 밀도케어  고농축 트리트먼트 '),
    Product(
        imagePath: 'assets/images/sampoo/rinse10.jpeg',
        title: '닥터그루트 탈모증상집중케어 프리미엄 라인 프로이펙트 트리트먼트(힘없는 모발용)',
        description: '재구매율 1위 닥터그루트 탈모증상집중케어 프리미엄 라인, 프로이펙트 트리트먼트(힘없는 모발용)'),
    Product(
        imagePath: 'assets/images/sampoo/rinse11.jpeg',
        title: '닥터그루트 탈모증상집중케 ADVANCED 항산화 두피 토닉',
        description:
            '더 강력해진 닥터그루트 집중케어 ADVANCED 7가지기능성 성분이 두피에 직접 흡수되는  항산화 두피 토닉 탈모 고민 있는 부위에 데일리 탈모 케어'),
    Product(
        imagePath: 'assets/images/sampoo/rinse12.jpeg',
        title: '리엔 자윤 트리트먼트',
        description:
            '두피를 맑고 건강하게 해주는 동양 차 에센스의 영양이 펌이나 염색으로 손상된 모발을 근본부터 튼튼하게 다져주어 스스로 빛나고 윤기나는 머릿결로 되돌려줍니다.'),
    Product(
        imagePath: 'assets/images/sampoo/rinse13.jpeg',
        title: '오가니스트 체리블로썸 수분 영양 컨디셔너',
        description:
            '실리콘, 설페이트계 계면활성제 등 20가지 화학성분 무첨가 온가족이 쓰는 비건인증1), 더마테스트 엑설런트 등급 획득 컨디셔너'),
    Product(
        imagePath: 'assets/images/sampoo/rinse14.jpeg',
        title: '오가니스트 모로코 아르간 오일 윤기 영양 컨디셔너',
        description:
            '실리콘, 설페이트계 계면활성제 등 20가지 화학성분 무첨가 온가족이 쓰는 비건인증1), 더마테스트 엑설런트 등급 획득 컨디셔너'),
    Product(
        imagePath: 'assets/images/sampoo/rinse15.jpeg',
        title: '리엔 윤고 더 퍼스트 리치오일 에센스',
        description:
            '극상의 영양케어,  왕실의 오일 에센스 한국과 중국 왕실에서 사랑받은 귀한 꽃의 정수를 한방 오일과 블렌딩해  광채나는 여왕의 머릿결을 완성'),
  ];
  final List<Product> sampooproducts = [
    Product(
        imagePath: 'assets/images/sampoo/sampoo1.png',
        title: '아미노 펩타이드 고영양 모발케어 샴푸',
        description:
            '잘게 쪼개져 모발에 잘 흡수되는 미세단백질 케어! 엘라스틴 역사상 가장 효과적인 단백질 침투 기술 적용!'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo2.png',
        title: '아미노 펩타이드 극손상 집중케어 샴푸',
        description:
            '잘게 쪼개져 모발에 잘 흡수되는 고영양 미세단백질 케어 엘라스틴 역사상 가장 효과적인 단백질 침투기술 적용!'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo3.png',
        title: '아미노 펩타이드 볼륨 리프팅케어 샴푸',
        description:
            '잘게 쪼개져 모발에 잘 흡수되는 고영양 미세단백질 케어 엘라스틴 역사상 가장 효과적인 단백질 침투기술 적용!'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo4.png',
        title: '세라마이드 모이스처 수분케어 10X 샴푸/컨디셔너',
        description: '10배 강화된 세라마이드 성분이 함유된 포뮬러로 건조하고 푸석해진 모발 수분케어'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo5.png',
        title: '아르간 오일 데미지 윤기케어 10X 샴푸/컨디셔너',
        description: '10배 강화된 아르간 오일 성분이 함유된 포뮬러로 손상되고 갈라진 모발 영양케어'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo6.png',
        title: '콜라겐 볼륨 탄력케어 10X 샴푸/컨디셔너',
        description: '10배 강화된 콜라겐 성분이 함유된 포뮬러로 힘없이 축 처진 모발 볼륨케어'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo7.jpeg',
        title: '마스터 블렌드 고영양 컨디셔너',
        description:
            '헤어 기술력의 결정체, 엘라스틴 역사상 가장 효과적인 영양케어! 모발에 진한 영양을 공급해 탄력있고 빛나는 광채 머릿결'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo8.jpeg',
        title: '마스터 블렌드 펩타이드 고영양 샴푸',
        description:
            '헤어 기술력의 결정체, 엘라스틴 역사상 가장 효과적인 영양케어! 모발에 진한 영양을 공급해 탄력있고 빛나는 광채 머릿결'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo9.jpeg',
        title: '마스터 블렌드 미셀라 클렌징 샴푸',
        description:
            '헤어 기술력의 결정체, 엘라스틴 역사상 가장 효과적인 두피케어! 두피 노폐물을 깔끔하게 정화하며 두피 환경을 건강하게 케어'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo10.jpeg',
        title: '닥터그루트 밀도케어 모발밀도 강화샴푸',
        description: '탈모샴푸의 대혁명!  모발속까지 채우는 닥터그루트 밀도케어 모발밀도 강화샴푸'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo11.jpeg',
        title: '닥터그루트 탈모증상집중케어 두피쿨링 샴푸',
        description:
            '쿨링 샴푸도 닥터그루트 답게!알래스카 빙하수 · 멘톨로 쿨링감은 기본, 체취마스킹 특허향료* 에 과도한 유분, 비듬, 각질 딥클렌징으로 악취 원인 제거까지!'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo12.jpeg',
        title: '닥터그루트 마이크로바이옴 제네시크7 두피강화 캡슐 샴푸',
        description: '14일만에 무너진 두피 생태계를 개선해주는 탈모증상완화 샴푸'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo13.jpeg',
        title: '닥터그루트 마이크로바이옴 센서티브20 두피진정 앰플 샴푸',
        description: '시카&편백추출물 함유 포뮬러로 7일만에 붉어진 두피 진정 효과- 7일만에 붉어진 두피 진정 효과'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo14.png',
        title: '오가니스트 히말라야 핑크솔트 스케일링 샴푸',
        description:
            '정수리 냄새 없이 잔향 48시간 지속! 더마테스트&비건 인증 받은 오가니스트. 비듬과 각질로 답답한 두피를 위한 핑크 솔트&티트리&시카 스케일링 케어'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo15.jpeg',
        title: '오가니스트 체리블로썸 수분 영양 샴푸',
        description:
            '실리콘, 설페이트계 계면활성제 등 20가지 화학성분 무첨가 온가족이 쓰는 비건인증1), 더마테스트 엑설런트 등급 획득 샴푸'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo16.png',
        title: '오가니스트 로즈마리 앤 씨솔트 딥클렌징 샴푸',
        description:
            '정수리 냄새 없이 잔향 48시간 지속! 더마테스트&비건 인증 받은 오가니스트. 기름지고 떡지는 지성 두피를 위한 로즈마리&씨솔트&AHA 딥클렌징 케어'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo17.png',
        title: '오가니스트 페퍼민트 앤 진저 쿨링 샴푸',
        description:
            '정수리 냄새 없이 잔향 48시간 지속! 더마테스트&비건 인증 받은 오가니스트. 열감 있고 가려운 두피를 위한 페퍼민트&진저&멘톨 쿨링 진정 케어'),
    Product(
        imagePath: 'aassets/images/sampoo/sampoo18.png',
        title: '카멜리아 블랙 인텐시브 데미지 리페어 샴푸',
        description: '실리콘 무첨가, 약산성으로 두피부터 모발까지 건강한 내추럴 손상케어 전문 샴푸'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo19.jpeg',
        title: '리엔 보양진 민감성 샴푸',
        description:
            '화학성분 실리콘을 빼고 모발강화 특효성분인 진효본연단™ 과 두피보양을 위해 엄선된 4가지 성분, 탈모 증상을 완화해주는 주성분이 모발과 두피를 집중 관리 해줍니다.'),
    Product(
        imagePath: 'assets/images/sampoo/sampoo20.jpeg',
        title: '리엔 보양진 지성 샴푸',
        description:
            '화학성분 실리콘을 빼고 모발강화 특효성분인 진효본연단™ 과 두피보양을 위해 엄선된 4가지 성분, 탈모 증상을 완화해주는 주성분이 모발과 두피를 집중 관리 해줍니다.'),
  ];

  // 랜덤으로 5개의 제품을 선택할 목록입니다.
  late List<Product> displayedProducts;
  late List<Product> displayedProducts2;
  @override
  void initState() {
    super.initState();
    displayedProducts = getRandomProducts();
    displayedProducts2 = getRandomProducts2();
  }

  // 랜덤으로 제품을 선택하는 함수입니다.
  List<Product> getRandomProducts() {
    var random = Random();
    // 제품 목록을 셔플하고 앞에서부터 5개를 선택합니다.
    List<Product> shuffledProducts = [...products]..shuffle(random);
    return shuffledProducts.take(5).toList();
  }

  List<Product> getRandomProducts2() {
    var random = Random();
    // 제품 목록을 셔플하고 앞에서부터 5개를 선택합니다.
    List<Product> shuffledProducts = [...sampooproducts]..shuffle(random);
    return shuffledProducts.take(5).toList();
  }

  @override
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
              TextStyle(color: Color(0xFF51370E), fontWeight: FontWeight.w600),
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
          children: [
            const SizedBox(
              height: 20,
            ),
            // displayedProducts를 표시하는 부분
            const Text(
              '추천 샴푸',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF51370E)),
            ),
            ...displayedProducts2
                .map(
                  (product) => buildProductCard(product, width, height),
                )
                .toList(),
            // displayedProducts2를 표시하는 부분

            const SizedBox(
              height: 60,
            ),
            const Text(
              '추천 컨디셔너',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF51370E)),
            ),
            ...displayedProducts
                .map(
                  (product) => buildProductCard(product, width, height),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

// 제품 카드를 구성하는 별도의 메소드
  Widget buildProductCard(Product product, double width, double height) {
    return Card(
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
    );
  }
}
