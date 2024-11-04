import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:oppolia_online/l10n/generated/app_localizations.dart';

class OrderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!
            .orders_order_history), // Add an AppBar title if needed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Placeholder for future action, like navigating to order details or triggering API calls
              },
              child: Text(AppLocalizations.of(context)!.orders_order_history),
            ),
          ],
        ),
      ),
    );
  }
}
