import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(360, 703),
        builder: (context, _) {
          return MaterialApp(title: AppConstant.title, home: HomeScreen());
        },
      ),
    );
  }
}
