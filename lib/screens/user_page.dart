import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oppolia_online/l10n/generated/app_localizations.dart';
import 'package:oppolia_online/providers/user_provider.dart';
import 'package:oppolia_online/screens/edit_profile_page.dart';

class UserPage extends ConsumerStatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  void initState() {
    super.initState();
    // Fetch user data when the page loads
    ref.read(userProvider.notifier).fetchUser();
  }

  void _updateUserInfo(User updatedUser) {
    ref.read(userProvider.notifier).updateUser(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              if (user != null) {
                // Navigate to EditProfilePage and wait for updated info
                final updatedInfo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: user.name,
                      email: user.email,
                      phone: user.phone,
                      address: user.address,
                      location: user.location,
                    ),
                  ),
                );

                // Update user information if edited
                if (updatedInfo != null) {
                  final updatedUser = User(
                    name: updatedInfo['name']!,
                    email: updatedInfo['email']!,
                    phone: updatedInfo['phone']!,
                    address: updatedInfo['address']!,
                    location:
                        user.location, // or updatedInfo['location'] if editable
                  );
                  _updateUserInfo(updatedUser);
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildUserInfoRow(
              Icons.person,
              AppLocalizations.of(context)!.profile_name,
              user?.name,
            ),
            SizedBox(height: 10),
            buildUserInfoRow(
              Icons.email,
              AppLocalizations.of(context)!.profile_email,
              user?.email,
            ),
            SizedBox(height: 10),
            buildUserInfoRow(
              Icons.phone,
              AppLocalizations.of(context)!.profile_phone,
              user?.phone,
            ),
            SizedBox(height: 10),
            buildUserInfoRow(
              Icons.location_on,
              AppLocalizations.of(context)!.profile_address,
              user?.address,
            ),
          ],
        ),
      ),
    );
  }

  // Modify buildUserInfoRow to show "No user data found" if data is null
  Widget buildUserInfoRow(IconData icon, String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.brown),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 5),
              Text(
                value ??
                    'No user data found', // Show hint text if value is null
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
