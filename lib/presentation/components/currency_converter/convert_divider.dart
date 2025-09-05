import 'package:currency_converter/utils/utils.dart';

class ConvertDivider extends StatelessWidget {
  const ConvertDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.spMin,
      child: Stack(
        children: [
          Positioned.fill(child: Divider(endIndent: 0, indent: 0)),
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.x26278D,
              ),
              alignment: Alignment.center,
              child: Assets.svg.convert.svg(),
            ),
          ),
        ],
      ),
    );
  }
}
