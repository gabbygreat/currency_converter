import 'package:currency_converter/domain/exchange_rate_use_cases.dart';
import 'package:currency_converter/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late StateNotifierProvider<HomeViewModel, HomeState> userViewModelProvider;

  @override
  void initState() {
    super.initState();
    userViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((
      ref,
    ) {
      return HomeViewModel(
        ExchangeRateUseCase(locator<ExchangeRateApiService>()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(userViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.xF6F6F6,
      body: Stack(
        children: [
          CircleGradient(),
          Positioned.fill(
            child: SafeArea(
              top: false,
              bottom: false,
              child: homeState.when(
                initial: () => SizedBox(),
                loading: () => Center(
                  child: CircularProgressIndicator(color: AppColors.x26278D),
                ),
                loaded: (supportedCodes) =>
                    CurrencyConverter(conversionRates: supportedCodes),
                error: (error) => ErrorScreen(
                  error: error,
                  onRefresh: () => ref.invalidate(userViewModelProvider),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
