class ThemeConfig {

    ThemeConfig._();

    static final _defaultInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: Colors.grey[400]!),
    );

    static final theme = ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black,),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: ColorsApp.instance.primary,
            primary: ColorsApp.instance.primary,
            secondary: ColorsApp.instance.secondary,
        ),
        elevationButtonTheme: ElevationButtonThemeData(
            style: AppStyles.instance.primaryButton,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            border: _defaultInputBorder,
            enabledBorder: _defaultInputBorder,
            focusedBorder: _defaultInputBorder,
            labelStyle: TextStyles.instance.textRegular.copyWith(color: Colors.black),
            errorStyle: TextStyles.instance.textRgular.copyWith(color: Colors.redAccent),
        ),
    );
}