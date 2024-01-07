import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    controller!.addListener(tabListener);
  }

  tabListener() {
    // 리스너 함수
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: 1),
      SettinsScreen(threshold: threshold, onThresholdChange: onThresholdChange)
    ];
  }

  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }
}
