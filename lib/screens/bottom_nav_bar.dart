import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oppolia_online/l10n/generated/app_localizations.dart';
import '../providers/bottom_nav_provider.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex =
        ref.watch(bottomNavIndexProvider); // Watch the current index provider

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home_title,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: AppLocalizations.of(context)!.profile_title,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: AppLocalizations.of(context)!.orders_title,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: AppLocalizations.of(context)!.wishlist,
        ),
      ],
      currentIndex: currentIndex, // Set the current index
      selectedItemColor: Colors.brown,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        ref.read(bottomNavIndexProvider.notifier).state =
            index; // Update the index
      },
    );
  }
}
