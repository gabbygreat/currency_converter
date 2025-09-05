import '../../../utils/utils.dart';

class ConvertSection extends StatelessWidget {
  final String title;
  final String currencyCode;
  final int position;
  final TextEditingController controller;
  final void Function(int) onSelection;
  const ConvertSection({
    super.key,
    required this.position,
    required this.title,
    required this.currencyCode,
    required this.controller,
    required this.onSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: 15.w400.x989898),
        14.sbH,
        Row(
          children: [
            CircleAvatar(radius: 45 / 2, backgroundColor: AppColors.x808080),
            13.sbW,
            InkWell(
              onTap: () => onSelection(position),
              child: Row(
                children: [
                  Text(currencyCode, style: 20.w500.x26278D),
                  Padding(
                    padding: EdgeInsetsGeometry.all(24.spMin),
                    child: Assets.svg.chevronDown.svg(),
                  ),
                ],
              ),
            ),
            16.sbW,
            Expanded(
              child: TextField(
                onTapUpOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                controller: controller,
                inputFormatters: [SinglePeriodEnforcer()],
                style: 20.w600.x3C3C3C,
                textAlign: TextAlign.end,
                cursorColor: AppColors.x000000,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  fillColor: AppColors.xEFEFEF,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7.spMin),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
