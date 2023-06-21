import 'package:get/get.dart';
import '../languages/en.dart';
import '../languages/ar.dart';

class AppLocalization extends Translations{
  @override
  Map<String, Map<String, String>> get keys =>
      {
        'en' : en,
        'ar' : ar
      };
}