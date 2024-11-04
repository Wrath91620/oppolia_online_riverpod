import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistProvider = StateProvider<List<String>>(
    (ref) => []); // A list of strings for simplicity
