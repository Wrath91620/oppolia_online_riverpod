// drawer_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bottom_nav_provider.dart';
import 'package:oppolia_online/l10n/generated/app_localizations.dart';

class DrawerPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Image.asset('images/Oppolia-logo-website.png'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(AppLocalizations.of(context)!.home_title),
            onTap: () {
              Navigator.pop(context);
              ref.read(bottomNavIndexProvider.notifier).state = 0;
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppLocalizations.of(context)!.profile_title),
            onTap: () {
              Navigator.pop(context);
              ref.read(bottomNavIndexProvider.notifier).state = 1;
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(AppLocalizations.of(context)!.orders_title),
            onTap: () {
              Navigator.pop(context);
              ref.read(bottomNavIndexProvider.notifier).state = 2;
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(AppLocalizations.of(context)!.wishlist),
            onTap: () {
              Navigator.pop(context);
              ref.read(bottomNavIndexProvider.notifier).state = 3;
            },
          ),
        ],
      ),
    );
  }
}
