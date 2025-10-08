import 'package:flutter/material.dart';
import 'package:mahjong/page_a.dart';
import 'package:mahjong/page_b.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

    int index = 0;

  final pages = const [
    PageA(),
    PageB(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            minWidth: 180,
            selectedIndex: index,
            onDestinationSelected: (i) => setState(() => index=i),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.looks_one),
                label: Text('Page1'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.looks_two),
                label: Text('Page2'),
              ),
            ],
            backgroundColor: Colors.lightGreen,
          ),

          Expanded(
            child: IndexedStack(
              index: index,
              children: pages,
            ),
          )
          
        ],
      ),
    );
  }
}