import 'package:flutter/material.dart';
import 'package:best_practices/ui/core/themes/tailwind_colors.dart';

class TailwindColorTheme extends ThemeExtension<TailwindColorTheme> {
  // Base colors
  final Color white;
  final Color black;

  // Gray scale backgrounds
  final Color bgWhite;
  final Color bgGray50;
  final Color bgGray100;
  final Color bgGray200;
  final Color bgGray300;
  final Color bgGray400;
  final Color bgGray500;
  final Color bgGray600;
  final Color bgGray700;
  final Color bgGray800;
  final Color bgGray900;

  // Gray scale text
  final Color textBlack;
  final Color textWhite;
  final Color textGray900;
  final Color textGray800;
  final Color textGray700;
  final Color textGray600;
  final Color textGray500;
  final Color textGray400;
  final Color textGray300;

  // Gray scale borders
  final Color borderGray100;
  final Color borderGray200;
  final Color borderGray300;
  final Color borderGray400;
  final Color borderGray500;
  final Color borderGray600;
  final Color borderGray700;

  // Blue backgrounds
  final Color bgBlue50;
  final Color bgBlue100;
  final Color bgBlue200;
  final Color bgBlue500;
  final Color bgBlue600;
  final Color bgBlue700;

  // Blue text
  final Color textBlue500;
  final Color textBlue600;
  final Color textBlue700;
  final Color textBlue800;
  final Color textBlue900;

  // Blue borders
  final Color borderBlue200;
  final Color borderBlue300;
  final Color borderBlue500;

  // Green backgrounds
  final Color bgGreen50;
  final Color bgGreen100;
  final Color bgGreen200;
  final Color bgGreen500;
  final Color bgGreen600;

  // Green text
  final Color textGreen500;
  final Color textGreen600;
  final Color textGreen700;
  final Color textGreen800;

  // Green borders
  final Color borderGreen200;
  final Color borderGreen300;
  final Color borderGreen500;

  // Red backgrounds
  final Color bgRed50;
  final Color bgRed100;
  final Color bgRed200;
  final Color bgRed500;
  final Color bgRed600;

  // Red text
  final Color textRed500;
  final Color textRed600;
  final Color textRed700;
  final Color textRed800;

  // Red borders
  final Color borderRed200;
  final Color borderRed300;
  final Color borderRed500;

  // Yellow backgrounds
  final Color bgYellow50;
  final Color bgYellow100;
  final Color bgYellow200;

  // Yellow text
  final Color textYellow600;
  final Color textYellow700;
  final Color textYellow800;

  // Yellow borders
  final Color borderYellow200;
  final Color borderYellow300;

  // Amber backgrounds
  final Color bgAmber50;
  final Color bgAmber100;

  // Amber text
  final Color textAmber600;
  final Color textAmber700;

  // Amber borders
  final Color borderAmber300;

  // Purple backgrounds
  final Color bgPurple50;
  final Color bgPurple100;
  final Color bgPurple500;
  final Color bgPurple600;

  // Purple text
  final Color textPurple600;
  final Color textPurple700;

  // Purple borders
  final Color borderPurple200;
  final Color borderPurple300;

  // Indigo backgrounds
  final Color bgIndigo50;
  final Color bgIndigo100;
  final Color bgIndigo500;
  final Color bgIndigo600;

  // Indigo text
  final Color textIndigo600;
  final Color textIndigo700;

  // Violet backgrounds
  final Color bgViolet50;
  final Color bgViolet100;
  final Color bgViolet500;

  // Violet text
  final Color textViolet600;

  // Cyan backgrounds
  final Color bgCyan50;
  final Color bgCyan100;
  final Color bgCyan500;

  // Cyan text
  final Color textCyan600;
  final Color textCyan700;

  // Teal backgrounds
  final Color bgTeal50;
  final Color bgTeal100;
  final Color bgTeal500;

  // Teal text
  final Color textTeal600;

  // Sky backgrounds
  final Color bgSky50;
  final Color bgSky100;
  final Color bgSky500;

  // Sky text
  final Color textSky600;

  // Orange backgrounds
  final Color bgOrange50;
  final Color bgOrange100;
  final Color bgOrange500;

  // Orange text
  final Color textOrange600;
  final Color textOrange700;

  // Rose backgrounds
  final Color bgRose50;
  final Color bgRose100;
  final Color bgRose500;

  // Rose text
  final Color textRose600;

  // Pink backgrounds
  final Color bgPink50;
  final Color bgPink100;
  final Color bgPink500;

  // Pink text
  final Color textPink600;

  // Lime backgrounds
  final Color bgLime50;
  final Color bgLime100;
  final Color bgLime500;

  // Lime text
  final Color textLime600;

  // Emerald backgrounds
  final Color bgEmerald50;
  final Color bgEmerald100;
  final Color bgEmerald500;

  // Emerald text
  final Color textEmerald600;

  // Hover states
  final Color hoverBgGray50;
  final Color hoverBgGray100;

  // Ring colors
  final Color ringBlue500;
  final Color ringBlue400;

