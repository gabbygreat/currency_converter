import 'package:lottie/lottie.dart';

import '../../utils/utils.dart';

class ErrorScreen extends StatefulWidget {
  final ErrorModel error;
  final VoidCallback onRefresh;

  const ErrorScreen({super.key, required this.error, required this.onRefresh});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final appError = widget.error;

    String imagePath = switch (appError.type) {
      DialogErrorType.error => Assets.animation.error,
      DialogErrorType.noInternet => Assets.animation.noInternet,
    };
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              imagePath,
              height: 100,
              fit: BoxFit.fill,
              width: 100,
            ),
            5.sbH,
            Text(appError.message, textAlign: TextAlign.center),
            20.sbH,
            ElevatedButton(
              onPressed: widget.onRefresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.x26278D,
                foregroundColor: AppColors.xFFFFFF,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                ),
              ),
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
