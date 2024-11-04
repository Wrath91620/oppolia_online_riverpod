import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home_title => 'Home';

  @override
  String get home_welcome_message => 'Welcome to your home page!';

  @override
  String get home_view_details => 'View Details';

  @override
  String get profile_title => 'Profile';

  @override
  String get profile_name => 'Name';

  @override
  String get profile_email => 'Email';

  @override
  String get profile_phone => 'Phone';

  @override
  String get profile_address => 'Address';

  @override
  String get orders_title => 'Orders';

  @override
  String get orders_order_history => 'Order History';

  @override
  String get orders_no_orders => 'You have no orders yet.';

  @override
  String get orders_view_order => 'View Order';

  @override
  String get wishlist => 'Wishlist';
}
