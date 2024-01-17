import 'package:flutter/material.dart';
import 'package:system_monitor/screens/device_screen.dart';
import 'package:system_monitor/screens/info_sims.dart';
import 'package:system_monitor/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Tab> tabs = [
    const Tab(child: Text('Tela Inicial')),
    const Tab(child: Text('Dispositivo')),
    const Tab(child: Text('Telefone')),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(
            'System Monitor',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: TabBar(
                unselectedLabelColor: Colors.white.withOpacity(.9),
                indicatorPadding: const EdgeInsets.only(bottom: 3),
                labelStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                indicatorColor: Colors.white,
                labelColor: Colors.white.withOpacity(.9),
                isScrollable: false,
                tabs: tabs),
          ),
        ),
        body: const TabBarView(
          children: [
            ScreenPage(),
            DeviceScreen(),
            InfoSims(),
          ],
        ),
      ),
    );
  }
}