  TailwindColorTheme({
    // Base colors - Light mode defaults
    this.white = MyColors.white,
    this.black = MyColors.black,

    // Gray scale backgrounds - Light mode defaults
    this.bgWhite = MyColors.white,
    this.bgGray50 = MyColors.gray50,
    this.bgGray100 = MyColors.gray100,
    this.bgGray200 = MyColors.gray200,
    this.bgGray300 = MyColors.gray300,
    this.bgGray400 = MyColors.gray400,
    this.bgGray500 = MyColors.gray500,
    this.bgGray600 = MyColors.gray600,
    this.bgGray700 = MyColors.gray700,
    this.bgGray800 = MyColors.gray800,
    this.bgGray900 = MyColors.gray900,

    // Gray scale text - Light mode defaults
    this.textBlack = MyColors.black,
    this.textWhite = MyColors.white,
    this.textGray900 = MyColors.gray900,
    this.textGray800 = MyColors.gray800,
    this.textGray700 = MyColors.gray700,
    this.textGray600 = MyColors.gray600,
    this.textGray500 = MyColors.gray500,
    this.textGray400 = MyColors.gray400,
    this.textGray300 = MyColors.gray300,

    // Gray scale borders - Light mode defaults
    this.borderGray100 = MyColors.gray100,
    this.borderGray200 = MyColors.gray200,
    this.borderGray300 = MyColors.gray300,
    this.borderGray400 = MyColors.gray400,
    this.borderGray500 = MyColors.gray500,
    this.borderGray600 = MyColors.gray600,
    this.borderGray700 = MyColors.gray700,

    // Blue backgrounds - Light mode defaults
    this.bgBlue50 = MyColors.blue50,
    this.bgBlue100 = MyColors.blue100,
    this.bgBlue200 = MyColors.blue200,
    this.bgBlue500 = MyColors.blue500,
    this.bgBlue600 = MyColors.blue600,
    this.bgBlue700 = MyColors.blue700,

    // Blue text - Light mode defaults
    this.textBlue500 = MyColors.blue500,
    this.textBlue600 = MyColors.blue600,
    this.textBlue700 = MyColors.blue700,
    this.textBlue800 = MyColors.blue800,
    this.textBlue900 = MyColors.blue900,

    // Blue borders - Light mode defaults
    this.borderBlue200 = MyColors.blue200,
    this.borderBlue300 = MyColors.blue300,
    this.borderBlue500 = MyColors.blue500,

    // Green backgrounds - Light mode defaults
    this.bgGreen50 = MyColors.green50,
    this.bgGreen100 = MyColors.green100,
    this.bgGreen200 = MyColors.green200,
    this.bgGreen500 = MyColors.green500,
    this.bgGreen600 = MyColors.green600,

    // Green text - Light mode defaults
    this.textGreen500 = MyColors.green500,
    this.textGreen600 = MyColors.green600,
    this.textGreen700 = MyColors.green700,
    this.textGreen800 = MyColors.green800,

    // Green borders - Light mode defaults
    this.borderGreen200 = MyColors.green200,
    this.borderGreen300 = MyColors.green300,
    this.borderGreen500 = MyColors.green500,

    // Red backgrounds - Light mode defaults
    this.bgRed50 = MyColors.red50,
    this.bgRed100 = MyColors.red100,
    this.bgRed200 = MyColors.red200,
    this.bgRed500 = MyColors.red500,
    this.bgRed600 = MyColors.red600,

    // Red text - Light mode defaults
    this.textRed500 = MyColors.red500,
    this.textRed600 = MyColors.red600,
    this.textRed700 = MyColors.red700,
    this.textRed800 = MyColors.red800,

    // Red borders - Light mode defaults
    this.borderRed200 = MyColors.red200,
    this.borderRed300 = MyColors.red300,
    this.borderRed500 = MyColors.red500,

    // Yellow backgrounds - Light mode defaults
    this.bgYellow50 = MyColors.yellow50,
    this.bgYellow100 = MyColors.yellow100,
    this.bgYellow200 = MyColors.yellow200,

    // Yellow text - Light mode defaults
    this.textYellow600 = MyColors.yellow600,
    this.textYellow700 = MyColors.yellow700,
    this.textYellow800 = MyColors.yellow800,

    // Yellow borders - Light mode defaults
    this.borderYellow200 = MyColors.yellow200,
    this.borderYellow300 = MyColors.yellow300,

    // Amber backgrounds - Light mode defaults
    this.bgAmber50 = MyColors.amber50,
    this.bgAmber100 = MyColors.amber100,

    // Amber text - Light mode defaults
    this.textAmber600 = MyColors.amber600,
    this.textAmber700 = MyColors.amber700,

    // Amber borders - Light mode defaults
    this.borderAmber300 = MyColors.amber300,

    // Purple backgrounds - Light mode defaults
    this.bgPurple50 = MyColors.purple50,
    this.bgPurple100 = MyColors.purple100,
    this.bgPurple500 = MyColors.purple500,
    this.bgPurple600 = MyColors.purple600,

    // Purple text - Light mode defaults
    this.textPurple600 = MyColors.purple600,
    this.textPurple700 = MyColors.purple700,

    // Purple borders - Light mode defaults
    this.borderPurple200 = MyColors.purple200,
    this.borderPurple300 = MyColors.purple300,

    // Indigo backgrounds - Light mode defaults
    this.bgIndigo50 = MyColors.indigo50,
    this.bgIndigo100 = MyColors.indigo100,
    this.bgIndigo500 = MyColors.indigo500,
    this.bgIndigo600 = MyColors.indigo600,

    // Indigo text - Light mode defaults
    this.textIndigo600 = MyColors.indigo600,
    this.textIndigo700 = MyColors.indigo700,

    // Violet backgrounds - Light mode defaults
    this.bgViolet50 = MyColors.violet50,
    this.bgViolet100 = MyColors.violet100,
    this.bgViolet500 = MyColors.violet500,

    // Violet text - Light mode defaults
    this.textViolet600 = MyColors.violet600,

    // Cyan backgrounds - Light mode defaults
    this.bgCyan50 = MyColors.cyan50,
    this.bgCyan100 = MyColors.cyan100,
    this.bgCyan500 = MyColors.cyan500,

    // Cyan text - Light mode defaults
    this.textCyan600 = MyColors.cyan600,
    this.textCyan700 = MyColors.cyan700,

    // Teal backgrounds - Light mode defaults
    this.bgTeal50 = MyColors.teal50,
    this.bgTeal100 = MyColors.teal100,
    this.bgTeal500 = MyColors.teal500,

    // Teal text - Light mode defaults
    this.textTeal600 = MyColors.teal600,

    // Sky backgrounds - Light mode defaults
    this.bgSky50 = MyColors.sky50,
    this.bgSky100 = MyColors.sky100,
    this.bgSky500 = MyColors.sky500,

    // Sky text - Light mode defaults
    this.textSky600 = MyColors.sky600,

    // Orange backgrounds - Light mode defaults
    this.bgOrange50 = MyColors.orange50,
    this.bgOrange100 = MyColors.orange100,
    this.bgOrange500 = MyColors.orange500,

    // Orange text - Light mode defaults
    this.textOrange600 = MyColors.orange600,
    this.textOrange700 = MyColors.orange700,

    // Rose backgrounds - Light mode defaults
    this.bgRose50 = MyColors.rose50,
    this.bgRose100 = MyColors.rose100,
    this.bgRose500 = MyColors.rose500,

    // Rose text - Light mode defaults
    this.textRose600 = MyColors.rose600,

    // Pink backgrounds - Light mode defaults
    this.bgPink50 = MyColors.pink50,
    this.bgPink100 = MyColors.pink100,
    this.bgPink500 = MyColors.pink500,

    // Pink text - Light mode defaults
    this.textPink600 = MyColors.pink600,

    // Lime backgrounds - Light mode defaults
    this.bgLime50 = MyColors.lime50,
    this.bgLime100 = MyColors.lime100,
    this.bgLime500 = MyColors.lime500,

    // Lime text - Light mode defaults
    this.textLime600 = MyColors.lime600,

    // Emerald backgrounds - Light mode defaults
    this.bgEmerald50 = MyColors.emerald50,
    this.bgEmerald100 = MyColors.emerald100,
    this.bgEmerald500 = MyColors.emerald500,

    // Emerald text - Light mode defaults
    this.textEmerald600 = MyColors.emerald600,

    // Hover states - Light mode defaults
    this.hoverBgGray50 = MyColors.gray50,
    this.hoverBgGray100 = MyColors.gray100,

    // Ring colors - Light mode defaults
    this.ringBlue500 = MyColors.blue500,
    this.ringBlue400 = MyColors.blue400,
  });

