Config_client = {}

Config_client = {
    price = 100,
    textoConfirm = false, -- Coloque true caso queira um texto 2d
    -- texto = "[E] Studio de tatuagem", -- Texto 3d q aparecerá
    blipConfirm = false, -- Coloque true caso queira um blip 3d
    hoverfyConfirm = true, -- Coloque true caso queira uma hoverfy indicativa.
    blip = 21, -- Blip q vai ser addd
    invisivel = true, -- Deixe true caso um player não veja o outro ao entrar na loja (vai pesar mais o script)
    url = "tatuagens", -- Url das suas imagens do xampp
    markerConfirmation = true, -- Coloque false caso não queira que a loja e roupas defina seus markers
    markerId = 75, -- Numero do marker
    markerColor = 4, -- Cor do marker
    markerName = "Loja de tatuagens", -- Nome no marker

    roupas = {
        mascara = 0, -- Mascara default
        jaqueta = 15,
        blusa = 15,
        luva = 15,
        calca = 18,
        sapato = 34,
        colete = 0
    },

    lojaTatoo = {
        { name = "Loja de tatuagens", x = -1153.03, y = -1426.12, z = 4.95 }, -- loja2
        { name = "Loja de tatuagens", x = -293.29, y = 6200.15, z = 31.49 }, -- loja6
        { name = "Loja de tatuagens", x = 1863.86, y = 3747.74, z = 33.04 }, -- loja5
        { name = "Loja de tatuagens", x = -3169.44, y = 1077.21, z = 20.83 }, -- loja4
        { name = "Loja de tatuagens", x = 323.59, y = 180.07, z = 103.59 }, -- loja3
        { name = "Loja de tatuagens", x = 1322.07, y = -1652.55, z = 52.28 }, -- loja1
    },
    ['partsM'] = {
        torso = {
            tattoo = {
                {name = 'MP_Airraces_Tattoo_000_M', cname = 'Turbulence', part = 'mpairraces_overlays'},                
                {name = 'MP_Airraces_Tattoo_001_M', cname = 'Pilot Skull', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_002_M', cname = 'Winged Bombshell', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_004_M', cname = 'Balloon Pioneer', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_005_M', cname = 'Parachute Belle', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_006_M', cname = 'Bombs Away', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_007_M', cname = 'Eagle Eyes', part = 'mpairraces_overlays'},
    
                {name = 'MP_Bea_M_Back_000', cname = 'Ship Arms', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_M_Chest_000', cname = 'Tribal Hammerhead', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_M_Chest_001', cname = 'Tribal Shark', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_M_Stom_000', cname = 'Swordfish', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_M_Stom_001', cname = 'Wheel', part = 'mpbeach_overlays'},
    
                {name = 'MP_MP_Biker_Tat_000_M', cname = 'Demon Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_001_M', cname = 'Both Barrels', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_003_M', cname = 'Web Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_005_M', cname = 'Made In America', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_006_M', cname = 'Chopper Freedom', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_008_M', cname = 'Freedom Wheels', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_010_M', cname = 'Skull Of Taurus', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_011_M', cname = 'R.I.P. My Brothers', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_013_M', cname = 'Demon Crossbones', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_017_M', cname = 'Clawed Beast', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_018_M', cname = 'Skeletal Chopper', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_019_M', cname = 'Gruesome Talons', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_021_M', cname = 'Flaming Reaper', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_023_M', cname = 'Western MC', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_026_M', cname = 'American Dream', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_029_M', cname = 'Bone Wrench', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_030_M', cname = 'Brothers For Life', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_031_M', cname = 'Gear Head', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_032_M', cname = 'Western Eagle', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_034_M', cname = 'Brotherhood of Bikes', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_039_M', cname = 'Gas Guzzler', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_041_M', cname = 'No Regrets', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_043_M', cname = 'Ride Forever', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_050_M', cname = 'Unforgiven', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_052_M', cname = 'Biker Mount', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_058_M', cname = 'Reaper Vulture', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_059_M', cname = 'Faggio', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_060_M', cname = 'We Are The Mods!', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_M_Stomach_000', cname = 'Refined Hustler', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_Chest_000', cname = 'Rich', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_Chest_001', cname = '$$$', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_Back_000', cname = 'Makin Paper', part = 'mpbusiness_overlays'},
                
                {name = 'MP_Christmas2017_Tattoo_000_M', cname = 'Thor & Goblin', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_002_M', cname = 'Kabuto', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_003_M', cname = 'Native Warrior', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_005_M', cname = 'Ghost Dragon', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_008_M', cname = 'Spartan Warrior', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_009_M', cname = 'Norse Rune', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_010_M', cname = 'Spartan Shield', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_011_M', cname = 'Weathered Skull', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_015_M', cname = 'Samurai Combat', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_016_M', cname = 'Odin & Raven', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_019_M', cname = 'Strike Force', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_020_M', cname = 'Medusa Gaze', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_021_M', cname = 'Spartan & Lion', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_022_M', cname = 'Spartan & Horse', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_024_M', cname = 'Dragon Slayer', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_026_M', cname = 'Spartan Skull', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_027_M', cname = 'Molon Labe', part = 'mpchristmas2017_overlays'},
    
                
                {name = 'MP_Xmas2_M_Tat_005', cname = 'Carp Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_006', cname = 'Carp Shaded', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_009', cname = 'Time To Die', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_011', cname = 'Roaring Tiger', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_013', cname = 'Lizard', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_015', cname = 'Japanese Warrior', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_016', cname = 'Loose Lips Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_017', cname = 'Loose Lips Color', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_018', cname = 'Royal Dagger Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_019', cname = 'Royal Dagger Color', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_028', cname = 'Executioner', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_000_M', cname = 'Bullet Proof', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_001_M', cname = 'Crossed Weapons', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_009_M', cname = 'Butterfly Knife', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_010_M', cname = 'Cash Money', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_012_M', cname = 'Dollar Daggers', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_013_M', cname = 'Wolf Insignia', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_014_M', cname = 'Backstabber', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_017_M', cname = 'Dog Tags', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_018_M', cname = 'Dual Wield Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_019_M', cname = 'Pistol Wings', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_020_M', cname = 'Crowned Weapons', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_022_M', cname = 'Explosive Heart', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_028_M', cname = 'Micro SMG Chain', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_029_M', cname = 'Win Some Lose Some', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_M_Tat_000', cname = 'Crossed Arrows', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_002', cname = 'Chemistry', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_006', cname = 'Feather Birds', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_011', cname = 'Infinity', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_012', cname = 'Antlers', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_013', cname = 'Boombox', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_024', cname = 'Pyramid', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_025', cname = 'Watch Your Step', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_029', cname = 'Sad', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_030', cname = 'Shark Fin', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_031', cname = 'Skateboard', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_032', cname = 'Paper Plane', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_033', cname = 'Stag', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_035', cname = 'Sewn Heart', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_041', cname = 'Tooth', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_046', cname = 'Triangles', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_047', cname = 'Cassette', part = 'mphipster_overlays'},
    
                {name = 'MP_MP_ImportExport_Tat_000_M', cname = 'Block Back', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_001_M', cname = 'Power Plant', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_002_M', cname = 'Tuned to Death', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_009_M', cname = 'Serpents of Destruction', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_010_M', cname = 'Take the Wheel', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_011_M', cname = 'Talk Shit Get Hit', part = 'mpimportexport_overlays'},
    
                {name = 'MP_LR_Tat_000_M', cname = 'SA Assault', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_008_M', cname = 'Love the Game', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_011_M', cname = 'Lady Liberty', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_012_M', cname = 'Royal Kiss', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_016_M', cname = 'Two Face', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_019_M', cname = 'Death Behind', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_031_M', cname = 'Dead Pretty', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_032_M', cname = 'Reign Over', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_001_M', cname = 'King Fight', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_002_M', cname = 'Holy Mary', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_004_M', cname = 'Gun Mic', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_009_M', cname = 'Amazon', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_010_M', cname = 'Bad Angel', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_013_M', cname = 'Love Gamble', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_014_M', cname = 'Love is Blind', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_021_M', cname = 'Sad Angel', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_026_M', cname = 'Royal Takeover', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_002_M', cname = 'The Howler', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_012_M', cname = 'Geometric Galaxy', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_022_M', cname = 'Cloaked Angel', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_025_M', cname = 'Reaper Sway', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_027_M', cname = 'Cobra Dawn', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_029_M', cname = 'Geometric Design', part = 'mpluxe2_overlays'},
    
                {name = 'MP_LUXE_TAT_003_M', cname = 'Abstract Skull', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_006_M', cname = 'Adorned Wolf', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_007_M', cname = 'Eye of the Griffin', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_008_M', cname = 'Flying Eye', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_014_M', cname = 'Ancient Queen', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_015_M', cname = 'Smoking Sisters', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_024_M', cname = 'Feather Mural', part = 'mpluxe_overlays'},
    
    
                {name = 'MP_Smuggler_Tattoo_002_M', cname = 'Dead Lies', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_003_M', cname = 'Give Nothing Back', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_007_M', cname = 'No Honor', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_009_M', cname = 'Tall Ship Conflict', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_010_M', cname = 'See You In Hell', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_013_M', cname = 'Torn Wings', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_015_M', cname = 'Jolly Roger', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_016_M', cname = 'Skull Compass', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_017_M', cname = 'Framed Tall Ship', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_018_M', cname = 'Finders Keepers', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_019_M', cname = 'Lost At Sea', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_021_M', cname = 'Dead Tales', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_022_M', cname = 'X Marks The Spot', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_024_M', cname = 'Pirate Captain', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_025_M', cname = 'Claimed By The Beast', part = 'mpsmuggler_overlays'},
    
    
                {name = 'MP_MP_Stunt_tat_011_M', cname = 'Wheels of Death', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_012_M', cname = 'Punk Biker', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_014_M', cname = 'Bat Cat of Spades', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_018_M', cname = 'Vintage Bully', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_019_M', cname = 'Engine Heart', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_024_M', cname = 'Road Kill', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_026_M', cname = 'Winged Wheel', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_027_M', cname = 'Punk Road Hog', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_029_M', cname = 'Majestic Finish', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_030_M', cname = "Man's Ruin", part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_033_M', cname = 'Sugar Skull Trucker', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_034_M', cname = 'Feather Road Kill', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_037_M', cname = 'Big Grills', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_040_M', cname = 'Monkey Chopper', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_041_M', cname = 'Brapp', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_044_M', cname = 'Ram Skull', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_046_M', cname = 'Full Throttle', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_048_M', cname = 'Racing Doll', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_M_003', cname = 'Blackjack', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_004', cname = 'Hustler', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_005', cname = 'Angel', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_008', cname = 'Los Santos Customs', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_011', cname = 'Blank Scroll', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_012', cname = 'Embellished Scroll', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_013', cname = 'Seven Deadly Sins', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_014', cname = 'Trust No One', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_016', cname = 'Clown', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_017', cname = 'Clown and Gun', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_018', cname = 'Clown Dual Wield', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_019', cname = 'Clown Dual Wield Dollars', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_004', cname = 'Faith', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_009', cname = 'kull on the Cross', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_010', cname = 'LS Flames', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_011', cname = 'LS Script', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_012', cname = 'Los Santos Bills', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_013', cname = 'Eagle and Serpent', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_016', cname = 'Evil Clown', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_019', cname = 'The Wages of Sin', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_020', cname = 'Dragon', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_024', cname = 'Flaming Cross', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_025', cname = 'LS Bold', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_029', cname = 'Trinity Knot', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_030', cname = 'Lucky Celtic Dogs', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_034', cname = 'Flaming Shamrock', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_036', cname = 'Way of the Gun', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_044', cname = 'Stone Cross', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_045', cname = 'Skulls and Rose', part = 'multiplayer_overlays'},
                
                
            }
        },
        head = {
            tattoo = {
                {name = 'MP_Bea_M_Head_000', cname = 'Pirate Skull', part = 'mpbeach_overlays'},                
                {name = 'MP_Bea_M_Neck_000', cname = 'Little Fish', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_M_Neck_001', cname = 'Surfs Up', part = 'mpbeach_overlays'},
    
                {name = 'MP_MP_Biker_Tat_009_M', cname = 'Morbid Arachnid', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_038_M', cname = 'FTW', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_051_M', cname = 'Western Stylized', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_M_Neck_000', cname = 'Cash is King', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_Neck_001', cname = 'Bold Dollar Sign', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_Neck_002', cname = 'Script Dollar Sign', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_Neck_003', cname = '100 Dollar', part = 'mpbusiness_overlays'},
    
                {name = 'MP_Xmas2_M_Tat_007', cname = 'Los Muertos', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_024', cname = 'Snake Head Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_025', cname = 'Snake Head Color', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_029', cname = 'Beautiful Death', part = 'mpchristmas2_overlays'},
    
                {name = 'FM_Hip_M_Tat_005', cname = 'Beautiful Eye', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_021', cname = 'Geo Fox', part = 'mphipster_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_011_M', cname = 'Sinner', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_012_M', cname = 'Thief', part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_Tat_000_M', cname = 'Stunt Skull', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_004_M', cname = 'Scorpion', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_006_M', cname = 'Toxic Spider', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_017_M', cname = 'Bat Wheel', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_042_M', cname = 'Flaming Quad', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_M_000', cname = 'Skull', part = 'multiplayer_overlays'},
                
            }
        },
        leftarm = {
            tattoo = {
                {name = 'MP_Airraces_Tattoo_003_M', cname = 'Toxic Trails', part = 'mpairraces_overlays'},                
                {name = 'MP_Bea_M_LArm_000', cname = 'Tiki Tower', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_M_LArm_001', cname = 'Mermaid L.S.', part = 'mpbeach_overlays'},
    
                {name = 'MP_MP_Biker_Tat_012_M', cname = 'Urban Stunter', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_016_M', cname = 'Macabre Tree', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_020_M', cname = 'Cranial Rose', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_024_M', cname = 'Live to Ride', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_025_M', cname = 'Good Luck', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_035_M', cname = 'Chain Fist', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_045_M', cname = 'Ride Hard Die Fast', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_053_M', cname = 'Muffler Helmet', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_055_M', cname = 'Poison Scorpion', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_M_LeftArm_000', cname = '$100 Bill', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_LeftArm_001', cname = 'All-Seeing Eye', part = 'mpbusiness_overlays'},
                
                {name = 'MP_Christmas2017_Tattoo_001_M', cname = 'Viking Warrior', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_004_M', cname = 'Tiger & Mask', part = 'mpchristmas2017_overlays'},                   
                {name = 'MP_Christmas2017_Tattoo_007_M', cname = 'Spartan Combat', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_013_M', cname = 'Katana', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_025_M', cname = 'Winged Serpent', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_029_M', cname = 'Cerberus', part = 'mpchristmas2017_overlays'},
    
                {name = 'MP_Xmas2_M_Tat_000', cname = 'Skull Rider', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_010', cname = 'Electric Snake', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_012', cname = '8 Ball Skull', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_020', cname = 'Times Up Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_021', cname = 'Times Up Color', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_004_M', cname = 'Sidearm', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_008_M', cname = 'Bandolier', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_015_M', cname = 'Spiked Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_016_M', cname = 'Blood Money', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_025_M', cname = 'Praying Skull', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_M_Tat_003', cname = 'Diamond Sparkle', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_007', cname = 'Bricks', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_015', cname = 'Mustache', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_016', cname = 'Lightning Bolt', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_026', cname = 'Pizza', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_027', cname = 'Padlock', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_028', cname = 'Thorny Rose', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_034', cname = 'Stop', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_039', cname = 'Sleeve', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_043', cname = 'Triangle White', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_048', cname = 'Peace', part = 'mphipster_overlays'},
    
                {name = 'MP_MP_ImportExport_Tat_004_M', cname = 'Piston Sleeve', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_008_M', cname = 'Scarlett', part = 'mpimportexport_overlays'},
    
                {name = 'MP_LR_Tat_006_M', cname = 'Love Hustle', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_018_M', cname = 'Skeleton Party', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_022_M', cname = 'My Crazy Life', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_005_M', cname = 'No Evil', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_027_M', cname = 'Los Santos Life', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_033_M', cname = 'City Sorrow', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_005_M', cname = 'Fatal Dagger', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_016_M', cname = 'Egyptian Mural', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_018_M', cname = 'Divine Goddess', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_028_M', cname = 'Python Skull', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_031_M', cname = 'Geometric Design', part = 'mpluxe2_overlays'},
    
                {name = 'MP_LUXE_TAT_009_M', cname = 'Floral Symmetry', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_020_M', cname = 'Archangel & Mary', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_021_M', cname = 'Gabriel', part = 'mpluxe_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_008_M', cname = 'Horrors Of The Deep', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_014_M', cname = "Mermaid's Curse", part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_tat_001_M', cname = '8 Eyed Skull', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_002_M', cname = 'Big Cat', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_008_M', cname = 'Moonlight Ride', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_022_M', cname = 'Piston Head', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_023_M', cname = 'Tanked', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_035_M', cname = "Stuntman's End", part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_039_M', cname = 'Kaboom', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_043_M', cname = 'Engine Arm', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_M_001', cname = 'Burning Heart', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_007', cname = 'Racing Blonde', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_015', cname = 'Racing Brunette', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_005', cname = 'Serpents', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_006', cname = 'Oriental Mural', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_015', cname = 'Zodiac Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_031', cname = 'Lady M', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_041', cname = 'Dope Skull', part = 'multiplayer_overlays'},
    
            }
        },
        rightarm = {
            tattoo = {
                {name = 'MP_Bea_M_RArm_000', cname = 'Tribal Sun', part = 'mpbeach_overlays'},                
                {name = 'MP_Bea_M_RArm_001', cname = 'Vespucci Beauty', part = 'mpbeach_overlays'},
    
                {name = 'MP_MP_Biker_Tat_007_M', cname = 'Swooping Eagle', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_014_M', cname = 'Lady Mortality', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_033_M', cname = 'Eagle Emblem', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_042_M', cname = 'Grim Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_046_M', cname = 'Skull Chain', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_047_M', cname = 'Snake Bike', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_049_M', cname = 'These Colors Dont Run', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_054_M', cname = 'Mum', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_M_RightArm_000', cname = 'Dollar Skull', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_M_RightArm_001', cname = 'Green', part = 'mpbusiness_overlays'},                    
                
                {name = 'MP_Christmas2017_Tattoo_006_M', cname = 'Full Black', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_012_M', cname = 'Tiger Headdress', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_014_M', cname = 'Celtic Band', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_017_M', cname = 'Feather Sleeve', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_018_M', cname = 'Muscle Tear', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_023_M', cname = 'Samurai Tallship', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_028_M', cname = 'Spartan Mural', part = 'mpchristmas2017_overlays'},
    
                {name = 'MP_Xmas2_M_Tat_003', cname = 'Snake Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_004', cname = 'Snake Shaded', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_008', cname = 'Death Before Dishonor', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_022', cname = "You're Next Outline", part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_023', cname = "You're Next Color", part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_026', cname = 'Fuck Luck Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_027', cname = 'Fuck Luck Color', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_002_M', cname = 'Single', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_021_M', cname = 'Have a Nice Day', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_024_M', cname = 'Combat Reaper', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_M_Tat_001', cname = 'Single Arrow', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_004', cname = 'Bone', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_008', cname = 'Cube', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_010', cname = 'Horseshoe', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_014', cname = 'Spray Can', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_017', cname = 'Eye Triangle', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_018', cname = 'Origami', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_020', cname = 'Geo Pattern', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_022', cname = 'Pencil', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_023', cname = 'Smiley', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_036', cname = 'Shapes', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_044', cname = 'Triangle Black', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_045', cname = 'Mesh Band', part = 'mphipster_overlays'},
    
                {name = 'MP_LR_Tat_003_M', cname = 'Lady Vamp', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_028_M', cname = 'Loving Los Muertos', part = 'mplowrider2_overlays'},
                {name = 'MP_LR_Tat_035_M', cname = 'Black Tears', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_015_M', cname = 'Seductress', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_010_M', cname = 'Intrometric', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_017_M', cname = 'Heavenly Deity', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_026_M', cname = 'Floral Print', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_030_M', cname = 'Geometric Design', part = 'mpluxe2_overlays'},
    
                {name = 'MP_LUXE_TAT_004_M', cname = 'Floral Raven', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_013_M', cname = 'Mermaid Harpist', part = 'mpluxe_overlays'},
                {name = 'MP_LUXE_TAT_019_M', cname = 'Geisha Bloom', part = 'mpluxe_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_001_M', cname = 'Crackshot', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_005_M', cname = 'Mutiny', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_023_M', cname = 'Stylized Kraken', part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_tat_003_M', cname = 'Poison Wrench', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_009_M', cname = 'Arachnid of Death', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_010_M', cname = 'Grave Vulture', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_016_M', cname = 'Coffin Racer', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_036_M', cname = 'Biker Stallion', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_038_M', cname = 'One Down Five Up', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_049_M', cname = 'Seductive Mechanic', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_M_002', cname = 'Grim Reaper Smoking Gun', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_M_010', cname = 'Ride or Die', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_000', cname = 'Brotherhood', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_001', cname = 'Dragons', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_003', cname = 'Dragons and Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_014', cname = 'Flower Mural', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_018', cname = 'Serpent Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_027', cname = 'Virgin Mary', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_028', cname = 'Mermaid', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_038', cname = 'Dagger', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_047', cname = 'Lion', part = 'multiplayer_overlays'},
            }
        },
        leftleg = {
            tattoo = {
                {name = 'MP_Bea_M_Lleg_000', cname = 'Tribal Star', part = 'mpbeach_overlays'},  
    
                {name = 'MP_MP_Biker_Tat_002_M', cname = 'Rose Tribute', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_015_M', cname = 'Ride or Die', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_027_M', cname = 'Bad Luck', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_036_M', cname = 'Engulfed Skull', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_037_M', cname = 'Scorched Soul', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_044_M', cname = 'Ride Free', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_056_M', cname = 'Bone Cruiser', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_057_M', cname = 'Laughing Skull', part = 'mpbiker_overlays'}, 
    
                {name = 'MP_Xmas2_M_Tat_001', cname = 'Spider Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_M_Tat_002', cname = 'Spider Color', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_005_M', cname = 'Patriot Skull', part = 'mpgunrunning_overlays'},                   
                {name = 'MP_Gunrunning_Tattoo_007_M', cname = 'Stylized Tiger', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_011_M', cname = 'Death Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_023_M', cname = 'Rose Revolver', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_M_Tat_009', cname = 'Squares', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_019', cname = 'Charm', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_040', cname = 'Black Anchor', part = 'mphipster_overlays'},
    
                {name = 'MP_LR_Tat_029_M', cname = 'Death Us Do Part', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_007_M', cname = 'LS Serpent', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_020_M', cname = 'Presidents', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_011_M', cname = 'Cross of Roses', part = 'mpluxe2_overlays'},
    
                {name = 'MP_LUXE_TAT_000_M', cname = 'Serpent of Death', part = 'mpluxe_overlays'},
    
                {name = 'MP_MP_Stunt_tat_007_M', cname = 'Dagger Devil', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_013_M', cname = 'Dirt Track Hero', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_021_M', cname = 'Golden Cobra', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_M_009', cname = 'Dragon and Dagger', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_002', cname = 'Melting Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_008', cname = 'Dragon Mural', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_021', cname = 'Serpent Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_023', cname = 'Hottie', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_026', cname = 'Smoking Dagger', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_032', cname = 'Faith', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_033', cname = 'Chinese Dragon', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_035', cname = 'Dragon', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_M_037', cname = 'Grim Reaper', part = 'multiplayer_overlays'}, 
    
            }
        },
        rightleg = {
            tattoo = {
                {name = 'MP_Bea_M_Rleg_000', cname = 'Tribal Tiki Tower', part = 'mpbeach_overlays'},    
                
                {name = 'MP_MP_Biker_Tat_004_M', cname = 'Dragons Fury', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_022_M', cname = 'Western Insignia', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_028_M', cname = 'Dusk Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_040_M', cname = 'American Made', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_048_M', cname = 'STFU', part = 'mpbiker_overlays'},
    
                {name = 'MP_Xmas2_M_Tat_014', cname = 'Floral Dagger', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_006_M', cname = 'Combat Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_026_M', cname = 'Restless Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_030_M', cname = 'Pistol Ace', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_M_Tat_038', cname = 'Grub', part = 'mphipster_overlays'},
                {name = 'FM_Hip_M_Tat_042', cname = 'Sparkplug', part = 'mphipster_overlays'},
    
                {name = 'MP_LR_Tat_030_M', cname = 'San Andreas Prayer', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_017_M', cname = 'Ink Me', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_023_M', cname = 'Dance of Hearts', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_023_M', cname = 'Starmetric', part = 'mpluxe2_overlays'},
    
                {name = 'MP_LUXE_TAT_001_M', cname = 'Elaborate Los Muertos', part = 'mpluxe_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_020_M', cname = 'Homeward Bound', part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_tat_005_M', cname = 'Demon Spark Plug', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_015_M', cname = 'Praying Gloves', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_020_M', cname = 'Piston Angel', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_025_M', cname = 'Speed Freak', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_032_M', cname = 'Wheelie Mouse', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_045_M', cname = 'Severed Hand', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_047_M', cname = 'Brake Knife', part = 'mpstunt_overlays'},
                                   
                {name = 'FM_Tat_M_043', cname = 'Indian Ram', part = 'multiplayer_overlays'},
            }
        },
        hair = {
            tattoo = {

                {name = 'FM_Hair_Fuzz', cname = 'Micropig01', part = 'mpbeach_overlays'},
                {name = 'NG_M_Hair_001', cname = 'Micropig02', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_002', cname = 'Micropig03', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_003', cname = 'Micropig04', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_004', cname = 'Micropig05', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_005', cname = 'Micropig06', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_006', cname = 'Micropig07', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_007', cname = 'Micropig08', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_008', cname = 'Micropig09', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_009', cname = 'Micropig10', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_013', cname = 'Micropig11', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_002', cname = 'Micropig11', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_011', cname = 'Micropig12', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_012', cname = 'Micropig13', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_014', cname = 'Micropig14', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_015', cname = 'Micropig15', part = 'multiplayer_overlays'},
                {name = 'NGBea_M_Hair_000', cname = 'Micropig16', part = 'multiplayer_overlays'},
                {name = 'NGBea_M_Hair_001', cname = 'Micropig17', part = 'multiplayer_overlays'},
                {name = 'NGBus_M_Hair_000', cname = 'Micropig18', part = 'multiplayer_overlays'},
                {name = 'NGBus_M_Hair_001', cname = 'Micropig19', part = 'multiplayer_overlays'},
                {name = 'NGHip_M_Hair_000', cname = 'Micropig20', part = 'multiplayer_overlays'},
                {name = 'NGHip_M_Hair_001', cname = 'Micropig21', part = 'multiplayer_overlays'},
                {name = 'NGInd_M_Hair_000', cname = 'Micropig22', part = 'multiplayer_overlays'},
                {name = 'LR_M_Hair_000', cname = 'Micropig23', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_001', cname = 'Micropig24', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_002', cname = 'Micropig25', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_003', cname = 'Micropig26', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_004', cname = 'Micropig27', part = 'mplowrider2_overlays'},
                {name = 'LR_M_Hair_005', cname = 'Micropig28', part = 'mplowrider2_overlays'},
                {name = 'LR_M_Hair_006', cname = 'Micropig29', part = 'mplowrider2_overlays'},
                {name = 'MP_Biker_Hair_000_M', cname = 'Micropig30', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_001_M', cname = 'Micropig31', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_002_M', cname = 'Micropig32', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_003_M', cname = 'Micropig33', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_004_M', cname = 'Micropig34', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_005_M', cname = 'Micropig35', part = 'mpbiker_overlays'},
                {name = 'NG_M_Hair_001', cname = 'Micropig36', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_002', cname = 'Micropig37', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_003', cname = 'Micropig38', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_004', cname = 'Micropig39', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_005', cname = 'Micropig40', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_006', cname = 'Micropig41', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_007', cname = 'Micropig42', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_008', cname = 'Micropig43', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_009', cname = 'Micropig44', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_013', cname = 'Micropig45', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_002', cname = 'Micropig46', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_011', cname = 'Micropig47', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_012', cname = 'Micropig48', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_014', cname = 'Micropig49', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_015', cname = 'Micropig50', part = 'multiplayer_overlays'},
                {name = 'NGBea_M_Hair_000', cname = 'Micropig51', part = 'multiplayer_overlays'},
                {name = 'NGBea_M_Hair_001', cname = 'Micropig52', part = 'multiplayer_overlays'},
                {name = 'NGBus_M_Hair_000', cname = 'Micropig53', part = 'multiplayer_overlays'},
                {name = 'NGBus_M_Hair_001', cname = 'Micropig54', part = 'multiplayer_overlays'},
                {name = 'NGHip_M_Hair_000', cname = 'Micropig55', part = 'multiplayer_overlays'},
                {name = 'NGHip_M_Hair_001', cname = 'Micropig56', part = 'multiplayer_overlays'},
                {name = 'NGInd_M_Hair_000', cname = 'Micropig57', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_000', cname = 'Micropig58', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_001', cname = 'Micropig59', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_002', cname = 'Micropig60', part = 'mplowrider_overlays'},
                {name = 'LR_M_Hair_003', cname = 'Micropig61', part = 'mplowrider2_overlays'},
                {name = 'LR_M_Hair_004', cname = 'Micropig62', part = 'mplowrider2_overlays'},
                {name = 'LR_M_Hair_005', cname = 'Micropig63', part = 'mplowrider2_overlays'},
                {name = 'LR_M_Hair_006', cname = 'Micropig64', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_000_M', cname = 'Micropig65', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_001_M', cname = 'Micropig66', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_002_M', cname = 'Micropig67', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_003_M', cname = 'Micropig68', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_004_M', cname = 'Micropig69', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_005_M', cname = 'Micropig70', part = 'mpbiker_overlays'},
                {name = 'MP_Gunrunning_Hair_M_000_M', cname = 'Micropig72', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Hair_M_001_M', cname = 'Micropig73', part = 'mpgunrunning_overlays'}
            }
        } 
    },
    
    
    
    
    
    
    
    
    ['partsF'] = {
        torso = {
            tattoo = {
                {name = 'MP_Airraces_Tattoo_000_F', cname = 'Turbulence', part = 'mpairraces_overlays'},                
                {name = 'MP_Airraces_Tattoo_001_F', cname = 'Pilot Skull', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_002_F', cname = 'Winged Bombshell', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_004_F', cname = 'Balloon Pioneer', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_005_F', cname = 'Parachute Belle', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_006_F', cname = 'Bombs Away', part = 'mpairraces_overlays'},
                {name = 'MP_Airraces_Tattoo_007_F', cname = 'Eagle Eyes', part = 'mpairraces_overlays'},
    
                {name = 'MP_Bea_F_Back_000', cname = 'Rock Solid', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Back_001', cname = 'Hibiscus Flower Duo', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Back_002', cname = 'Shrimp', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Chest_000', cname = 'Anchor', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Chest_001', cname = 'Anchor 2', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Chest_002', cname = 'Los Santos Wreath', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_RSide_000', cname = 'Love Dagger', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Should_000', cname = 'Sea Horses', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Should_001', cname = 'Catfish', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Stom_000', cname = 'Swallow', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Stom_001', cname = 'Hibiscus Flower', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_Stom_002', cname = 'Dolphin', part = 'mpbeach_overlays'},
    
                {name = 'MP_MP_Biker_Tat_000_F', cname = 'Demon Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_001_F', cname = 'Both Barrels', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_003_F', cname = 'Web Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_005_F', cname = 'Made In America', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_006_F', cname = 'Chopper Freedom', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_008_F', cname = 'Freedom Wheels', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_010_F', cname = 'Skull Of Taurus', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_011_F', cname = 'R.I.P. My Brothers', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_013_F', cname = 'Demon Crossbones', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_017_F', cname = 'Clawed Beast', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_018_F', cname = 'Skeletal Chopper', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_019_F', cname = 'Gruesome Talons', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_021_F', cname = 'Flaming Reaper', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_023_F', cname = 'Western MC', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_026_F', cname = 'American Dream', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_029_F', cname = 'Bone Wrench', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_030_F', cname = 'Brothers For Life', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_031_F', cname = 'Gear Head', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_032_F', cname = 'Western Eagle', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_034_F', cname = 'Brotherhood of Bikes', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_039_F', cname = 'Gas Guzzler', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_041_F', cname = 'No Regrets', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_043_F', cname = 'Ride Forever', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_050_F', cname = 'Unforgiven', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_052_F', cname = 'Biker Mount', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_058_F', cname = 'Reaper Vulture', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_059_F', cname = 'Faggio', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_060_F', cname = 'We Are The Mods!', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_F_Chest_000', cname = 'High Roller', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Chest_001', cname = 'Makin Money', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Chest_002', cname = 'Love Money', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Stom_000', cname = 'Diamond Back', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Stom_001', cname = 'Santo Capra Logo', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Stom_002', cname = 'Money Bag', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Back_000', cname = 'Respect', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Back_001', cname = 'Gold Digger', part = 'mpbusiness_overlays'},
    
                {name = 'MP_Christmas2017_Tattoo_000_F', cname = 'Thor & Goblin', part = 'mpchristmas2017_overlays'},                    
                {name = 'MP_Christmas2017_Tattoo_002_F', cname = 'Kabuto', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_003_F', cname = 'Native Warrior', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_005_F', cname = 'Ghost Dragon', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_008_F', cname = 'Spartan Warrior', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_009_F', cname = 'Norse Rune', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_010_F', cname = 'Spartan Shield', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_011_F', cname = 'Weathered Skull', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_015_F', cname = 'Samurai Combat', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_016_F', cname = 'Odin & Raven', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_019_F', cname = 'Strike Force', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_020_F', cname = 'Medusa Gaze', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_021_F', cname = 'Spartan & Lion', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_022_F', cname = 'Spartan & Horse', part = 'mpchristmas2017_overlays'}, 
                {name = 'MP_Christmas2017_Tattoo_024_F', cname = 'Dragon Slayer', part = 'mpchristmas2017_overlays'},                   
                {name = 'MP_Christmas2017_Tattoo_026_F', cname = 'Spartan Skull', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_027_F', cname = 'Molon Labe', part = 'mpchristmas2017_overlays'},
    
               -- {name = 'MP_Christmas2018_Tat_000_F', cname = 'Simbolo', part = 'mpchristmas2018_overlays'},
    
                {name = 'MP_Xmas2_F_Tat_005', cname = 'Carp Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_006', cname = 'Carp Shaded', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_009', cname = 'Time To Die', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_011', cname = 'Roaring Tiger', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_013', cname = 'Lizard', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_015', cname = 'Japanese Warrior', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_016', cname = 'Loose Lips Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_017', cname = 'Loose Lips Color', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_018', cname = 'Royal Dagger Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_019', cname = 'Royal Dagger Color', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_028', cname = 'Executioner', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_000_F', cname = 'Bullet Proof', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_001_F', cname = 'Crossed Weapons', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_009_F', cname = 'Butterfly Knife', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_010_F', cname = 'Cash Money', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_012_F', cname = 'Dollar Daggers', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_013_F', cname = 'Wolf Insignia', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_014_F', cname = 'Backstabber', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_017_F', cname = 'Dog Tags', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_018_F', cname = 'Dual Wield Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_019_F', cname = 'Pistol Wings', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_020_F', cname = 'Crowned Weapons', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_022_F', cname = 'Explosive Heart', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_028_F', cname = 'Micro SMG Chain', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_029_F', cname = 'Win Some Lose Some', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_F_Tat_000', cname = 'Crossed Arrows', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_002', cname = 'Chemistry', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_006', cname = 'Feather Birds', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_011', cname = 'Infinity', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_012', cname = 'Antlers', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_013', cname = 'Boombox', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_024', cname = 'Pyramid', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_025', cname = 'Watch Your Step', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_029', cname = 'Sad', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_030', cname = 'Shark Fin', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_031', cname = 'Skateboard', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_032', cname = 'Paper Plane', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_033', cname = 'Stag', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_035', cname = 'Sewn Heart', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_041', cname = 'Tooth', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_046', cname = 'Triangles', part = 'mphipster_overlays'},
               -- {name = 'FM_Hip_F_Tat_047', cname = 'Cassette', part = 'mphipster_overlays'},
    
                {name = 'MP_MP_ImportExport_Tat_000_F', cname = 'Block Back', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_001_F', cname = 'Power Plant', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_002_F', cname = 'Tuned to Death', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_009_F', cname = 'Serpents of Destruction', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_010_F', cname = 'Take the Wheel', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_011_F', cname = 'Talk Shit Get Hit', part = 'mpimportexport_overlays'},
    
               -- {name = 'MP_LR_Tat_000_F', cname = 'SA Assault', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_008_F', cname = 'Love the Game', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_011_F', cname = 'Lady Liberty', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_012_F', cname = 'Royal Kiss', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_016_F', cname = 'Two Face', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_019_F', cname = 'Death Behind', part = 'mplowrider2_overlays'},
              --  {name = 'MP_LR_Tat_031_F', cname = 'Dead Pretty', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_032_F', cname = 'Reign Over', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_001_F', cname = 'King Fight', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_002_F', cname = 'Holy Mary', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_004_F', cname = 'Gun Mic', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_009_F', cname = 'Amazon', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_010_F', cname = 'Bad Angel', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_013_F', cname = 'Love Gamble', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_014_F', cname = 'Love is Blind', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_021_F', cname = 'Sad Angel', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_026_F', cname = 'Royal Takeover', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_002_F', cname = 'The Howler', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_012_F', cname = 'Geometric Galaxy', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_022_F', cname = 'Cloaked Angel', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_025_F', cname = 'Reaper Sway', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_027_F', cname = 'Cobra Dawn', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_029_F', cname = 'Geometric Design', part = 'mpluxe2_overlays'},
    
                --{name = 'MP_LUXE_TAT_003_F', cname = 'Abstract Skull', part = 'mpluxe_overlays'},
               -- {name = 'MP_LUXE_TAT_006_F', cname = 'Adorned Wolf', part = 'mpluxe_overlays'},
                --{name = 'MP_LUXE_TAT_007_F', cname = 'Eye of the Griffin', part = 'mpluxe_overlays'},
              --  {name = 'MP_LUXE_TAT_008_F', cname = 'Flying Eye', part = 'mpluxe_overlays'},
               -- {name = 'MP_LUXE_TAT_014_F', cname = 'Ancient Queen', part = 'mpluxe_overlays'},
               -- {name = 'MP_LUXE_TAT_015_F', cname = 'Smoking Sisters', part = 'mpluxe_overlays'},
               -- {name = 'MP_LUXE_TAT_024_F', cname = 'Feather Mural', part = 'mpluxe_overlays'},
    
    
                {name = 'MP_Smuggler_Tattoo_002_F', cname = 'Dead Lies', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_003_F', cname = 'Give Nothing Back', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_007_F', cname = 'No Honor', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_009_F', cname = 'Tall Ship Conflict', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_010_F', cname = 'See You In Hell', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_013_F', cname = 'Torn Wings', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_015_F', cname = 'Jolly Roger', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_016_F', cname = 'Skull Compass', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_017_F', cname = 'Framed Tall Ship', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_018_F', cname = 'Finders Keepers', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_019_F', cname = 'Lost At Sea', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_021_F', cname = 'Dead Tales', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_022_F', cname = 'X Marks The Spot', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_024_F', cname = 'Pirate Captain', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_025_F', cname = 'Claimed By The Beast', part = 'mpsmuggler_overlays'},
    
    
                {name = 'MP_MP_Stunt_tat_011_F', cname = 'Wheels of Death', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_012_F', cname = 'Punk Biker', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_014_F', cname = 'Bat Cat of Spades', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_018_F', cname = 'Vintage Bully', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_019_F', cname = 'Engine Heart', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_024_F', cname = 'Road Kill', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_026_F', cname = 'Winged Wheel', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_027_F', cname = 'Punk Road Hog', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_029_F', cname = 'Majestic Finish', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_030_F', cname = "Man's Ruin", part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_033_F', cname = 'Sugar Skull Trucker', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_034_F', cname = 'Feather Road Kill', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_037_F', cname = 'Big Grills', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_040_F', cname = 'Monkey Chopper', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_041_F', cname = 'Brapp', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_044_F', cname = 'Ram Skull', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_046_F', cname = 'Full Throttle', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_048_F', cname = 'Racing Doll', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_F_003', cname = 'Blackjack', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_004', cname = 'Hustler', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_005', cname = 'Angel', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_008', cname = 'Los Santos Customs', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_011', cname = 'Blank Scroll', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_012', cname = 'Embellished Scroll', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_013', cname = 'Seven Deadly Sins', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_014', cname = 'Trust No One', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_016', cname = 'Clown', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_017', cname = 'Clown and Gun', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_018', cname = 'Clown Dual Wield', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_019', cname = 'Clown Dual Wield Dollars', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_004', cname = 'Faith', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_009', cname = 'kull on the Cross', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_010', cname = 'LS Flames', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_011', cname = 'LS Script', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_012', cname = 'Los Santos Bills', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_013', cname = 'Eagle and Serpent', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_016', cname = 'Evil Clown', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_019', cname = 'The Wages of Sin', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_020', cname = 'Dragon', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_024', cname = 'Flaming Cross', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_025', cname = 'LS Bold', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_029', cname = 'Trinity Knot', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_030', cname = 'Lucky Celtic Dogs', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_034', cname = 'Flaming Shamrock', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_036', cname = 'Way of the Gun', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_044', cname = 'Stone Cross', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_045', cname = 'Skulls and Rose', part = 'multiplayer_overlays'},
               -- {name = 'FM_Hip_F_Tat_047', cname = 'Cassette', part = 'multiplayer_overlays'},
               -- {name = 'FM_Hip_F_Tat_047', cname = 'Cassette', part = 'multiplayer_overlays'},
            }
        },
        head = {
            
            tattoo = {
                {name = 'MP_Bea_F_Neck_000', cname = 'Tribal Butterfly', part = 'mpbeach_overlays'},    
    
                {name = 'MP_MP_Biker_Tat_009_F', cname = 'Morbid Arachnid', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_038_F', cname = 'FTW', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_051_F', cname = 'Western Stylized', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_F_Neck_000', cname = 'Val-de-Grace Logo', part = 'mpbusiness_overlays'},
                {name = 'MP_Buis_F_Neck_001', cname = 'Money Rose', part = 'mpbusiness_overlays'},
    
               -- {name = 'MP_Xmas2_F_Tat_007', cname = 'Los Muertos', part = 'mpbusiness_overlays'},
               -- {name = 'MP_Xmas2_F_Tat_024', cname = 'Snake Head Outline', part = 'mpbusiness_overlays'},
               -- {name = 'MP_Xmas2_F_Tat_025', cname = 'Snake Head Color', part = 'mpbusiness_overlays'},
              --  {name = 'MP_Xmas2_F_Tat_029', cname = 'Beautiful Death', part = 'mpbusiness_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_003_F', cname = 'Lock & Load', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_F_Tat_005', cname = 'Beautiful Eye', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_021', cname = 'Geo Fox', part = 'mphipster_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_011_F', cname = 'Sinner', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_012_F', cname = 'Thief', part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_Tat_000_F', cname = 'Stunt Skull', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_004_F', cname = 'Scorpion', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_006_F', cname = 'Toxic Spider', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_017_F', cname = 'Bat Wheel', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_042_F', cname = 'Flaming Quad', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_F_000', cname = 'Skull', part = 'multiplayer_overlays'},
            }
        },
        leftarm = {
            
            tattoo = {
                {name = 'MP_Airraces_Tattoo_003_F', cname = 'Full Black', part = 'mpairraces_overlays'},                
                {name = 'MP_Bea_F_LArm_000', cname = 'Tribal Flower', part = 'mpbeach_overlays'},
                {name = 'MP_Bea_F_LArm_001', cname = 'Parrot', part = 'mpbeach_overlays'},
    
                {name = 'MP_MP_Biker_Tat_012_F', cname = 'Urban Stunter', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_016_F', cname = 'Macabre Tree', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_020_F', cname = 'Cranial Rose', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_024_F', cname = 'Live to Ride', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_025_F', cname = 'Good Luck', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_035_F', cname = 'Chain Fist', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_045_F', cname = 'Ride Hard Die Fast', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_053_F', cname = 'Muffler Helmet', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_055_F', cname = 'Poison Scorpion', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_F_LArm_000', cname = 'Greed is Good', part = 'mpbusiness_overlays'},
    
                {name = 'MP_Christmas2017_Tattoo_001_F', cname = 'Viking Warrior', part = 'mpchristmas2017_overlays'},
    
                {name = 'MP_Christmas2017_Tattoo_004_F', cname = 'Tiger & Mask', part = 'mpchristmas2017_overlays'},                   
                {name = 'MP_Christmas2017_Tattoo_007_F', cname = 'Spartan Combat', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_013_F', cname = 'Katana', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_025_F', cname = 'Winged Serpent', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_029_F', cname = 'Cerberus', part = 'mpchristmas2017_overlays'},
    
                {name = 'MP_Xmas2_F_Tat_000', cname = 'Skull Rider', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_010', cname = 'Electric Snake', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_012', cname = '8 Ball Skull', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_020', cname = 'Times Up Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_021', cname = 'Times Up Color', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_004_F', cname = 'Sidearm', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_008_F', cname = 'Bandolier', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_015_F', cname = 'Spiked Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_016_F', cname = 'Blood Money', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_025_F', cname = 'Praying Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_027_F', cname = 'Serpent Revolver', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_F_Tat_003', cname = 'Diamond Sparkle', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_007', cname = 'Bricks', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_015', cname = 'Mustache', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_016', cname = 'Lightning Bolt', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_026', cname = 'Pizza', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_027', cname = 'Padlock', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_028', cname = 'Thorny Rose', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_034', cname = 'Stop', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_039', cname = 'Sleeve', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_043', cname = 'Triangle White', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_048', cname = 'Peace', part = 'mphipster_overlays'},
    
                {name = 'MP_MP_ImportExport_Tat_004_F', cname = 'Piston Sleeve', part = 'mpimportexport_overlays'},
                {name = 'MP_MP_ImportExport_Tat_008_F', cname = 'Scarlett', part = 'mpimportexport_overlays'},
    
               -- {name = 'MP_LR_Tat_006_F', cname = 'Love Hustle', part = 'mplowrider2_overlays'},
              --  {name = 'MP_LR_Tat_018_F', cname = 'Skeleton Party', part = 'mplowrider2_overlays'},
              --  {name = 'MP_LR_Tat_022_F', cname = 'My Crazy Life', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_005_F', cname = 'No Evil', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_027_F', cname = 'Los Santos Life', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_033_F', cname = 'City Sorrow', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_005_F', cname = 'Fatal Dagger', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_016_F', cname = 'Egyptian Mural', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_018_F', cname = 'Divine Goddess', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_028_F', cname = 'Python Skull', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_031_F', cname = 'Geometric Design', part = 'mpluxe2_overlays'},
    
               -- {name = 'MP_LUXE_TAT_009_F', cname = 'Floral Symmetry', part = 'mpluxe_overlays'},
               -- {name = 'MP_LUXE_TAT_020_F', cname = 'Archangel & Mary', part = 'mpluxe_overlays'},
               -- {name = 'MP_LUXE_TAT_021_F', cname = 'Gabriel', part = 'mpluxe_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_008_F', cname = 'Horrors Of The Deep', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_014_F', cname = "Mermaid's Curse", part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_tat_001_F', cname = '8 Eyed Skull', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_002_F', cname = 'Big Cat', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_008_F', cname = 'Moonlight Ride', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_022_F', cname = 'Piston Head', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_023_F', cname = 'Tanked', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_035_F', cname = "Stuntman's End", part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_039_F', cname = 'Kaboom', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_043_F', cname = 'Engine Arm', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_F_001', cname = 'Burning Heart', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_007', cname = 'Racing Blonde', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_015', cname = 'Racing Brunette', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_005', cname = 'Serpents', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_006', cname = 'Oriental Mural', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_015', cname = 'Zodiac Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_031', cname = 'Lady M', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_041', cname = 'Dope Skull', part = 'multiplayer_overlays'},
            }
        },
        rightarm = {
            
            tattoo = {
                {name = 'MP_Bea_F_RArm_001', cname = 'Tribal Fish', part = 'mpbeach_overlays'},
    
                {name = 'MP_MP_Biker_Tat_007_F', cname = 'Swooping Eagle', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_014_F', cname = 'Lady Mortality', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_033_F', cname = 'Eagle Emblem', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_042_F', cname = 'Grim Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_046_F', cname = 'Skull Chain', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_047_F', cname = 'Snake Bike', part = 'mpbiker_overlays'},                    
                {name = 'MP_MP_Biker_Tat_049_F', cname = 'These Colors Dont Run', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_054_F', cname = 'Mum', part = 'mpbiker_overlays'},
    
                {name = 'MP_Buis_F_RArm_000', cname = 'Dollar Sign', part = 'mpbusiness_overlays'},
    
                {name = 'MP_Christmas2017_Tattoo_006_F', cname = 'Medusa', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_012_F', cname = 'Tiger Headdress', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_014_F', cname = 'Celtic Band', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_017_F', cname = 'Feather Sleeve', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_018_F', cname = 'Muscle Tear', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_023_F', cname = 'Samurai Tallship', part = 'mpchristmas2017_overlays'},
                {name = 'MP_Christmas2017_Tattoo_028_F', cname = 'Spartan Mural', part = 'mpchristmas2017_overlays'},
    
                {name = 'MP_Xmas2_F_Tat_003', cname = 'Snake Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_004', cname = 'Snake Shaded', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_008', cname = 'Death Before Dishonor', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_022', cname = "You're Next Outline", part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_023', cname = "You're Next Color", part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_026', cname = 'Fuck Luck Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_027', cname = 'Fuck Luck Color', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_002_F', cname = 'Grenade', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_021_F', cname = 'Have a Nice Day', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_024_F', cname = 'Combat Reaper', part = 'mpgunrunning_overlays'},
    
                {name = 'FM_Hip_F_Tat_001', cname = 'Single Arrow', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_004', cname = 'Bone', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_008', cname = 'Cube', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_010', cname = 'Horseshoe', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_014', cname = 'Spray Can', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_017', cname = 'Eye Triangle', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_018', cname = 'Origami', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_020', cname = 'Geo Pattern', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_022', cname = 'Pencil', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_023', cname = 'Smiley', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_036', cname = 'Shapes', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_044', cname = 'Triangle Black', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_045', cname = 'Mesh Band', part = 'mphipster_overlays'},
    
               -- {name = 'MP_MP_ImportExport_Tat_003_M', cname = 'Mechanical Sleeve', part = 'mpimportexport_overlays'},
              --  {name = 'MP_MP_ImportExport_Tat_005_M', cname = 'Dialed In', part = 'mpimportexport_overlays'},
              --  {name = 'MP_MP_ImportExport_Tat_006_M', cname = 'Engulfed Block', part = 'mpimportexport_overlays'},
--{name = 'MP_MP_ImportExport_Tat_007_M', cname = 'Drive Forever', part = 'mpimportexport_overlays'},
    
               -- {name = 'MP_LR_Tat_003_F', cname = 'Lady Vamp', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_028_F', cname = 'Loving Los Muertos', part = 'mplowrider2_overlays'},
               -- {name = 'MP_LR_Tat_035_F', cname = 'Black Tears', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_015_F', cname = 'Seductress', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_010_F', cname = 'Intrometric', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_017_F', cname = 'Heavenly Deity', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_026_F', cname = 'Floral Print', part = 'mpluxe2_overlays'},
                {name = 'MP_LUXE_TAT_030_F', cname = 'Geometric Design', part = 'mpluxe2_overlays'},
    
              --  {name = 'MP_LUXE_TAT_004_F', cname = 'Floral Raven', part = 'mpluxe_overlays'},
              --  {name = 'MP_LUXE_TAT_013_F', cname = 'Mermaid Harpist', part = 'mpluxe_overlays'},
              --  {name = 'MP_LUXE_TAT_019_F', cname = 'Geisha Bloom', part = 'mpluxe_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_001_F', cname = 'Crackshot', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_005_F', cname = 'Mutiny', part = 'mpsmuggler_overlays'},
                {name = 'MP_Smuggler_Tattoo_023_F', cname = 'Stylized Kraken', part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_tat_003_F', cname = 'Poison Wrench', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_009_F', cname = 'Arachnid of Death', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_010_F', cname = 'Grave Vulture', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_016_F', cname = 'Coffin Racer', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_036_F', cname = 'Biker Stallion', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_038_F', cname = 'One Down Five Up', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_049_F', cname = 'Seductive Mechanic', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_Award_F_002', cname = 'Grim Reaper Smoking Gun', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_Award_F_010', cname = 'Ride or Die', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_001', cname = 'Dragons', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_003', cname = 'Dragons and Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_014', cname = 'Flower Mural', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_018', cname = 'Serpent Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_027', cname = 'Virgin Mary', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_028', cname = 'Mermaid', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_038', cname = 'Dagger', part = 'multiplayer_overlays'},                    
                {name = 'FM_Tat_F_047', cname = 'Lion', part = 'multiplayer_overlays'},
            }
        },
        leftleg = { 
            
            tattoo = {
                {name = 'MP_MP_Biker_Tat_002_F', cname = 'Rose Tribute', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_015_F', cname = 'Ride or Die', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_027_F', cname = 'Bad Luck', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_036_F', cname = 'Engulfed Skull', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_037_F', cname = 'Scorched Soul', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_044_F', cname = 'Ride Free', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_056_F', cname = 'Bone Cruiser', part = 'mpbiker_overlays'},  
                {name = 'MP_MP_Biker_Tat_057_F', cname = 'Laughing Skull', part = 'mpbiker_overlays'}, 
    
                {name = 'MP_Xmas2_F_Tat_001', cname = 'Spider Outline', part = 'mpchristmas2_overlays'},
                {name = 'MP_Xmas2_F_Tat_002', cname = 'Spider Color', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_005_F', cname = 'Patriot Skull', part = 'mpgunrunning_overlays'},                   
                {name = 'MP_Gunrunning_Tattoo_007_F', cname = 'Stylized Tiger', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_011_F', cname = 'Death Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_023_F', cname = 'Rose Revolver', part = 'mpgunrunning_overlays'},
                
                {name = 'MP_Buis_F_LLeg_000', cname = 'Single', part = 'mpbusiness_overlays'},
    
                {name = 'FM_Hip_F_Tat_009', cname = 'Squares', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_019', cname = 'Charm', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_040', cname = 'Black Anchor', part = 'mphipster_overlays'},
    
               -- {name = 'MP_LR_Tat_029_F', cname = 'Death Us Do Part', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_007_F', cname = 'LS Serpent', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_020_F', cname = 'Presidents', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_011_F', cname = 'Cross of Roses', part = 'mpluxe2_overlays'},
    
               -- {name = 'MP_LUXE_TAT_000_F', cname = 'Serpent of Death', part = 'mpluxe_overlays'},
    
                {name = 'MP_MP_Stunt_tat_007_F', cname = 'Dagger Devil', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_013_F', cname = 'Dirt Track Hero', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_021_F', cname = 'Golden Cobra', part = 'mpstunt_overlays'},
               -- {name = 'MP_MP_Stunt_tat_028_F', cname = 'Quad Goblin', part = 'mphipster_overlays'},
               -- {name = 'MP_MP_Stunt_tat_031_F', cname = 'Stunt Jesus', part = 'mphipster_overlays'},
    
                {name = 'FM_Tat_Award_F_009', cname = 'Dragon and Dagger', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_002', cname = 'Melting Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_008', cname = 'Dragon Mural', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_021', cname = 'Serpent Skull', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_023', cname = 'Hottie', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_026', cname = 'Smoking Dagger', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_032', cname = 'Faith', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_033', cname = 'Chinese Dragon', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_035', cname = 'Dragon', part = 'multiplayer_overlays'},
                {name = 'FM_Tat_F_037', cname = 'Grim Reaper', part = 'multiplayer_overlays'},
            }
        },
        rightleg = {
             
            tattoo = {
                {name = 'MP_MP_Biker_Tat_004_F', cname = 'Dragons Fury', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_022_F', cname = 'Western Insignia', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_028_F', cname = 'Dusk Rider', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_040_F', cname = 'American Made', part = 'mpbiker_overlays'},
                {name = 'MP_MP_Biker_Tat_048_F', cname = 'STFU', part = 'mpbiker_overlays'},
    
                {name = 'MP_Xmas2_F_Tat_014', cname = 'Floral Dagger', part = 'mpchristmas2_overlays'},
    
                {name = 'MP_Gunrunning_Tattoo_006_F', cname = 'Combat Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_026_f', cname = 'Restless Skull', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Tattoo_030_F', cname = 'Pistol Ace', part = 'mpgunrunning_overlays'},
    
                {name = 'MP_Bea_F_RLeg_000', cname = 'School of Fish', part = 'mpbeach_overlays'},
    
                {name = 'MP_Buis_F_RLeg_000', cname = 'Diamond Crown', part = 'mpbusiness_overlays'},
    
                {name = 'FM_Hip_F_Tat_038', cname = 'Grub', part = 'mphipster_overlays'},
                {name = 'FM_Hip_F_Tat_042', cname = 'Sparkplug', part = 'mphipster_overlays'},
    
              --  {name = 'MP_LR_Tat_030_F', cname = 'San Andreas Prayer', part = 'mplowrider2_overlays'},
    
                {name = 'MP_LR_Tat_017_F', cname = 'Ink Me', part = 'mplowrider_overlays'},
                {name = 'MP_LR_Tat_023_F', cname = 'Dance of Hearts', part = 'mplowrider_overlays'},
    
                {name = 'MP_LUXE_TAT_023_F', cname = 'Starmetric', part = 'mpluxe2_overlays'},
    
               -- {name = 'MP_LUXE_TAT_001_F', cname = 'Elaborate Los Muertos', part = 'mpluxe_overlays'},
    
                {name = 'MP_Smuggler_Tattoo_020_F', cname = 'Homeward Bound', part = 'mpsmuggler_overlays'},
    
                {name = 'MP_MP_Stunt_tat_005_F', cname = 'Demon Spark Plug', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_015_F', cname = 'Praying Gloves', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_020_F', cname = 'Piston Angel', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_025_F', cname = 'Speed Freak', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_032_F', cname = 'Wheelie Mouse', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_045_F', cname = 'Severed Hand', part = 'mpstunt_overlays'},
                {name = 'MP_MP_Stunt_tat_047_F', cname = 'Brake Knife', part = 'mpstunt_overlays'},
    
                {name = 'FM_Tat_F_043', cname = 'Indian Ram', part = 'multiplayer_overlays'},
            }
        },
        
        hair = {

            tattoo = {
                {name = 'FM_Hair_Fuzz', cname = 'Micropig01', part = 'mpbeach_overlays'},
                {name = 'NG_F_Hair_001', cname = 'Micropig02', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_002', cname = 'Micropig03', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_003', cname = 'Micropig04', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_004', cname = 'Micropig05', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_005', cname = 'Micropig06', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_006', cname = 'Micropig07', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_007', cname = 'Micropig08', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_008', cname = 'Micropig09', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_009', cname = 'Micropig10', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_010', cname = 'Micropig11', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_011', cname = 'Micropig12', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_012', cname = 'Micropig13', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_013', cname = 'Micropig14', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_014', cname = 'Micropig15', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_015', cname = 'Micropig16', part = 'multiplayer_overlays'},
                {name = 'NGBea_F_Hair_000', cname = 'Micropig17', part = 'multiplayer_overlays'},
                {name = 'NGBea_F_Hair_001', cname = 'Micropig18', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_007', cname = 'Micropig19', part = 'multiplayer_overlays'},
                {name = 'NGBus_F_Hair_000', cname = 'Micropig20', part = 'multiplayer_overlays'},
                {name = 'NGBus_F_Hair_001', cname = 'Micropig21', part = 'multiplayer_overlays'},
                {name = 'NGBea_F_Hair_001', cname = 'Micropig22', part = 'multiplayer_overlays'},
                {name = 'NGHip_F_Hair_000', cname = 'Micropig23', part = 'multiplayer_overlays'},
                {name = 'NGInd_F_Hair_000', cname = 'Micropig24', part = 'multiplayer_overlays'},
                {name = 'LR_F_Hair_000', cname = 'Micropig25', part = 'mplowrider_overlays'},
                {name = 'LR_F_Hair_001', cname = 'Micropig26', part = 'mplowrider_overlays'},
                {name = 'LR_F_Hair_002', cname = 'Micropig27', part = 'mplowrider_overlays'},
                {name = 'LR_F_Hair_003', cname = 'Micropig28', part = 'mplowrider2_overlays'},
                {name = 'LR_F_Hair_003', cname = 'Micropig29', part = 'mplowrider2_overlays'},
                {name = 'LR_F_Hair_004', cname = 'Micropig30', part = 'mplowrider2_overlays'},
                {name = 'LR_F_Hair_006', cname = 'Micropig31', part = 'mplowrider2_overlays'},
                {name = 'MP_Biker_Hair_000_F', cname = 'Micropig32', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_002_F', cname = 'Micropig33', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_003_F', cname = 'Micropig34', part = 'mpbiker_overlays'},
                {name = 'NG_F_Hair_003', cname = 'Micropig35', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_006_F', cname = 'Micropig36', part = 'multiplayer_overlays'},
                {name = 'MP_Biker_Hair_004_F', cname = 'Micropig37', part = 'mpbiker_overlays'},
                {name = 'NG_F_Hair_001', cname = 'Micropig38', part = 'mpbiker_overlays'},
                {name = 'NG_F_Hair_002', cname = 'Micropig39', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_003', cname = 'Micropig40', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_004', cname = 'Micropig41', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_005', cname = 'Micropig42', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_006', cname = 'Micropig43', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_007', cname = 'Micropig44', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_008', cname = 'Micropig45', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_009', cname = 'Micropig46', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_010', cname = 'Micropig47', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_011', cname = 'Micropig48', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_012', cname = 'Micropig49', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_013', cname = 'Micropig50', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_014', cname = 'Micropig51', part = 'multiplayer_overlays'},
                {name = 'NG_M_Hair_015', cname = 'Micropig52', part = 'multiplayer_overlays'},
                {name = 'NGBea_F_Hair_000', cname = 'Micropig53', part = 'multiplayer_overlays'},
                {name = 'NGBea_F_Hair_001', cname = 'Micropig54', part = 'multiplayer_overlays'},
                {name = 'NG_F_Hair_007', cname = 'Micropig55', part = 'multiplayer_overlays'},
                {name = 'NGBus_F_Hair_000', cname = 'Micropig56', part = 'multiplayer_overlays'},
                {name = 'NGBus_F_Hair_001', cname = 'Micropig57', part = 'multiplayer_overlays'},
                {name = 'NGBea_F_Hair_001', cname = 'Micropig58', part = 'multiplayer_overlays'},
                {name = 'NGHip_F_Hair_000', cname = 'Micropig59', part = 'multiplayer_overlays'},
                {name = 'NGInd_F_Hair_000', cname = 'Micropig60', part = 'multiplayer_overlays'},
                {name = 'LR_F_Hair_000', cname = 'Micropig61', part = 'multiplayer_overlays'},
                {name = 'LR_F_Hair_001', cname = 'Micropig62', part = 'mplowrider_overlays'},
                {name = 'LR_F_Hair_002', cname = 'Micropig63', part = 'mplowrider_overlays'},
                {name = 'LR_F_Hair_003', cname = 'Micropig64', part = 'mplowrider_overlays'},
                {name = 'LR_F_Hair_003', cname = 'Micropig65', part = 'mplowrider2_overlays'},
                {name = 'LR_F_Hair_004', cname = 'Micropig66', part = 'mplowrider2_overlays'},
                {name = 'LR_F_Hair_006', cname = 'Micropig67', part = 'mplowrider2_overlays'},
                {name = 'MP_Biker_Hair_000_F', cname = 'Micropig68', part = 'mplowrider2_overlays'},
                {name = 'MP_Biker_Hair_001_F', cname = 'Micropig69', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_002_F', cname = 'Micropig70', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_003_F', cname = 'Micropig71', part = 'mpbiker_overlays'},
                {name = 'NG_F_Hair_003', cname = 'Micropig72', part = 'mpbiker_overlays'},
                {name = 'MP_Biker_Hair_006_F', cname = 'Micropig73', part = 'multiplayer_overlays'},
                {name = 'MP_Biker_Hair_004_F', cname = 'Micropig74', part = 'mpbiker_overlays'},
                {name = 'MP_Gunrunning_Hair_F_000_F', cname = 'Micropig75', part = 'mpgunrunning_overlays'},
                {name = 'MP_Gunrunning_Hair_F_001_F', cname = 'Micropig76', part = 'mpgunrunning_overlays'}
                --{name = 'MP_MP_Biker_Tat_004_F', cname = 'Micropig01', part = 'mpgunrunning_overlays'}
            }
        }    
    } 
}

-- Cria hoverfy
Citizen.CreateThread(function()
    if Config_client['hoverfyConfirm'] == true then
        for k,v in pairs(Config_client['lojaTatoo']) do
            TriggerEvent("hoverfy:insertTable",{{ v['x'], v['y'], v['z'], 1.5, "E","Studio Tattoo","Pressione para abrir/fechar o menu" }})
        end
    end
end)


Citizen.CreateThread(function()
    SetNuiFocus(false,false)
    while true do
        local sleep = 500
        for k, v in pairs(Config_client['lojaTatoo']) do
            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped, true)
            local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v['x'], v['y'], v['z'], true )
            if parseInt(distance) < 3 then
                sleep = 5
                if Config_client['textoConfirm'] == true then
                    drawText2D("PRESSIONE [~r~E~w~] PARA ACESSAR O ~r~ESTUDIO DE TATUAGEM~w~",7,0.5,0.93,0.55,255,255,255,180)
                end
                if Config_client['blipConfirm'] == true then
                    DrawMarker(Config_client['blip'],v['x'], v['y'], v['z']-0.6,0,0,0,0.0,0,0,0.5,0.5,0.5, 174, 22, 22, 255,50,0,0,100)
                end
                if IsControlJustPressed(0,38) then
                    openTattoo()
				end
            end
        end
        Wait(sleep)
    end
end)

function DrawText3D(x, y, z, text, scl, font)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function drawText2D(text,font,x,y,scale,r,g,b,a)    
    SetTextFont(font)    
    SetTextScale(scale,scale)    
    SetTextColour(r,g,b,a)    
    SetTextOutline()    
    SetTextCentre(1)    
    SetTextEntry('STRING')    
    AddTextComponentString(text)    
    DrawText(x,y)
end