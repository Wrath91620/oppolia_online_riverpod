import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:oppolia_online/l10n/generated/app_localizations.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home_title),
      ),
      // drawer: DrawerPage(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.home_welcome_message),
            ElevatedButton(
              onPressed: () {
                // Placeholder for any future action or navigation
              },
              child: Text(AppLocalizations.of(context)!.home_view_details),
            ),
          ],
        ),
      ),
    );
  }
}
