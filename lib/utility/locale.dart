import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home': 'Home',
          'favorite': 'Favorite',
          'cart': 'Cart',
          'profile': 'Profile',
        },
        'hi_IN': {
          'home': 'होम',
          'favorite': 'पसंदीदा',
          'cart': 'कार्ट',
          'profile': 'प्रोफाइल',
        },
      };
}
