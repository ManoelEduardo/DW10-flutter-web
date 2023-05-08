class ColorApp{
    static ColorApp? _instance;


    ColorApp._();

    static ColorApp get instance{
        _instance ??= ColorApp._();
        return _instance!;
    }

   Color get primary => const Color(0xFF007D21); 
   Color get secondary => const Color(0xFFFFAB18); 
   Color get black => const Color(0xFF140E0E); 
}

extension ColorAppExtension on BuildContext {
    ColorApp get colors => ColorApp.instance;
}