  @override
  ThemeExtension<TailwindColorTheme> copyWith({
    Color? white,
    Color? black,
    Color? bgWhite,
    Color? bgGray50,
    Color? bgGray100,
    Color? bgGray200,
    Color? bgGray300,
    Color? bgGray400,
    Color? bgGray500,
    Color? bgGray600,
    Color? bgGray700,
    Color? bgGray800,
    Color? bgGray900,
    Color? textBlack,
    Color? textWhite,
    Color? textGray900,
    Color? textGray800,
    Color? textGray700,
    Color? textGray600,
    Color? textGray500,
    Color? textGray400,
    Color? textGray300,
    Color? borderGray100,
    Color? borderGray200,
    Color? borderGray300,
    Color? borderGray400,
    Color? borderGray500,
    Color? borderGray600,
    Color? borderGray700,
    Color? bgBlue50,
    Color? bgBlue100,
    Color? bgBlue200,
    Color? bgBlue500,
    Color? bgBlue600,
    Color? bgBlue700,
    Color? textBlue500,
    Color? textBlue600,
    Color? textBlue700,
    Color? textBlue800,
    Color? textBlue900,
    Color? borderBlue200,
    Color? borderBlue300,
    Color? borderBlue500,
    Color? bgGreen50,
    Color? bgGreen100,
    Color? bgGreen200,
    Color? bgGreen500,
    Color? bgGreen600,
    Color? textGreen500,
    Color? textGreen600,
    Color? textGreen700,
    Color? textGreen800,
    Color? borderGreen200,
    Color? borderGreen300,
    Color? borderGreen500,
    Color? bgRed50,
    Color? bgRed100,
    Color? bgRed200,
    Color? bgRed500,
    Color? bgRed600,
    Color? textRed500,
    Color? textRed600,
    Color? textRed700,
    Color? textRed800,
    Color? borderRed200,
    Color? borderRed300,
    Color? borderRed500,
    Color? bgYellow50,
    Color? bgYellow100,
    Color? bgYellow200,
    Color? textYellow600,
    Color? textYellow700,
    Color? textYellow800,
    Color? borderYellow200,
    Color? borderYellow300,
    Color? bgAmber50,
    Color? bgAmber100,
    Color? textAmber600,
    Color? textAmber700,
    Color? borderAmber300,
    Color? bgPurple50,
    Color? bgPurple100,
    Color? bgPurple500,
    Color? bgPurple600,
    Color? textPurple600,
    Color? textPurple700,
    Color? borderPurple200,
    Color? borderPurple300,
    Color? bgIndigo50,
    Color? bgIndigo100,
    Color? bgIndigo500,
    Color? bgIndigo600,
    Color? textIndigo600,
    Color? textIndigo700,
    Color? bgViolet50,
    Color? bgViolet100,
    Color? bgViolet500,
    Color? textViolet600,
    Color? bgCyan50,
    Color? bgCyan100,
    Color? bgCyan500,
    Color? textCyan600,
    Color? textCyan700,
    Color? bgTeal50,
    Color? bgTeal100,
    Color? bgTeal500,
    Color? textTeal600,
    Color? bgSky50,
    Color? bgSky100,
    Color? bgSky500,
    Color? textSky600,
    Color? bgOrange50,
    Color? bgOrange100,
    Color? bgOrange500,
    Color? textOrange600,
    Color? textOrange700,
    Color? bgRose50,
    Color? bgRose100,
    Color? bgRose500,
    Color? textRose600,
    Color? bgPink50,
    Color? bgPink100,
    Color? bgPink500,
    Color? textPink600,
    Color? bgLime50,
    Color? bgLime100,
    Color? bgLime500,
    Color? textLime600,
    Color? bgEmerald50,
    Color? bgEmerald100,
    Color? bgEmerald500,
    Color? textEmerald600,
    Color? hoverBgGray50,
    Color? hoverBgGray100,
    Color? ringBlue500,
    Color? ringBlue400,
  }) {
    return TailwindColorTheme(
      white: white ?? this.white,
      black: black ?? this.black,
      bgWhite: bgWhite ?? this.bgWhite,
      bgGray50: bgGray50 ?? this.bgGray50,
      bgGray100: bgGray100 ?? this.bgGray100,
      bgGray200: bgGray200 ?? this.bgGray200,
      bgGray300: bgGray300 ?? this.bgGray300,
      bgGray400: bgGray400 ?? this.bgGray400,
      bgGray500: bgGray500 ?? this.bgGray500,
      bgGray600: bgGray600 ?? this.bgGray600,
      bgGray700: bgGray700 ?? this.bgGray700,
      bgGray800: bgGray800 ?? this.bgGray800,
      bgGray900: bgGray900 ?? this.bgGray900,
      textBlack: textBlack ?? this.textBlack,
      textWhite: textWhite ?? this.textWhite,
      textGray900: textGray900 ?? this.textGray900,
      textGray800: textGray800 ?? this.textGray800,
      textGray700: textGray700 ?? this.textGray700,
      textGray600: textGray600 ?? this.textGray600,
      textGray500: textGray500 ?? this.textGray500,
      textGray400: textGray400 ?? this.textGray400,
      textGray300: textGray300 ?? this.textGray300,
      borderGray100: borderGray100 ?? this.borderGray100,
      borderGray200: borderGray200 ?? this.borderGray200,
      borderGray300: borderGray300 ?? this.borderGray300,
      borderGray400: borderGray400 ?? this.borderGray400,
      borderGray500: borderGray500 ?? this.borderGray500,
      borderGray600: borderGray600 ?? this.borderGray600,
      borderGray700: borderGray700 ?? this.borderGray700,
      bgBlue50: bgBlue50 ?? this.bgBlue50,
      bgBlue100: bgBlue100 ?? this.bgBlue100,
      bgBlue200: bgBlue200 ?? this.bgBlue200,
      bgBlue500: bgBlue500 ?? this.bgBlue500,
      bgBlue600: bgBlue600 ?? this.bgBlue600,
      bgBlue700: bgBlue700 ?? this.bgBlue700,
      textBlue500: textBlue500 ?? this.textBlue500,
      textBlue600: textBlue600 ?? this.textBlue600,
      textBlue700: textBlue700 ?? this.textBlue700,
      textBlue800: textBlue800 ?? this.textBlue800,
      textBlue900: textBlue900 ?? this.textBlue900,
      borderBlue200: borderBlue200 ?? this.borderBlue200,
      borderBlue300: borderBlue300 ?? this.borderBlue300,
      borderBlue500: borderBlue500 ?? this.borderBlue500,
      bgGreen50: bgGreen50 ?? this.bgGreen50,
      bgGreen100: bgGreen100 ?? this.bgGreen100,
      bgGreen200: bgGreen200 ?? this.bgGreen200,
      bgGreen500: bgGreen500 ?? this.bgGreen500,
      bgGreen600: bgGreen600 ?? this.bgGreen600,
      textGreen500: textGreen500 ?? this.textGreen500,
      textGreen600: textGreen600 ?? this.textGreen600,
      textGreen700: textGreen700 ?? this.textGreen700,
      textGreen800: textGreen800 ?? this.textGreen800,
      borderGreen200: borderGreen200 ?? this.borderGreen200,
      borderGreen300: borderGreen300 ?? this.borderGreen300,
      borderGreen500: borderGreen500 ?? this.borderGreen500,
      bgRed50: bgRed50 ?? this.bgRed50,
      bgRed100: bgRed100 ?? this.bgRed100,
      bgRed200: bgRed200 ?? this.bgRed200,
      bgRed500: bgRed500 ?? this.bgRed500,
      bgRed600: bgRed600 ?? this.bgRed600,
      textRed500: textRed500 ?? this.textRed500,
      textRed600: textRed600 ?? this.textRed600,
      textRed700: textRed700 ?? this.textRed700,
      textRed800: textRed800 ?? this.textRed800,
      borderRed200: borderRed200 ?? this.borderRed200,
      borderRed300: borderRed300 ?? this.borderRed300,
      borderRed500: borderRed500 ?? this.borderRed500,
      bgYellow50: bgYellow50 ?? this.bgYellow50,
      bgYellow100: bgYellow100 ?? this.bgYellow100,
      bgYellow200: bgYellow200 ?? this.bgYellow200,
      textYellow600: textYellow600 ?? this.textYellow600,
      textYellow700: textYellow700 ?? this.textYellow700,
      textYellow800: textYellow800 ?? this.textYellow800,
      borderYellow200: borderYellow200 ?? this.borderYellow200,
      borderYellow300: borderYellow300 ?? this.borderYellow300,
      bgAmber50: bgAmber50 ?? this.bgAmber50,
      bgAmber100: bgAmber100 ?? this.bgAmber100,
      textAmber600: textAmber600 ?? this.textAmber600,
      textAmber700: textAmber700 ?? this.textAmber700,
      borderAmber300: borderAmber300 ?? this.borderAmber300,
      bgPurple50: bgPurple50 ?? this.bgPurple50,
      bgPurple100: bgPurple100 ?? this.bgPurple100,
      bgPurple500: bgPurple500 ?? this.bgPurple500,
      bgPurple600: bgPurple600 ?? this.bgPurple600,
      textPurple600: textPurple600 ?? this.textPurple600,
      textPurple700: textPurple700 ?? this.textPurple700,
      borderPurple200: borderPurple200 ?? this.borderPurple200,
      borderPurple300: borderPurple300 ?? this.borderPurple300,
      bgIndigo50: bgIndigo50 ?? this.bgIndigo50,
      bgIndigo100: bgIndigo100 ?? this.bgIndigo100,
      bgIndigo500: bgIndigo500 ?? this.bgIndigo500,
      bgIndigo600: bgIndigo600 ?? this.bgIndigo600,
      textIndigo600: textIndigo600 ?? this.textIndigo600,
      textIndigo700: textIndigo700 ?? this.textIndigo700,
      bgViolet50: bgViolet50 ?? this.bgViolet50,
      bgViolet100: bgViolet100 ?? this.bgViolet100,
      bgViolet500: bgViolet500 ?? this.bgViolet500,
      textViolet600: textViolet600 ?? this.textViolet600,
      bgCyan50: bgCyan50 ?? this.bgCyan50,
      bgCyan100: bgCyan100 ?? this.bgCyan100,
      bgCyan500: bgCyan500 ?? this.bgCyan500,
      textCyan600: textCyan600 ?? this.textCyan600,
      textCyan700: textCyan700 ?? this.textCyan700,
      bgTeal50: bgTeal50 ?? this.bgTeal50,
      bgTeal100: bgTeal100 ?? this.bgTeal100,
      bgTeal500: bgTeal500 ?? this.bgTeal500,
      textTeal600: textTeal600 ?? this.textTeal600,
      bgSky50: bgSky50 ?? this.bgSky50,
      bgSky100: bgSky100 ?? this.bgSky100,
      bgSky500: bgSky500 ?? this.bgSky500,
      textSky600: textSky600 ?? this.textSky600,
      bgOrange50: bgOrange50 ?? this.bgOrange50,
      bgOrange100: bgOrange100 ?? this.bgOrange100,
      bgOrange500: bgOrange500 ?? this.bgOrange500,
      textOrange600: textOrange600 ?? this.textOrange600,
      textOrange700: textOrange700 ?? this.textOrange700,
      bgRose50: bgRose50 ?? this.bgRose50,
      bgRose100: bgRose100 ?? this.bgRose100,
      bgRose500: bgRose500 ?? this.bgRose500,
      textRose600: textRose600 ?? this.textRose600,
      bgPink50: bgPink50 ?? this.bgPink50,
      bgPink100: bgPink100 ?? this.bgPink100,
      bgPink500: bgPink500 ?? this.bgPink500,
      textPink600: textPink600 ?? this.textPink600,
      bgLime50: bgLime50 ?? this.bgLime50,
      bgLime100: bgLime100 ?? this.bgLime100,
      bgLime500: bgLime500 ?? this.bgLime500,
      textLime600: textLime600 ?? this.textLime600,
      bgEmerald50: bgEmerald50 ?? this.bgEmerald50,
      bgEmerald100: bgEmerald100 ?? this.bgEmerald100,
      bgEmerald500: bgEmerald500 ?? this.bgEmerald500,
      textEmerald600: textEmerald600 ?? this.textEmerald600,
      hoverBgGray50: hoverBgGray50 ?? this.hoverBgGray50,
      hoverBgGray100: hoverBgGray100 ?? this.hoverBgGray100,
      ringBlue500: ringBlue500 ?? this.ringBlue500,
      ringBlue400: ringBlue400 ?? this.ringBlue400,
    );
  }

