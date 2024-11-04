import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oppolia_online/providers/wishlist_provider.dart';

class WishlistPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider); // Watch the wishlist provider

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border_outlined),
            onPressed: () {
              // Add a new item for demonstration purposes
              ref
                  .read(wishlistProvider.notifier)
                  .update((state) => [...state, 'New Wishlist Item']);
            },
          ),
        ],
      ),
      body: wishlist.isEmpty
          ? Center(
              child: Text('Your wishlist is empty.'),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(wishlist[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Remove the item from the wishlist
                      ref.read(wishlistProvider.notifier).update((state) =>
                          state
                              .where((item) => item != wishlist[index])
                              .toList());
                    },
                  ),
                );
              },
            ),
    );
  }
}
