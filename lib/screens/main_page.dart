// main_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oppolia_online/screens/home_page.dart';
import 'package:oppolia_online/screens/order_page.dart';
import 'package:oppolia_online/screens/user_page.dart';
import 'package:oppolia_online/screens/wishlist_page.dart';

import '../providers/bottom_nav_provider.dart';
import 'drawer_page.dart';

class MainPage extends ConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    // Define the pages to display based on the selected index
    final List<Widget> pages = [
      HomePage(),
      UserPage(),
      OrderPage(),
      WishlistPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Wishlist'),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
      ),
      drawer: DrawerPage(), // Drawer with navigation options
    );
  }
}
