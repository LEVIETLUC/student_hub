import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_hub/view_models/nav_bottom_controller.dart';
import 'package:student_hub/views/pages/alert_page.dart';
import 'package:student_hub/views/pages/dashboard_page.dart';
import 'package:student_hub/views/pages/message_page.dart';
import 'package:student_hub/views/pages/projects_page.dart';
class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFBEEEF7),
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('assets/icons/user_ic.png'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomePageState extends State<HomePage> {
  final BottomNavController _navController = BottomNavController();
  final List<Widget> _pages = [
    ProjectsPage(),
    DashboardPage(),
    MessagePage(),
    AlertPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: PageView(
        controller: _navController.controller,
        children: _pages,
        physics: const NeverScrollableScrollPhysics(), // Prevent swiping between pages
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFBEEEF7),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: GNav(
            backgroundColor: const Color(0xFFBEEEF7),
            color: Colors.black.withOpacity(0.8),
            activeColor: Colors.black.withOpacity(0.8),
            tabBackgroundColor: const Color(0xFF69cde0).withOpacity(0.5),
            gap: 8,
            padding: const EdgeInsets.all(12),
            tabs: const [
              GButton(
                icon: Icons.list_alt_rounded,
                text: 'Projects',
              ),
              GButton(
                icon: Icons.dashboard_rounded,
                text: 'Dashboard',
              ),
              GButton(
                icon: Icons.messenger_outline_rounded,
                text: 'Message',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Alerts',
              ),
            ],
            selectedIndex: _navController.selectedIndex,
            onTabChange: (index) {
              setState(() {
                _navController.selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}