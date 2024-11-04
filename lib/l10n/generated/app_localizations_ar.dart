import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home_title => 'الرئيسية';

  @override
  String get home_welcome_message => 'مرحبًا بك في صفحتك الرئيسية!';

  @override
  String get home_view_details => 'عرض التفاصيل';

  @override
  String get profile_title => 'الملف الشخصي';

  @override
  String get profile_name => 'الاسم';

  @override
  String get profile_email => 'البريد الإلكتروني';

  @override
  String get profile_phone => 'الهاتف';

  @override
  String get profile_address => 'العنوان';

  @override
  String get orders_title => 'الطلبات';

  @override
  String get orders_order_history => 'تاريخ الطلبات';

  @override
  String get orders_no_orders => 'لا توجد لديك طلبات بعد.';

  @override
  String get orders_view_order => 'عرض الطلب';

  @override
  String get wishlist => 'قائمة الرغبات';
}
