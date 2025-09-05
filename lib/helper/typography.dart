import '../utils/utils.dart';

extension StyleExt on int {
  TextStyle get w400 {
    return TextStyle(fontSize: spMin, fontWeight: FontWeight.w400);
  }

  TextStyle get w500 {
    return TextStyle(fontSize: spMin, fontWeight: FontWeight.w500);
  }

  TextStyle get w600 {
    return TextStyle(fontSize: spMin, fontWeight: FontWeight.w600);
  }

  TextStyle get w700 {
    return TextStyle(fontSize: spMin, fontWeight: FontWeight.w700);
  }

  TextStyle get w800 {
    return TextStyle(fontSize: spMin, fontWeight: FontWeight.w800);
  }
}

extension TypoColor on TextStyle {
  TextStyle get x1F2261 => copyWith(color: AppColors.x1F2261);
  TextStyle get x808080 => copyWith(color: AppColors.x808080);
  TextStyle get x989898 => copyWith(color: AppColors.x989898);
  TextStyle get x26278D => copyWith(color: AppColors.x26278D);
  TextStyle get xA1A1A1 => copyWith(color: AppColors.xA1A1A1);
  TextStyle get x000000 => copyWith(color: AppColors.x000000);
  TextStyle get x3C3C3C => copyWith(color: AppColors.x3C3C3C);
}
