import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration:
          const BoxDecoration(image: DecorationImage(image: NetworkImage(''))),
      child: SafeArea(
        child: PageView(
          controller: _pageController,
          children: const [
            Page(pageNum: 0),
            Page(pageNum: 1),
          ],
        ),
      ),
    ));
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.pageNum});

  final int pageNum;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with TickerProviderStateMixin {
  late final List<AnimationController> _animationControllers;
  late final List<Animation<Offset>> _animationOffsets;

  final List<Offset> offsets = const [
    Offset(180, 40),
    Offset(240, 80),
    Offset(60, 200),
    Offset(240, 300),
    Offset(100, 380),
  ];

  void setUpControllers() {
    _animationControllers = List.generate(
      offsets.length,
      (index) {
        return AnimationController(
            vsync: this, duration: Duration(milliseconds: ((index) + 1) * 200));
      },
    );

    _animationOffsets = _animationControllers.map((controller) {
      return Tween<Offset>(
              begin: widget.pageNum == 0
                  ? const Offset(-1.0, 0)
                  : const Offset(1.0, 0),
              end: const Offset(0, 0))
          .animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    _animationControllers.forEach((controller) => controller.forward());
  }

  @override
  void initState() {
    setUpControllers();
    super.initState();
  }

  @override
  void dispose() {
    _animationControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(offsets.length, (index) {
      return AnimatedBuilder(
        animation: _animationOffsets[index],
        builder: (context, child) {
          return Positioned(
              left: offsets[index].dx +
                  (_animationOffsets[index].value.dx * offsets[index].dx),
              top: offsets[index].dy,
              child: child!);
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(
                  index * 2 + 30, index * 5 + 60, index * 30 + 50, 1)),
        ),
      );
    }));
  }
}
