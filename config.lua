Config = {}

Config.UpdateCheck = true
Config.Locale = 'en'

Config.ThemeColor = "FFFF00DD"

Config.Locales = {
    ['tr'] = {
        next = "İleri",
        back = "Geri",
        skip = "Tanıtımı Atla",
        finish = "Tanıtımı Bitir",
        press_e = "E Tuşuna basarak tanıtımı izle",
        already_watched = "Bu tanıtımı zaten izledin!" 
    },
    ['en'] = {
        next = "Next",
        back = "Back",
        skip = "Skip Intro",
        finish = "Finish Intro",
        press_e = "Press E to watch the intro",
        already_watched = "You have already watched this intro!" 
    }
}

Config.Locations = {
    [1] = {
        title = "International Airport",
        description = "Where you take your first step into Los Santos. A new face, a new name in the city... The adventure begins right on this asphalt.",
        duration = 6,
        smoothTransition = true, -- true: kameralar arası yumuşak geçiş | false: fade ile geçiş
        cameras = {
            { coords = vector3(-1021.41, -2708.54, 25.97), pitch = -10.0, heading = 149.53 },
            { coords = vector3(-1010.32, -2679.57, 44.74), pitch = -10.0, heading = 147.71 }
        }
    },
    [2] = {
        title = "Skyscrapers",
        description = "Don't be fooled by the glitter of these massive skyscrapers. Behind the glass buildings, the city's dirtiest deals go down. Those at the top always crush those at the bottom.",
        duration = 6,
        smoothTransition = true,
        cameras = {
            { coords = vector3(49.42, -1192.22, 110.72), pitch = -15.0, heading = 352.51 },
            { coords = vector3(48.85, -1042.96, 118.33), pitch = -15.0, heading = 4.88 }
        }
    },
    [3] = {
        title = "Vespucci Beach",
        description = "A gorgeous beach where you can escape the city's suffocating stress and take a breath. But remember, even this beautiful coastline sometimes attracts trouble.",
        duration = 12,
        smoothTransition = true,
        cameras = {
            { coords = vector3(-1260.45, -1775.3,   7.08), pitch = -5.0, heading = 28.42 },
            { coords = vector3(-1274.05, -1754.35,  5.83), pitch = -5.0, heading = 34.48 },
            { coords = vector3(-1296.4,  -1723.01,  5.79), pitch = -5.0, heading = 36.21 },
            { coords = vector3(-1311.37, -1702.37,  5.66), pitch = -5.0, heading = 35.74 },
            { coords = vector3(-1329.96, -1673.31,  5.69), pitch = -5.0, heading = 33.46 },
            { coords = vector3(-1353.94, -1635.83,  6.07), pitch = -5.0, heading = 32.28 },
            { coords = vector3(-1379.22, -1595.03,  6.78), pitch = -5.0, heading = 30.07 },
            { coords = vector3(-1407.2,  -1540.82,  8.29), pitch = -5.0, heading = 25.74 },
            { coords = vector3(-1439.25, -1473.03,  9.73), pitch = -5.0, heading = 33.22 },
            { coords = vector3(-1456.51, -1422.39, 10.09), pitch = -5.0, heading = 21.17 },
            { coords = vector3(-1490.7,  -1338.61, 10.88), pitch = -5.0, heading = 25.42 },
            { coords = vector3(-1503.89, -1258.56, 11.73), pitch = -5.0, heading = 42.27 },
            { coords = vector3(-1553.25, -1130.39, 16.05), pitch = -5.0, heading = 72.98 }
        }
    },
    [4] = {
        title = "Luxury Life",
        description = "The glamorous life where the rich get richer and money flows like water. If you play your cards right, you might own all this one day.",
        duration = 8,
        smoothTransition = true,
        cameras = {
            { coords = vector3(-1465.26, 434.57,  135.68), pitch = -15.0, heading = 325.34 },
            { coords = vector3(-1425.48, 525.49,  158.89), pitch = -15.0, heading = 314.71 },
            { coords = vector3(-1328.47, 584.19,  169.48), pitch = -15.0, heading = 305.11 },
            { coords = vector3(-1245.63, 637.55,  170.9),  pitch = -15.0, heading = 304.56 }
        }
    },
    [5] = {
        title = "Dangerous Streets",
        description = "South Central... Think twice before stepping in here and always watch your back. The streets have their own rules and they don't forgive mistakes.",
        duration = 9,
        smoothTransition = true,
        cameras = {
            { coords = vector3(-22.72,  -1579.98, 51.02), pitch = -20.0, heading = 98.97  },
            { coords = vector3(-81.02,  -1654.52, 44.73), pitch = -20.0, heading = 183.46 },
            { coords = vector3(-89.72,  -1759.33, 42.37), pitch = -20.0, heading = 220.39 },
            { coords = vector3(-47.56,  -1815.66, 40.1),  pitch = -20.0, heading = 225.82 },
            { coords = vector3(3.01,    -1855.02, 37.71), pitch = -20.0, heading = 227.16 },
            { coords = vector3(66.24,   -1910.29, 33.31), pitch = -20.0, heading = 228.82 }
        }
    },
    [6] = {
        title = "Police Department",
        description = "Mission Row LSPD! Only walk through those doors if your business is strictly legal. They aren't very welcoming to criminals, they won't even let you breathe.",
        duration = 6,
        smoothTransition = true,
        cameras = {
            { coords = vector3(418.68, -1041.15, 49.59), pitch = -15.0, heading = 313.78 },
            { coords = vector3(403.26,  -962.52, 45.74), pitch = -15.0, heading = 229.06 }
        }
    },
    [7] = {
        title = "Sheriff's Department",
        description = "They have total control over the north. The county roads might look quiet and peaceful, but the Sheriffs are much more ruthless than the city cops.",
        duration = 6,
        smoothTransition = true,
        cameras = {
            { coords = vector3(-428.67, 6034.2,  35.48), pitch = -15.0, heading = 141.26 },
            { coords = vector3(-466.86, 6041.31, 35.29), pitch = -15.0, heading = 195.52 }
        }
    },
    [8] = {
        title = "State Prison",
        description = "Bolingbroke Penitentiary... If that luck you trust so much runs out, and you get on the wrong side of the law, this is exactly where your new home will be.",
        duration = 6,
        smoothTransition = true,
        cameras = {
            { coords = vector3(1872.61, 2598.23, 51.38), pitch = -15.0, heading = 92.52 },
            { coords = vector3(1905.18, 2613.23, 93.02), pitch = -15.0, heading = 97.79 }
        }
    },
    [9] = {
        title = "Pillbox Hospital",
        description = "Those cold white corridors where you'll open your eyes when you take a bullet or get into a nasty crash. Treat them well if you want to stay alive.",
        duration = 6,
        smoothTransition = true,
        cameras = {
            { coords = vector3(280.61, -565.21, 47.26), pitch = -15.0, heading = 234.09 },
            { coords = vector3(248.32, -547.28, 63.04), pitch = -15.0, heading = 236.22 }
        }
    },
    [10] = {
        title = "Pinkcage Motel",
        description = "If you don't own a million-dollar luxury mansion, you'll be staying at this 'classy' and eventful motel. Just don't forget to lock your door at night.",
        duration = 6,
        smoothTransition = true,
        cameras = {
            { coords = vector3(319.81, -236.58, 65.59), pitch = -15.0, heading = 34.57 },
            { coords = vector3(329.86, -262.73, 69.88), pitch = -15.0, heading = 5.83  }
        }
    },
    [11] = {
        title = "Mechanic Garages",
        description = "Blown engine? Torn off bumper? The city's master hands are right here. Get your cash ready and have your ride rebuilt from scratch.",
        duration = 6,
        smoothTransition = false,
        cameras = {
            { coords = vector3(-370.06, -130.84, 42.25), pitch = -15.0, heading = 251.58 },
            { coords = vector3(-383.77, -116.12, 49.7),  pitch = -15.0, heading = 240.95 },
            { coords = vector3(-184.66, -1296.86, 34.83),  pitch = -15.0, heading = 125.75 }
        }
    }
}