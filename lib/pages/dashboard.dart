import 'package:cinema/const.dart';
import 'package:cinema/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<IconData> buttomNavBarIcon = [
    Icons.home_filled,
    CupertinoIcons.compass_fill,
    CupertinoIcons.ticket_fill,
    Icons.person,
  ];
  int currentIndex = 0;
  Widget body(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const Center(
          child: Text('Detail'),
        );
      case 2:
        return const Center(
          child: Text('Ticket'),
        );
      case 3:
        return const Center(
          child: Text('Profile'),
        );
      default:
        return const Center(
          child: Text('Something Wrong'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(currentIndex),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(buttomNavBarIcon.length, (index) {
            bool isActive = index == currentIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? 30 : 0,
                    height: isActive ? 30 : 0,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          color: orange.withOpacity(0.2),
                          blurRadius: isActive ? 5 : 0,
                          spreadRadius: isActive ? 3 : 0)
                    ]),
                  ),
                  Icon(
                    buttomNavBarIcon[index],
                    color: isActive ? orange : Colors.grey,
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
