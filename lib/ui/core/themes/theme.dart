import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:best_practices/ui/core/extensions/color_extension.dart';
import 'package:best_practices/ui/core/extensions/new_color_extension.dart';
import 'package:best_practices/ui/core/extensions/tailwind_color_extension.dart';
import 'package:best_practices/ui/core/themes/custom_text_style.dart';
import 'package:best_practices/ui/core/themes/new_colors.dart';
import 'package:best_practices/ui/core/themes/tailwind_colors.dart';
import 'colors.dart';

abstract final class AppTheme {
  static OutlineInputBorder _border([Color color = AppColors.grey300]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.circular(6),
      );

  static final _customTextTheme = CustomTextTheme();

  static final _textTheme = TextTheme(
    headlineSmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 26,
      height: 1,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      fontSize: 20,
      height: 1,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 1,
    ),
  );

  //MARK: ThemeData Light
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brand500).copyWith(
      primary: AppColors.brand600,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryLight,
      surface: AppColors.lightgrey,
      onSurface: AppColors.grey900,
      secondaryContainer: Colors.white,
      onTertiaryContainer: Colors.white,
      tertiaryContainer: AppColors.primary,
      surfaceContainer: Colors.white,
      surfaceContainerHigh: Colors.white,
      surfaceContainerHighest: AppColors.lightActive,
      outline: AppColors.grey300,
      error: AppColors.danger,
    ),
    textTheme: _textTheme,

    chipTheme: ChipThemeData(
      checkmarkColor: AppColors.primaryActive,
      selectedColor: AppColors.primaryLight,
      side: WidgetStateBorderSide.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return BorderSide(
            color: AppColors.primary.withValues(alpha: 0.2),
            width: 2,
          );
        } else if (state.contains(WidgetState.disabled)) {
          return BorderSide(color: AppColors.grey300, width: 1);
        }
        return BorderSide(color: AppColors.grey300, width: 1);
      }),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      fillColor: AppColors.lightActive,
      filled: true,
      border: _border(),
      focusedBorder: _border(AppColors.primary),
      enabledBorder: _border(AppColors.grey300),
      errorBorder: _border(AppColors.danger),
      errorStyle: _textTheme.bodySmall,
      hintStyle: _customTextTheme.textLg.copyWith(color: AppColors.grey500),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      shadowColor: Colors.grey.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grey200, width: 1),
      ),
      elevation: 3,
    ),

    expansionTileTheme: ExpansionTileThemeData(
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      shape: RoundedRectangleBorder(),
      collapsedTextColor: AppColors.grey800,
      collapsedIconColor: AppColors.grey800,
      tilePadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    ),

    dividerTheme: DividerThemeData(
      space: 0,
      indent: 0,
      endIndent: 0,
      color: AppColors.grey200,
    ),

    dataTableTheme: DataTableThemeData(
      dataRowColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        return AppColors.white; // Cor padrão
      }),
    ),

    extensions: [NewAppColorTheme(), TailwindColorTheme()],
  );

  //MARK: ThemeData Dark
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: CupertinoColors.systemBlue.darkColor,
          brightness: Brightness.dark,
        ).copyWith(
          primary: CupertinoColors.systemBlue.darkColor,
          surface: AppColors.coal500,
          onSurface: AppColors.grey50,
          secondaryContainer: AppColors.grey950Dark,
          surfaceContainer: AppColors.grey900Dark,
          surfaceContainerHigh: AppColors.lightActiveDark,
          outline: AppColors.grey800Dark,
          surfaceContainerHighest: AppColors.lightActiveDark,
        ),
    textTheme: _textTheme.merge(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),

    chipTheme: ChipThemeData(
      checkmarkColor: AppColors.primaryActiveDark,
      selectedColor: AppColors.primaryLightDark,
      side: WidgetStateBorderSide.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return BorderSide(
            color: AppColors.primaryDark.withValues(alpha: 0.2),
            width: 2,
          );
        } else if (state.contains(WidgetState.disabled)) {
          return BorderSide(color: AppColors.grey300Dark, width: 1);
        }
        return BorderSide(color: AppColors.grey300Dark, width: 1);
      }),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      border: _border(),
      focusedBorder: _border(AppColors.primaryDark),
      enabledBorder: _border(AppColors.grey300Dark),
      errorBorder: _border(AppColors.dangerDark),
      errorStyle: TextStyle(color: AppColors.dangerDark),
      hintStyle: _customTextTheme.textLg.copyWith(color: AppColors.grey400),
    ),

    cardTheme: CardThemeData(
      color: AppColors.grey800Dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grey800Dark, width: 1),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    ),

    dividerTheme: DividerThemeData(
      space: 0,
      indent: 0,
      endIndent: 0,
      color: AppColors.grey800Dark,
    ),

    dataTableTheme: DataTableThemeData(
      dataRowColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        // if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused) || states.contains(WidgetState.selected)) {
        //   return AppColors.grey500;
        // }h

        return AppColors.grey950Dark; // Cor padrão
      }),
    ),

    extensions: [
      NewAppColorTheme(
        background: NewAppColors.backgroundDark,
        foreground: NewAppColors.foregroundDark,
        primary: NewAppColors.primaryDark,
        primaryForeground: NewAppColors.primaryForegroundDark,
        primaryLight: NewAppColors.primaryLightDark,
        primaryShade: NewAppColors.primaryShadeDark,
        success: NewAppColors.successDark,
        successForeground: NewAppColors.successForegroundDark,
        successLight: NewAppColors.successLightDark,
        warning: NewAppColors.warningDark,
        warningForeground: NewAppColors.warningForegroundDark,
        destructive: NewAppColors.destructiveDark,
        destructiveForeground: NewAppColors.destructiveForegroundDark,
        card: NewAppColors.cardDark,
        cardForeground: NewAppColors.cardForegroundDark,
        popover: NewAppColors.popoverDark,
        popoverForeground: NewAppColors.popoverForegroundDark,
        secondary: NewAppColors.secondaryDark,
        secondaryForeground: NewAppColors.secondaryForegroundDark,
        muted: NewAppColors.mutedDark,
        mutedForeground: NewAppColors.mutedForegroundDark,
        accent: NewAppColors.accentDark,
        accentForeground: NewAppColors.accentForegroundDark,
        border: NewAppColors.borderDark,
        input: NewAppColors.inputDark,
        ring: NewAppColors.ringDark,
        sidebarBackground: NewAppColors.sidebarBackgroundDark,
        sidebarForeground: NewAppColors.sidebarForegroundDark,
        sidebarPrimary: NewAppColors.sidebarPrimaryDark,
        sidebarPrimaryForeground: NewAppColors.sidebarPrimaryForegroundDark,
        sidebarAccent: NewAppColors.sidebarAccentDark,
        sidebarAccentForeground: NewAppColors.sidebarAccentForegroundDark,
        sidebarBorder: NewAppColors.sidebarBorderDark,
        sidebarRing: NewAppColors.sidebarRingDark,
        shadowElegant: NewAppColors.shadowElegantDark,
        shadowCard: NewAppColors.shadowCardDark,
      ),
      AppColorTheme(
        primaryActive: AppColors.brand600,
        grey300: AppColors.grey300Dark,
        grey500: AppColors.grey500Dark,
        grey400: AppColors.grey400Dark,
        grey600: AppColors.grey600Dark,
        grey700: AppColors.grey700Dark,
        grey800: AppColors.grey800Dark,
        grey900: AppColors.grey900Dark,
        danger: AppColors.dangerDark,
        lightActive: AppColors.lightActiveDark,
        dangerClarity20: AppColors.dangerClarity20Dark,
        dangerLight: AppColors.dangerLightDark,
        sidebarBackgroundColor: AppColors.coal600,
        primaryLight: AppColors.primaryLightDark,
        textTertiary: AppColors.grey400,
        textPrimary: AppColors.grey50,
        textPlaceholder: AppColors.grey400,
        textSecondary: AppColors.grey300Dark,
        textQuaternary: AppColors.grey400Dark,
        textDisabled: AppColors.grey500Dark,
        textBrandPrimary: AppColors.grey50Dark,
        textBrandSecondary: AppColors.grey300Dark,
        textBrandTertiary: AppColors.grey400Dark,
        textErrorPrimary: AppColors.error400,
        textWarningPrimary: AppColors.warning400,
        textSuccessPrimary: AppColors.success400,
        borderPrimary: AppColors.grey700Dark,
        borderSecondary: AppColors.grey800Dark,
        borderTertiary: AppColors.grey800Dark,
        borderDisabled: AppColors.grey700Dark,
        borderBrand: AppColors.brand400,
        borderError: AppColors.error400,
        fgPrimary: AppColors.white,
        fgSecondary: AppColors.grey300Dark,
        fgTertiary: AppColors.grey400Dark,
        fgQuaternary: AppColors.grey600Dark,
        fgWhite: AppColors.white,
        fgDisabled: AppColors.grey500Dark,
        fgBrandPrimary: AppColors.brand500,
        fgBrandSecondary: AppColors.brand500,
        fgErrorPrimary: AppColors.error500,
        fgErrorSecondary: AppColors.error400,
        fgWarningPrimary: AppColors.warning500,
        fgWarningSecondary: AppColors.warning400,
        fgSuccessPrimary: AppColors.success500,
        fgSuccessSecondary: AppColors.success400,
        bgPrimary: AppColors.grey950Dark,
        bgPrimarySolid: AppColors.grey900Dark,
        bgSecondary: AppColors.grey900Dark,
        bgSecondarySolid: AppColors.grey600Dark,
        bgTertiary: AppColors.grey800Dark,
        bgQuaternary: AppColors.grey700Dark,
        bgActive: AppColors.grey800Dark,
        bgDisabled: AppColors.grey800Dark,
        bgOverlay: AppColors.grey800Dark,
        bgBrandPrimary: AppColors.brand500,
        bgBrandSecondary: AppColors.brand600,
        bgBrandSolid: AppColors.brand600,
        bgBrandSection: AppColors.grey800Dark,
        bgErrorPrimary: AppColors.error950,
        bgErrorSecondary: AppColors.error600,
        bgErrorSolid: AppColors.error600,
        bgWarningPrimary: AppColors.warning950,
        bgWarningSecondary: AppColors.warning600,
        bgWarningSolid: AppColors.warning600,
        bgSuccessPrimary: AppColors.success950,
        bgSuccessSecondary: AppColors.success600,
        bgSuccessSolid: AppColors.success600,
        textPrimaryOnBrand: AppColors.grey50Dark,
        textSecondaryHover: AppColors.grey200Dark,
        textSecondaryOnBrand: AppColors.grey300Dark,
        textTertiaryHover: AppColors.grey300Dark,
        textTertiaryOnBrand: AppColors.grey400Dark,
        textQuaternaryOnBrand: AppColors.grey400Dark,
        textPlaceholderSubtle: AppColors.grey700Dark,
        textBrandSecondaryHover: AppColors.grey300Dark,
        textBrandTertiaryAlt: AppColors.grey50Dark,
        borderDisabledSubtle: AppColors.grey800Dark,
        borderBrandAlt: AppColors.grey700Dark,
        borderErrorSubtle: AppColors.error500,
        fgSecondaryHover: AppColors.grey200Dark,
        fgTertiaryHover: AppColors.grey300Dark,
        fgQuaternaryHover: AppColors.grey500Dark,
        fgDisabledSubtle: AppColors.grey600Dark,
        fgBrandPrimaryAlt: AppColors.grey300Dark,
        fgBrandSecondaryAlt: AppColors.grey600Dark,
        bgPrimaryAlt: AppColors.grey900Dark,
        bgPrimaryHover: AppColors.grey800Dark,
        bgSecondaryAlt: AppColors.grey950Dark,
        bgSecondaryHover: AppColors.grey800Dark,
        bgSecondarySubtle: AppColors.grey900Dark,
        bgDisabledSubtle: AppColors.grey900Dark,
        bgBrandPrimaryAlt: AppColors.grey800Dark,
        bgBrandSolidHover: AppColors.brand500,
        bgBrandSectionSubtle: AppColors.grey950Dark,
        bgErrorSolidHover: AppColors.error500,
        utilitySuccess50: AppColors.success950,
        utilitySuccess700: AppColors.success300,
        utilityError50: AppColors.error950,
        utilityError700: AppColors.error300,
        utilitySuccess200: AppColors.success200,
        utilityError200: AppColors.error800,
      ),
      TailwindColorTheme(
        // Base colors - inverted for dark mode
        white: MyColors.white,
        black: MyColors.black,

        // Gray scale backgrounds - dark mode (inverted)
        bgWhite: MyColors.gray900,
        bgGray50: MyColors.gray900,
        bgGray100: MyColors.gray800,
        bgGray200: MyColors.gray700,
        bgGray300: MyColors.gray600,
        bgGray400: MyColors.gray500,
        bgGray500: MyColors.gray400,
        bgGray600: MyColors.gray300,
        bgGray700: MyColors.gray200,
        bgGray800: MyColors.gray100,
        bgGray900: MyColors.gray50,

        // Gray scale text - dark mode (inverted)
        textBlack: MyColors.white,
        textWhite: MyColors.gray900,
        textGray900: MyColors.white,
        textGray800: MyColors.gray100,
        textGray700: MyColors.gray200,
        textGray600: MyColors.gray300,
        textGray500: MyColors.gray400,
        textGray400: MyColors.gray500,
        textGray300: MyColors.gray600,

        // Gray scale borders - dark mode (inverted)
        borderGray100: MyColors.gray800,
        borderGray200: MyColors.gray700,
        borderGray300: MyColors.gray600,
        borderGray400: MyColors.gray500,
        borderGray500: MyColors.gray400,
        borderGray600: MyColors.gray300,
        borderGray700: MyColors.gray200,

        // Blue backgrounds - dark mode
        bgBlue50: MyColors.blue950,
        bgBlue100: MyColors.blue900,
        bgBlue200: MyColors.blue800,
        bgBlue500: MyColors.blue500,
        bgBlue600: MyColors.blue500,
        bgBlue700: MyColors.blue400,

        // Blue text - dark mode
        textBlue500: MyColors.blue400,
        textBlue600: MyColors.blue400,
        textBlue700: MyColors.blue300,
        textBlue800: MyColors.blue200,
        textBlue900: MyColors.blue100,

        // Blue borders - dark mode
        borderBlue200: MyColors.blue800,
        borderBlue300: MyColors.blue700,
        borderBlue500: MyColors.blue400,

        // Green backgrounds - dark mode
        bgGreen50: MyColors.green950,
        bgGreen100: MyColors.green900,
        bgGreen200: MyColors.green800,
        bgGreen500: MyColors.green500,
        bgGreen600: MyColors.green500,

        // Green text - dark mode
        textGreen500: MyColors.green400,
        textGreen600: MyColors.green400,
        textGreen700: MyColors.green300,
        textGreen800: MyColors.green200,

        // Green borders - dark mode
        borderGreen200: MyColors.green800,
        borderGreen300: MyColors.green700,
        borderGreen500: MyColors.green400,

        // Red backgrounds - dark mode
        bgRed50: MyColors.red950,
        bgRed100: MyColors.red900,
        bgRed200: MyColors.red800,
        bgRed500: MyColors.red500,
        bgRed600: MyColors.red500,

        // Red text - dark mode
        textRed500: MyColors.red400,
        textRed600: MyColors.red400,
        textRed700: MyColors.red300,
        textRed800: MyColors.red200,

        // Red borders - dark mode
        borderRed200: MyColors.red800,
        borderRed300: MyColors.red700,
        borderRed500: MyColors.red400,

        // Yellow backgrounds - dark mode
        bgYellow50: MyColors.yellow950,
        bgYellow100: MyColors.yellow900,
        bgYellow200: MyColors.yellow800,

        // Yellow text - dark mode
        textYellow600: MyColors.yellow400,
        textYellow700: MyColors.yellow300,
        textYellow800: MyColors.yellow200,

        // Yellow borders - dark mode
        borderYellow200: MyColors.yellow800,
        borderYellow300: MyColors.yellow700,

        // Amber backgrounds - dark mode
        bgAmber50: MyColors.amber950,
        bgAmber100: MyColors.amber900,

        // Amber text - dark mode
        textAmber600: MyColors.amber400,
        textAmber700: MyColors.amber300,

        // Amber borders - dark mode
        borderAmber300: MyColors.amber700,

        // Purple backgrounds - dark mode
        bgPurple50: MyColors.purple950,
        bgPurple100: MyColors.purple900,
        bgPurple500: MyColors.purple500,
        bgPurple600: MyColors.purple500,

        // Purple text - dark mode
        textPurple600: MyColors.purple400,
        textPurple700: MyColors.purple300,

        // Purple borders - dark mode
        borderPurple200: MyColors.purple800,
        borderPurple300: MyColors.purple700,

        // Indigo backgrounds - dark mode
        bgIndigo50: MyColors.indigo950,
        bgIndigo100: MyColors.indigo900,
        bgIndigo500: MyColors.indigo500,
        bgIndigo600: MyColors.indigo500,

        // Indigo text - dark mode
        textIndigo600: MyColors.indigo400,
        textIndigo700: MyColors.indigo300,

        // Violet backgrounds - dark mode
        bgViolet50: MyColors.violet950,
        bgViolet100: MyColors.violet900,
        bgViolet500: MyColors.violet500,

        // Violet text - dark mode
        textViolet600: MyColors.violet400,

        // Cyan backgrounds - dark mode
        bgCyan50: MyColors.cyan950,
        bgCyan100: MyColors.cyan900,
        bgCyan500: MyColors.cyan500,

        // Cyan text - dark mode
        textCyan600: MyColors.cyan400,
        textCyan700: MyColors.cyan300,

        // Teal backgrounds - dark mode
        bgTeal50: MyColors.teal950,
        bgTeal100: MyColors.teal900,
        bgTeal500: MyColors.teal500,

        // Teal text - dark mode
        textTeal600: MyColors.teal400,

        // Sky backgrounds - dark mode
        bgSky50: MyColors.sky950,
        bgSky100: MyColors.sky900,
        bgSky500: MyColors.sky500,

        // Sky text - dark mode
        textSky600: MyColors.sky400,

        // Orange backgrounds - dark mode
        bgOrange50: MyColors.orange950,
        bgOrange100: MyColors.orange900,
        bgOrange500: MyColors.orange500,

        // Orange text - dark mode
        textOrange600: MyColors.orange400,
        textOrange700: MyColors.orange300,

        // Rose backgrounds - dark mode
        bgRose50: MyColors.rose950,
        bgRose100: MyColors.rose900,
        bgRose500: MyColors.rose500,

        // Rose text - dark mode
        textRose600: MyColors.rose400,

        // Pink backgrounds - dark mode
        bgPink50: MyColors.pink950,
        bgPink100: MyColors.pink900,
        bgPink500: MyColors.pink500,

        // Pink text - dark mode
        textPink600: MyColors.pink400,

        // Lime backgrounds - dark mode
        bgLime50: MyColors.lime950,
        bgLime100: MyColors.lime900,
        bgLime500: MyColors.lime500,

        // Lime text - dark mode
        textLime600: MyColors.lime400,

        // Emerald backgrounds - dark mode
        bgEmerald50: MyColors.emerald950,
        bgEmerald100: MyColors.emerald900,
        bgEmerald500: MyColors.emerald500,

        // Emerald text - dark mode
        textEmerald600: MyColors.emerald400,

        // Hover states - dark mode (inverted)
        hoverBgGray50: MyColors.gray800,
        hoverBgGray100: MyColors.gray700,

        // Ring colors - dark mode
        ringBlue500: MyColors.blue400,
        ringBlue400: MyColors.blue400,
      ),
    ],
  );
}