  @override
  ThemeExtension<TailwindColorTheme> lerp(
    covariant ThemeExtension<TailwindColorTheme>? other,
    double t,
  ) {
    if (other is! TailwindColorTheme) {
      return this;
    }
    return TailwindColorTheme(
      white: Color.lerp(white, other.white, t) ?? white,
      black: Color.lerp(black, other.black, t) ?? black,
      bgWhite: Color.lerp(bgWhite, other.bgWhite, t) ?? bgWhite,
      bgGray50: Color.lerp(bgGray50, other.bgGray50, t) ?? bgGray50,
      bgGray100: Color.lerp(bgGray100, other.bgGray100, t) ?? bgGray100,
      bgGray200: Color.lerp(bgGray200, other.bgGray200, t) ?? bgGray200,
      bgGray300: Color.lerp(bgGray300, other.bgGray300, t) ?? bgGray300,
      bgGray400: Color.lerp(bgGray400, other.bgGray400, t) ?? bgGray400,
      bgGray500: Color.lerp(bgGray500, other.bgGray500, t) ?? bgGray500,
      bgGray600: Color.lerp(bgGray600, other.bgGray600, t) ?? bgGray600,
      bgGray700: Color.lerp(bgGray700, other.bgGray700, t) ?? bgGray700,
      bgGray800: Color.lerp(bgGray800, other.bgGray800, t) ?? bgGray800,
      bgGray900: Color.lerp(bgGray900, other.bgGray900, t) ?? bgGray900,
      textBlack: Color.lerp(textBlack, other.textBlack, t) ?? textBlack,
      textWhite: Color.lerp(textWhite, other.textWhite, t) ?? textWhite,
      textGray900: Color.lerp(textGray900, other.textGray900, t) ?? textGray900,
      textGray800: Color.lerp(textGray800, other.textGray800, t) ?? textGray800,
      textGray700: Color.lerp(textGray700, other.textGray700, t) ?? textGray700,
      textGray600: Color.lerp(textGray600, other.textGray600, t) ?? textGray600,
      textGray500: Color.lerp(textGray500, other.textGray500, t) ?? textGray500,
      textGray400: Color.lerp(textGray400, other.textGray400, t) ?? textGray400,
      textGray300: Color.lerp(textGray300, other.textGray300, t) ?? textGray300,
      borderGray100:
          Color.lerp(borderGray100, other.borderGray100, t) ?? borderGray100,
      borderGray200:
          Color.lerp(borderGray200, other.borderGray200, t) ?? borderGray200,
      borderGray300:
          Color.lerp(borderGray300, other.borderGray300, t) ?? borderGray300,
      borderGray400:
          Color.lerp(borderGray400, other.borderGray400, t) ?? borderGray400,
      borderGray500:
          Color.lerp(borderGray500, other.borderGray500, t) ?? borderGray500,
      borderGray600:
          Color.lerp(borderGray600, other.borderGray600, t) ?? borderGray600,
      borderGray700:
          Color.lerp(borderGray700, other.borderGray700, t) ?? borderGray700,
      bgBlue50: Color.lerp(bgBlue50, other.bgBlue50, t) ?? bgBlue50,
      bgBlue100: Color.lerp(bgBlue100, other.bgBlue100, t) ?? bgBlue100,
      bgBlue200: Color.lerp(bgBlue200, other.bgBlue200, t) ?? bgBlue200,
      bgBlue500: Color.lerp(bgBlue500, other.bgBlue500, t) ?? bgBlue500,
      bgBlue600: Color.lerp(bgBlue600, other.bgBlue600, t) ?? bgBlue600,
      bgBlue700: Color.lerp(bgBlue700, other.bgBlue700, t) ?? bgBlue700,
      textBlue500: Color.lerp(textBlue500, other.textBlue500, t) ?? textBlue500,
      textBlue600: Color.lerp(textBlue600, other.textBlue600, t) ?? textBlue600,
      textBlue700: Color.lerp(textBlue700, other.textBlue700, t) ?? textBlue700,
      textBlue800: Color.lerp(textBlue800, other.textBlue800, t) ?? textBlue800,
      textBlue900: Color.lerp(textBlue900, other.textBlue900, t) ?? textBlue900,
      borderBlue200:
          Color.lerp(borderBlue200, other.borderBlue200, t) ?? borderBlue200,
      borderBlue300:
          Color.lerp(borderBlue300, other.borderBlue300, t) ?? borderBlue300,
      borderBlue500:
          Color.lerp(borderBlue500, other.borderBlue500, t) ?? borderBlue500,
      bgGreen50: Color.lerp(bgGreen50, other.bgGreen50, t) ?? bgGreen50,
      bgGreen100: Color.lerp(bgGreen100, other.bgGreen100, t) ?? bgGreen100,
      bgGreen200: Color.lerp(bgGreen200, other.bgGreen200, t) ?? bgGreen200,
      bgGreen500: Color.lerp(bgGreen500, other.bgGreen500, t) ?? bgGreen500,
      bgGreen600: Color.lerp(bgGreen600, other.bgGreen600, t) ?? bgGreen600,
      textGreen500:
          Color.lerp(textGreen500, other.textGreen500, t) ?? textGreen500,
      textGreen600:
          Color.lerp(textGreen600, other.textGreen600, t) ?? textGreen600,
      textGreen700:
          Color.lerp(textGreen700, other.textGreen700, t) ?? textGreen700,
      textGreen800:
          Color.lerp(textGreen800, other.textGreen800, t) ?? textGreen800,
      borderGreen200:
          Color.lerp(borderGreen200, other.borderGreen200, t) ?? borderGreen200,
      borderGreen300:
          Color.lerp(borderGreen300, other.borderGreen300, t) ?? borderGreen300,
      borderGreen500:
          Color.lerp(borderGreen500, other.borderGreen500, t) ?? borderGreen500,
      bgRed50: Color.lerp(bgRed50, other.bgRed50, t) ?? bgRed50,
      bgRed100: Color.lerp(bgRed100, other.bgRed100, t) ?? bgRed100,
      bgRed200: Color.lerp(bgRed200, other.bgRed200, t) ?? bgRed200,
      bgRed500: Color.lerp(bgRed500, other.bgRed500, t) ?? bgRed500,
      bgRed600: Color.lerp(bgRed600, other.bgRed600, t) ?? bgRed600,
      textRed500: Color.lerp(textRed500, other.textRed500, t) ?? textRed500,
      textRed600: Color.lerp(textRed600, other.textRed600, t) ?? textRed600,
      textRed700: Color.lerp(textRed700, other.textRed700, t) ?? textRed700,
      textRed800: Color.lerp(textRed800, other.textRed800, t) ?? textRed800,
      borderRed200:
          Color.lerp(borderRed200, other.borderRed200, t) ?? borderRed200,
      borderRed300:
          Color.lerp(borderRed300, other.borderRed300, t) ?? borderRed300,
      borderRed500:
          Color.lerp(borderRed500, other.borderRed500, t) ?? borderRed500,
      bgYellow50: Color.lerp(bgYellow50, other.bgYellow50, t) ?? bgYellow50,
      bgYellow100: Color.lerp(bgYellow100, other.bgYellow100, t) ?? bgYellow100,
      bgYellow200: Color.lerp(bgYellow200, other.bgYellow200, t) ?? bgYellow200,
      textYellow600:
          Color.lerp(textYellow600, other.textYellow600, t) ?? textYellow600,
      textYellow700:
          Color.lerp(textYellow700, other.textYellow700, t) ?? textYellow700,
      textYellow800:
          Color.lerp(textYellow800, other.textYellow800, t) ?? textYellow800,
      borderYellow200:
          Color.lerp(borderYellow200, other.borderYellow200, t) ??
          borderYellow200,
      borderYellow300:
          Color.lerp(borderYellow300, other.borderYellow300, t) ??
          borderYellow300,
      bgAmber50: Color.lerp(bgAmber50, other.bgAmber50, t) ?? bgAmber50,
      bgAmber100: Color.lerp(bgAmber100, other.bgAmber100, t) ?? bgAmber100,
      textAmber600:
          Color.lerp(textAmber600, other.textAmber600, t) ?? textAmber600,
      textAmber700:
          Color.lerp(textAmber700, other.textAmber700, t) ?? textAmber700,
      borderAmber300:
          Color.lerp(borderAmber300, other.borderAmber300, t) ?? borderAmber300,
      bgPurple50: Color.lerp(bgPurple50, other.bgPurple50, t) ?? bgPurple50,
      bgPurple100: Color.lerp(bgPurple100, other.bgPurple100, t) ?? bgPurple100,
      bgPurple500: Color.lerp(bgPurple500, other.bgPurple500, t) ?? bgPurple500,
      bgPurple600: Color.lerp(bgPurple600, other.bgPurple600, t) ?? bgPurple600,
      textPurple600:
          Color.lerp(textPurple600, other.textPurple600, t) ?? textPurple600,
      textPurple700:
          Color.lerp(textPurple700, other.textPurple700, t) ?? textPurple700,
      borderPurple200:
          Color.lerp(borderPurple200, other.borderPurple200, t) ??
          borderPurple200,
      borderPurple300:
          Color.lerp(borderPurple300, other.borderPurple300, t) ??
          borderPurple300,
      bgIndigo50: Color.lerp(bgIndigo50, other.bgIndigo50, t) ?? bgIndigo50,
      bgIndigo100: Color.lerp(bgIndigo100, other.bgIndigo100, t) ?? bgIndigo100,
      bgIndigo500: Color.lerp(bgIndigo500, other.bgIndigo500, t) ?? bgIndigo500,
      bgIndigo600: Color.lerp(bgIndigo600, other.bgIndigo600, t) ?? bgIndigo600,
      textIndigo600:
          Color.lerp(textIndigo600, other.textIndigo600, t) ?? textIndigo600,
      textIndigo700:
          Color.lerp(textIndigo700, other.textIndigo700, t) ?? textIndigo700,
      bgViolet50: Color.lerp(bgViolet50, other.bgViolet50, t) ?? bgViolet50,
      bgViolet100: Color.lerp(bgViolet100, other.bgViolet100, t) ?? bgViolet100,
      bgViolet500: Color.lerp(bgViolet500, other.bgViolet500, t) ?? bgViolet500,
      textViolet600:
          Color.lerp(textViolet600, other.textViolet600, t) ?? textViolet600,
      bgCyan50: Color.lerp(bgCyan50, other.bgCyan50, t) ?? bgCyan50,
      bgCyan100: Color.lerp(bgCyan100, other.bgCyan100, t) ?? bgCyan100,
      bgCyan500: Color.lerp(bgCyan500, other.bgCyan500, t) ?? bgCyan500,
      textCyan600: Color.lerp(textCyan600, other.textCyan600, t) ?? textCyan600,
      textCyan700: Color.lerp(textCyan700, other.textCyan700, t) ?? textCyan700,
      bgTeal50: Color.lerp(bgTeal50, other.bgTeal50, t) ?? bgTeal50,
      bgTeal100: Color.lerp(bgTeal100, other.bgTeal100, t) ?? bgTeal100,
      bgTeal500: Color.lerp(bgTeal500, other.bgTeal500, t) ?? bgTeal500,
      textTeal600: Color.lerp(textTeal600, other.textTeal600, t) ?? textTeal600,
      bgSky50: Color.lerp(bgSky50, other.bgSky50, t) ?? bgSky50,
      bgSky100: Color.lerp(bgSky100, other.bgSky100, t) ?? bgSky100,
      bgSky500: Color.lerp(bgSky500, other.bgSky500, t) ?? bgSky500,
      textSky600: Color.lerp(textSky600, other.textSky600, t) ?? textSky600,
      bgOrange50: Color.lerp(bgOrange50, other.bgOrange50, t) ?? bgOrange50,
      bgOrange100: Color.lerp(bgOrange100, other.bgOrange100, t) ?? bgOrange100,
      bgOrange500: Color.lerp(bgOrange500, other.bgOrange500, t) ?? bgOrange500,
      textOrange600:
          Color.lerp(textOrange600, other.textOrange600, t) ?? textOrange600,
      textOrange700:
          Color.lerp(textOrange700, other.textOrange700, t) ?? textOrange700,
      bgRose50: Color.lerp(bgRose50, other.bgRose50, t) ?? bgRose50,
      bgRose100: Color.lerp(bgRose100, other.bgRose100, t) ?? bgRose100,
      bgRose500: Color.lerp(bgRose500, other.bgRose500, t) ?? bgRose500,
      textRose600: Color.lerp(textRose600, other.textRose600, t) ?? textRose600,
      bgPink50: Color.lerp(bgPink50, other.bgPink50, t) ?? bgPink50,
      bgPink100: Color.lerp(bgPink100, other.bgPink100, t) ?? bgPink100,
      bgPink500: Color.lerp(bgPink500, other.bgPink500, t) ?? bgPink500,
      textPink600: Color.lerp(textPink600, other.textPink600, t) ?? textPink600,
      bgLime50: Color.lerp(bgLime50, other.bgLime50, t) ?? bgLime50,
      bgLime100: Color.lerp(bgLime100, other.bgLime100, t) ?? bgLime100,
      bgLime500: Color.lerp(bgLime500, other.bgLime500, t) ?? bgLime500,
      textLime600: Color.lerp(textLime600, other.textLime600, t) ?? textLime600,
      bgEmerald50: Color.lerp(bgEmerald50, other.bgEmerald50, t) ?? bgEmerald50,
      bgEmerald100:
          Color.lerp(bgEmerald100, other.bgEmerald100, t) ?? bgEmerald100,
      bgEmerald500:
          Color.lerp(bgEmerald500, other.bgEmerald500, t) ?? bgEmerald500,
      textEmerald600:
          Color.lerp(textEmerald600, other.textEmerald600, t) ?? textEmerald600,
      hoverBgGray50:
          Color.lerp(hoverBgGray50, other.hoverBgGray50, t) ?? hoverBgGray50,
      hoverBgGray100:
          Color.lerp(hoverBgGray100, other.hoverBgGray100, t) ?? hoverBgGray100,
      ringBlue500: Color.lerp(ringBlue500, other.ringBlue500, t) ?? ringBlue500,
      ringBlue400: Color.lerp(ringBlue400, other.ringBlue400, t) ?? ringBlue400,
    );
  }
}
