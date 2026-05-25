import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const RandomPlaceApp());
}

class RandomPlaceApp extends StatelessWidget {
  const RandomPlaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '랜덤플레이스',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ─────────────────────────────────────────────
// 데이터 모델
// ─────────────────────────────────────────────
class DateCourse {
  final String title;
  final String region;
  final String category;
  final String description;
  final String cost;
  final String time;

  const DateCourse({
    required this.title,
    required this.region,
    required this.category,
    required this.description,
    required this.cost,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      other is DateCourse && other.title == title && other.region == region;

  @override
  int get hashCode => Object.hash(title, region);
}

// ─────────────────────────────────────────────
// 전체 조합 커버 데이터 (서울·경기·인천 × 실내·야외·맛집·카페·액티비티)
// ─────────────────────────────────────────────
const List<DateCourse> allCourses = [
  // ── 서울 / 실내 ──
  DateCourse(
    title: '성수 감성 전시회 데이트',
    region: '서울',
    category: '실내',
    description: '성수 카페에서 디저트 먹고 근처 전시회까지 가는 감성 코스',
    cost: '2인 약 45,000원',
    time: '약 3시간',
  ),
  DateCourse(
    title: '실내 만화카페 데이트',
    region: '서울',
    category: '실내',
    description: '비 오는 날 가기 좋은 만화카페 + 간식 코스',
    cost: '2인 약 30,000원',
    time: '약 3시간',
  ),
  DateCourse(
    title: '홍대 보드게임 카페',
    region: '서울',
    category: '실내',
    description: '홍대 보드게임 카페에서 함께 웃으며 즐기는 실내 데이트',
    cost: '2인 약 28,000원',
    time: '약 2시간 30분',
  ),

  // ── 서울 / 야외 ──
  DateCourse(
    title: '한강 라면 + 야경 산책',
    region: '서울',
    category: '야외',
    description: '한강에서 라면 먹고 야경 보면서 걷는 부담 없는 코스',
    cost: '2인 약 20,000원',
    time: '약 2시간',
  ),
  DateCourse(
    title: '북악산 드라이브 + 야경',
    region: '서울',
    category: '야외',
    description: '북악산 스카이웨이 드라이브 후 서울 야경 감상 코스',
    cost: '2인 약 15,000원',
    time: '약 2시간',
  ),
  DateCourse(
    title: '경복궁 야간 산책',
    region: '서울',
    category: '야외',
    description: '경복궁 야간 개방 산책 후 인근 북촌 골목 탐방',
    cost: '2인 약 18,000원',
    time: '약 2시간 30분',
  ),

  // ── 서울 / 맛집 ──
  DateCourse(
    title: '홍대 맛집 + 포토이즘',
    region: '서울',
    category: '맛집',
    description: '홍대 맛집에서 밥 먹고 인생네컷 찍는 데이트 코스',
    cost: '2인 약 50,000원',
    time: '약 3시간',
  ),
  DateCourse(
    title: '이태원 세계음식 투어',
    region: '서울',
    category: '맛집',
    description: '이태원 다양한 세계 음식 레스토랑을 투어하는 미식 데이트',
    cost: '2인 약 60,000원',
    time: '약 3시간',
  ),
  DateCourse(
    title: '광장시장 먹방 데이트',
    region: '서울',
    category: '맛집',
    description: '광장시장에서 빈대떡, 마약김밥, 육회 등 먹방 투어',
    cost: '2인 약 35,000원',
    time: '약 2시간',
  ),

  // ── 서울 / 카페 ──
  DateCourse(
    title: '연남동 카페 골목 투어',
    region: '서울',
    category: '카페',
    description: '연남동 감성 카페들을 돌며 디저트를 즐기는 카페 호핑 코스',
    cost: '2인 약 38,000원',
    time: '약 2시간 30분',
  ),
  DateCourse(
    title: '익선동 한옥 카페 데이트',
    region: '서울',
    category: '카페',
    description: '익선동 한옥 골목의 분위기 있는 카페에서 전통차 한 잔',
    cost: '2인 약 32,000원',
    time: '약 2시간',
  ),

  // ── 서울 / 액티비티 ──
  DateCourse(
    title: '잠실 롤러스케이팅 데이트',
    region: '서울',
    category: '액티비티',
    description: '롤러스케이팅 타며 손잡고 달리는 신나는 데이트 코스',
    cost: '2인 약 40,000원',
    time: '약 2시간',
  ),
  DateCourse(
    title: '합정 방탈출 카페',
    region: '서울',
    category: '액티비티',
    description: '함께 머리 맞대고 방탈출에 도전하는 두근두근 데이트',
    cost: '2인 약 50,000원',
    time: '약 2시간',
  ),

  // ── 경기 / 실내 ──
  DateCourse(
    title: '수원 실내 미술관 데이트',
    region: '경기',
    category: '실내',
    description: '수원 미술관에서 전시를 감상하고 아트숍에서 기념품 구경',
    cost: '2인 약 30,000원',
    time: '약 2시간 30분',
  ),
  DateCourse(
    title: '분당 VR 체험관',
    region: '경기',
    category: '실내',
    description: '분당 VR 체험관에서 가상현실 게임을 즐기는 신기한 데이트',
    cost: '2인 약 50,000원',
    time: '약 2시간',
  ),

  // ── 경기 / 야외 ──
  DateCourse(
    title: '일산 호수공원 산책',
    region: '경기',
    category: '야외',
    description: '호수공원에서 걷고 근처 카페까지 가는 여유로운 코스',
    cost: '2인 약 30,000원',
    time: '약 3시간',
  ),
  DateCourse(
    title: '용인 에버랜드 데이트',
    region: '경기',
    category: '야외',
    description: '에버랜드에서 놀이기구 타고 퍼레이드 보는 설레는 데이트',
    cost: '2인 약 120,000원',
    time: '약 6시간',
  ),

  // ── 경기 / 맛집 ──
  DateCourse(
    title: '수원 왕갈비 맛집 투어',
    region: '경기',
    category: '맛집',
    description: '수원 유명 왕갈비 맛집에서 배부르게 먹고 산책하는 코스',
    cost: '2인 약 70,000원',
    time: '약 2시간 30분',
  ),
  DateCourse(
    title: '판교 맛집 거리 투어',
    region: '경기',
    category: '맛집',
    description: '판교 테크노밸리 근처 다양한 맛집을 탐방하는 코스',
    cost: '2인 약 55,000원',
    time: '약 3시간',
  ),

  // ── 경기 / 카페 ──
  DateCourse(
    title: '수원 행궁동 카페 거리',
    region: '경기',
    category: '카페',
    description: '행궁동 감성 카페와 골목 산책을 같이 즐기는 코스',
    cost: '2인 약 35,000원',
    time: '약 2시간 30분',
  ),
  DateCourse(
    title: '양평 강변 카페 드라이브',
    region: '경기',
    category: '카페',
    description: '양평 드라이브하며 강변 카페에서 여유로운 시간 보내기',
    cost: '2인 약 40,000원',
    time: '약 4시간',
  ),

  // ── 경기 / 액티비티 ──
  DateCourse(
    title: '클라이밍 체험 데이트',
    region: '경기',
    category: '액티비티',
    description: '처음 해도 재밌는 실내 클라이밍 액티비티 데이트',
    cost: '2인 약 60,000원',
    time: '약 2시간',
  ),
  DateCourse(
    title: '가평 래프팅 데이트',
    region: '경기',
    category: '액티비티',
    description: '가평에서 신나는 래프팅 후 닭갈비 먹는 여름 코스',
    cost: '2인 약 80,000원',
    time: '약 5시간',
  ),

  // ── 인천 / 실내 ──
  DateCourse(
    title: '인천 아트플랫폼 전시',
    region: '인천',
    category: '실내',
    description: '개항로 아트플랫폼에서 다양한 예술 전시를 함께 관람',
    cost: '2인 약 20,000원',
    time: '약 2시간',
  ),
  DateCourse(
    title: '송도 트리플스트리트 데이트',
    region: '인천',
    category: '실내',
    description: '송도 트리플스트리트에서 쇼핑하고 맛집까지 즐기는 코스',
    cost: '2인 약 55,000원',
    time: '약 3시간',
  ),

  // ── 인천 / 야외 ──
  DateCourse(
    title: '송도 센트럴파크 데이트',
    region: '인천',
    category: '야외',
    description: '송도 센트럴파크 산책 후 근처 맛집 가는 코스',
    cost: '2인 약 55,000원',
    time: '약 4시간',
  ),
  DateCourse(
    title: '인천 월미도 데이트',
    region: '인천',
    category: '야외',
    description: '월미도 해변 산책 후 놀이공원 탑승, 인근 먹거리 탐방',
    cost: '2인 약 40,000원',
    time: '약 3시간',
  ),

  // ── 인천 / 맛집 ──
  DateCourse(
    title: '인천 차이나타운 먹방 데이트',
    region: '인천',
    category: '맛집',
    description: '차이나타운에서 먹거리 돌고 사진 찍는 데이트 코스',
    cost: '2인 약 40,000원',
    time: '약 3시간',
  ),
  DateCourse(
    title: '소래포구 해산물 데이트',
    region: '인천',
    category: '맛집',
    description: '소래포구에서 신선한 해산물을 먹고 포구 산책까지',
    cost: '2인 약 60,000원',
    time: '약 3시간',
  ),

  // ── 인천 / 카페 ──
  DateCourse(
    title: '인천 개항로 카페 투어',
    region: '인천',
    category: '카페',
    description: '개항로 근대 건물을 개조한 감성 카페들을 투어하는 코스',
    cost: '2인 약 35,000원',
    time: '약 2시간 30분',
  ),
  DateCourse(
    title: '송도 오션뷰 카페',
    region: '인천',
    category: '카페',
    description: '송도 바다가 보이는 루프탑 카페에서 여유로운 티타임',
    cost: '2인 약 40,000원',
    time: '약 2시간',
  ),

  // ── 인천 / 액티비티 ──
  DateCourse(
    title: '볼링장 + 카페 데이트',
    region: '인천',
    category: '액티비티',
    description: '볼링으로 가볍게 놀고 카페에서 마무리하는 코스',
    cost: '2인 약 45,000원',
    time: '약 3시간',
  ),
  DateCourse(
    title: '인천 서핑 체험',
    region: '인천',
    category: '액티비티',
    description: '인천 실내 서핑 풀에서 서핑 체험 후 해산물 저녁',
    cost: '2인 약 90,000원',
    time: '약 4시간',
  ),
];

// ─────────────────────────────────────────────
// 홈 페이지
// ─────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> regions = ['서울', '경기', '인천'];
  final List<String> categories = ['실내', '야외', '맛집', '카페', '액티비티'];

  String selectedRegion = '서울';
  String selectedCategory = '실내';

  DateCourse? selectedCourse; // 최종 확정 코스
  DateCourse? slotCourse; // 슬롯 돌아가는 중 임시 코스
  final List<DateCourse> favorites = [];

  bool isSpinning = false;
  Timer? _slotTimer;
  bool _hasTriedOnce = false; // 최초 뽑기 전 안내 표시용

  @override
  void dispose() {
    _slotTimer?.cancel();
    super.dispose();
  }

  // ── 추천 로직 (풀백 포함) ──
  DateCourse _pickCourse() {
    final random = Random();

    // 1순위: 지역 + 카테고리 정확 매칭
    final exact = allCourses
        .where(
          (c) => c.region == selectedRegion && c.category == selectedCategory,
        )
        .toList();
    if (exact.isNotEmpty) return exact[random.nextInt(exact.length)];

    // 2순위: 지역만 매칭 (fallback)
    final byRegion = allCourses
        .where((c) => c.region == selectedRegion)
        .toList();
    if (byRegion.isNotEmpty) return byRegion[random.nextInt(byRegion.length)];

    // 3순위: 전체 랜덤 (최후 fallback)
    return allCourses[random.nextInt(allCourses.length)];
  }

  // ── 슬롯머신 연출 ──
  void _startSlot() {
    if (isSpinning) return;

    setState(() {
      isSpinning = true;
      _hasTriedOnce = true;
      selectedCourse = null;
    });

    final random = Random();
    int tick = 0;
    const totalTicks = 18; // 약 1.2초 (18 × 67ms)
    const tickInterval = Duration(milliseconds: 67);

    _slotTimer = Timer.periodic(tickInterval, (timer) {
      tick++;

      // 슬롯 중: 랜덤 코스 이름 빠르게 교체
      final tempList = allCourses.toList()..shuffle(random);
      setState(() {
        slotCourse = tempList.first;
      });

      if (tick >= totalTicks) {
        timer.cancel();
        final finalCourse = _pickCourse();
        setState(() {
          selectedCourse = finalCourse;
          slotCourse = null;
          isSpinning = false;
        });
      }
    });
  }

  // ── 즐겨찾기 토글 ──
  void _toggleFavorite() {
    if (selectedCourse == null) return;
    setState(() {
      if (favorites.contains(selectedCourse)) {
        favorites.remove(selectedCourse);
      } else {
        favorites.add(selectedCourse!);
      }
    });
  }

  // ── 선택된 코스가 즐겨찾기에 있는지 확인 ──
  bool get _isFavorite =>
      selectedCourse != null && favorites.contains(selectedCourse);

  // ─────────────────────────────────────────────
  // UI 빌드
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text(
          '🗺️ 랜덤플레이스',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더
            _buildHeader(),
            const SizedBox(height: 28),

            // 지역 선택
            _buildSectionLabel('📍 지역 선택'),
            const SizedBox(height: 10),
            _buildChips(regions, selectedRegion, (val) {
              setState(() {
                selectedRegion = val;
                selectedCourse = null;
                _hasTriedOnce = false;
              });
            }),
            const SizedBox(height: 22),

            // 카테고리 선택
            _buildSectionLabel('🏷️ 카테고리 선택'),
            const SizedBox(height: 10),
            _buildChips(categories, selectedCategory, (val) {
              setState(() {
                selectedCategory = val;
                selectedCourse = null;
                _hasTriedOnce = false;
              });
            }),
            const SizedBox(height: 28),

            // 뽑기 버튼
            _buildSpinButton(),
            const SizedBox(height: 28),

            // 결과 카드
            _buildResultCard(),
            const SizedBox(height: 30),

            // 즐겨찾기 섹션
            _buildFavoritesSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── 헤더 ──
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '오늘 어디 갈까? 🥰',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          '지역과 카테고리를 고르면 랜덤 데이트 코스를 추천해줄게.',
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  // ── 섹션 라벨 ──
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }

  // ── ChoiceChip 공통 빌더 ──
  Widget _buildChips(
    List<String> items,
    String selected,
    void Function(String) onSelect,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = item == selected;
        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          selectedColor: Colors.pinkAccent.shade100,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.pink.shade700 : Colors.grey.shade700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? Colors.pinkAccent : Colors.grey.shade300,
            ),
          ),
          onSelected: (_) => onSelect(item),
        );
      }).toList(),
    );
  }

  // ── 뽑기 버튼 ──
  Widget _buildSpinButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: isSpinning ? null : _startSlot,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSpinning
              ? Colors.grey.shade300
              : Colors.pinkAccent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: isSpinning ? 0 : 4,
        ),
        icon: Icon(isSpinning ? Icons.autorenew : Icons.casino, size: 24),
        label: Text(
          isSpinning ? '뽑는 중...' : '🎰 랜덤 데이트 뽑기',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ── 결과 카드 ──
  Widget _buildResultCard() {
    // 슬롯 돌아가는 중
    if (isSpinning && slotCourse != null) {
      return _slotSpinCard(slotCourse!);
    }

    // 최종 결과
    if (!isSpinning && selectedCourse != null) {
      return _resultCard(selectedCourse!);
    }

    // 초기 상태 (뽑기 전)
    if (!_hasTriedOnce) {
      return _emptyCard();
    }

    return const SizedBox.shrink();
  }

  // ── 초기 빈 카드 ──
  Widget _emptyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pink.shade100),
      ),
      child: Column(
        children: [
          Icon(Icons.favorite_border, size: 40, color: Colors.pink.shade200),
          const SizedBox(height: 12),
          const Text(
            '아직 추천 결과가 없어요.\n버튼을 눌러 랜덤 데이트를 뽑아보세요!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  // ── 슬롯 돌아가는 카드 ──
  Widget _slotSpinCard(DateCourse course) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pinkAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🎰', style: TextStyle(fontSize: 28)),
              SizedBox(width: 8),
              Text(
                '뽑는 중...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(width: 8),
              Text('🎰', style: TextStyle(fontSize: 28)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.pink.shade200),
            ),
            child: Text(
              course.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            backgroundColor: Colors.pink.shade100,
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }

  // ── 최종 결과 카드 ──
  Widget _resultCard(DateCourse course) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Row(
            children: [
              const Text('🎉 ', style: TextStyle(fontSize: 20)),
              Expanded(
                child: Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 정보 칩들
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _infoBadge(
                '📍 ${course.region}',
                Colors.blue.shade50,
                Colors.blue.shade700,
              ),
              _infoBadge(
                '🏷️ ${course.category}',
                Colors.green.shade50,
                Colors.green.shade700,
              ),
              _infoBadge(
                '💰 ${course.cost}',
                Colors.orange.shade50,
                Colors.orange.shade700,
              ),
              _infoBadge(
                '⏱️ ${course.time}',
                Colors.purple.shade50,
                Colors.purple.shade700,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 설명
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              course.description,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
          const SizedBox(height: 18),

          // 버튼 row
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isSpinning ? null : _startSlot,
                  icon: const Icon(Icons.refresh),
                  label: const Text('다시 뽑기'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.pink.shade300),
                    foregroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: Text(_isFavorite ? '저장됨' : '즐겨찾기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFavorite
                        ? Colors.pink.shade400
                        : Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── 정보 뱃지 ──
  Widget _infoBadge(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 13, color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ── 즐겨찾기 섹션 ──
  Widget _buildFavoritesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
            const SizedBox(width: 6),
            Text(
              '즐겨찾기 ${favorites.length}개',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (favorites.isEmpty)
          Text(
            '아직 저장한 코스가 없어요.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          )
        else
          Column(
            children: favorites.map((course) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  title: Text(
                    course.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${course.region} · ${course.category} · ${course.time}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.pinkAccent),
                    onPressed: () {
                      setState(() {
                        favorites.remove(course);
                        // 현재 선택된 코스가 삭제된 경우 상태 갱신 (UI 반영)
                        if (selectedCourse == course) {
                          selectedCourse = course; // 동일 객체 유지, isFavorite만 재계산됨
                        }
                      });
                    },
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
