import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oppolia_online/l10n/generated/app_localizations.dart';
import 'package:oppolia_online/screens/authentication_page.dart';
import 'package:oppolia_online/screens/main_page.dart';
import 'package:oppolia_online/constants/locale_constants.dart'; // Import LocaleConstants
import 'package:oppolia_online/screens/splashscreen.dart';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  Future<bool> isOtpVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('otpVerified') ??
        false; // Defaults to false if not set
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return FutureBuilder<bool>(
      future: isOtpVerified(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        //final initialPage = snapshot.data == true ? MainPage() : AuthPage();

        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales:
              LocaleConstants.supportedLocales, // Use LocaleConstants here
          title: 'Oppolia Online',
          theme: ThemeData(primarySwatch: Colors.brown),
          locale: locale,
          home: SplashScreen(),
          builder: (context, child) {
            return Directionality(
              textDirection: locale.languageCode == 'ar'
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
              child: child!,
            );
          },
        );
      },
    );
  }
}

// Locale provider
class LocaleProvider extends StateNotifier<Locale> {
  LocaleProvider() : super(const Locale(LocaleConstants.defaultLanguageCode));

  void toggleLocale() {
    state = state.languageCode == 'en' ? Locale('ar') : Locale('en');
  }
}

final localeProvider =
    StateNotifierProvider<LocaleProvider, Locale>((ref) => LocaleProvider());
