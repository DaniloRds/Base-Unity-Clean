local cfg = {}

cfg.imagesIp = "http://localhost:80/cidade/inventory/"

cfg.shops ={

    ["ammunation"] = {
        locs = {
           { 1692.62,3759.50,34.70},
           { 252.89,-49.25,69.94},
           { 843.28,-1034.02,28.19},
           { -331.35,6083.45,31.45},
           { -663.15,-934.92,21.82},
           { -1305.18,-393.48,36.69},
           { -1118.80,2698.22,18.55},
           { 2568.83,293.89,108.73},
           { -3172.68,1087.10,20.83},
           { 21.32,-1106.44,29.79},
           { 811.19,-2157.67,29.6},
        },
        draw = {
            drawmarker = {
                enabled = true,
                id = 30
            },
            -- drawtext3d = {
            --     enabled = true,
            --     text = "[E] para abrir a ammunation",
            -- },
        },
        products = {
            ["Utilidades"] = {
                icon = "https://images-ext-2.discordapp.net/external/pLDZVikc2G6jhgKObmFuRImCyYFDlP6rxmpfYRoCCAk/https/cdn-icons-png.flaticon.com/512/564/564939.png",
                default = true,
                itens = {
                    ["beisebol"] = {
                        name = "Taco de Beisebol",
                        price = 100,
                        itemname = "'wbodyWEAPON_BAT",
                    },
                    ["paraquedas"] = {
                        name = "Paraquedas",
                        price = 200,
                       -- image = "https://www.iconpacks.net/icons/2/free-gun-icon-1971-thumb.png",
                        itemname = "wbodyGADGET_PARACHUTE",
                    },
                    ["m-paraquedas"] = {
                        name = "m-Paraquedas",
                        price = 200,
                       -- image = "https://www.iconpacks.net/icons/2/free-gun-icon-1971-thumb.png",
                        itemname = "wammoGADGET_PARACHUTE",
                    }
                }
            },
            ["armas_branca"] = {
                icon = "https://cdn-icons-png.flaticon.com/512/252/252179.png",
                itens = {
                    ["faca"] ={
                        name = "Faca",
                        price = 700,
                      --  image = "",
                        itemname = "wbodyWEAPON_KNIFE",
                    },
                    ["adaga"] ={
                        name = "Adaga",
                        price = 700,
                      --  image = "",
                        itemname = "wbodyWEAPON_DAGGER",
                    },
                    ["machado"] ={
                        name = "Machado",
                        price = 700,
                      --  image = "",
                        itemname = "wbodyWEAPON_HATCHET",
                    },
                    ["socoingles"] ={
                        name = "Soco Ingles",
                        price = 700,
                      --  image = "",
                        itemname = "wbodyWEAPON_KNUCKLE",
                    },
                    ["machete"] ={
                        name = "Machete",
                        price = 700,
                      --  image = "",
                        itemname = "wbodyWEAPON_MACHETE",
                    },
                    ["canivete"] = {
                        name = "Canivete",
                        price = 500,
                        itemname = "wbodyWEAPON_SWITCHBLADE",
                    },
                }
            }
        }
    },

    ["cafeteria"] = {
        locs = {
           { -627.87, 239.01, 81.9 },
        },
        draw = {
            drawmarker = {
                enabled = true,
                id = 30
            },
            -- drawtext3d = {
            --     enabled = true,
            --     text = "[E] para abrir a cafeteria",
            -- },
        },
        products = {
            ["meucafe"] = {
                icon = "https://cdn-icons-png.flaticon.com/512/1076/1076694.png",
                default = true,
                itens = {
                    ["cafe"] = {
                        name = "Café",
                        price = 2200,
                        -- image = "",
                        itemname = "cafe",
                    },
                    ["cafecleite"] = {
                        name = "Café com Leite",
                        price = 600,
                        -- image = "",
                        itemname = "cafecleite",
                    },
                    ["cafeexpresso"] = {
                        name = "Café Expresso",
                        price = 600,
                        -- image = "",
                        itemname = "cafeexpresso",
                    },
                    ["capuccino"] = {
                        name = "Capuccino",
                        price = 600,
                        -- image = "",
                        itemname = "capuccino",
                    },
                    ["frappuccino"] = {
                        name = "Frappuccino",
                        price = 600,
                        -- image = "",
                        itemname = "frappuccino",
                    },
                    ["cha"] = {
                        name = "Chá",
                        price = 1250,
                        -- image = "",
                        itemname = "cha",
                    },
                    ["icecha"] = {
                        name = "Ice chá",
                        price = 1250,
                        -- image = "",
                        itemname = "icecha",
                    },
                    ["rosquinha"] = {
                        name = "Rosquinha",
                        price = 550,
                        -- image = "",
                        itemname = "rosquinha",
                    },
                    ["sanduiche"] = {
                        name = "Sanduíche",
                        price = 600,
                        -- image = "",
                        itemname = "sanduiche",
                    },
                }
            }
        }
    },

    ["bar"] = {
        locs = {
            { 128.09, -1285.11, 29.29 }, -- Vanilla
            { 988.27, -96.58, 74.85 }, -- Motoclub
            { -560.1, 286.29, 82.18 }, -- Tequilala
            { -1380.16, -628.78, 30.82 }, -- Bahamas
        },
        draw = {
            drawmarker = {
                enabled = true,
                id = 30
            },
            -- drawtext3d = {
            --     enabled = true,
            --     text = "[E] para abrir o bar",
            -- },
        },
        products = {
            ["bebidas"] = {
                icon = "https://cdn-icons-png.flaticon.com/512/2204/2204147.png",
                default = true,
                itens = {
                    ["cerveja"] = {
                        name = "Cerveja",
                        price = 250,
                        -- image = "",
                        itemname = "cerveja",
                    },
                    ["tequila"] = {
                        name = "Tequila",
                        price = 400,
                        -- image = "",
                        itemname = "tequila",
                    },
                    ["vodka"] = {
                        name = "Vodka",
                        price = 520,
                        -- image = "",
                        itemname = "vodka",
                    },
                    ["whisky"] = {
                        name = "Whisky",
                        price = 699,
                        -- image = "",
                        itemname = "whisky",
                    },
                    ["conhaque"] = {
                        name = "Conhaque",
                        price = 460,
                        -- image = "",
                        itemname = "conhaque",
                    },
                    ["absinto"] = {
                        name = "Absinto",
                        price = 320,
                        -- image = "",
                        itemname = "absinto",
                    },
                    ["energetico"] = {
                        name = "Energético",
                        price = 7320,
                        -- image = "",
                        itemname = "energetico",
                    },
                }
            }
        }
    },

    ["departamento"] = {
        locs = {
         {25.65,-1346.58,29.49},
         {2556.75,382.01,108.62},
         {1163.54,-323.04,69.20},
         {-707.37,-913.68,19.21},
         {-47.73,-1757.25,29.42},
         {373.90,326.91,103.56},
         {-3243.10,1001.23,12.83},
         {1729.38,6415.54,35.03},
         {547.90,2670.36,42.15},
         {1960.75,3741.33,32.34},
         {2677.90,3280.88,55.24},
         {-2550.59,2316.66,33.21},
         {1159.7585449219,-157.5366973877,56.696109771729},
         {309.69134521484,-585.54058837891,42.284057617188},
         {1698.45,4924.15,42.06},
         {-1820.93,793.18,138.11},
         {1392.46,3604.95,34.98},
         {-2967.82,390.93,15.04},
         {235.27433776855,-1078.4874267578,36.133007049561},
         {-3040.10,585.44,7.90},
         {1135.56,-982.20,46.41},
         {1165.91,2709.41,38.15},
         {-1487.18,-379.02,40.16},
         {-1222.78,-907.22,12.3},
         {-433.24954223633,-341.42681884766,34.910743713379},
         {805.45599365234,-885.48345947266,29.250856399536},
         {2016.44921875,716.91998291016,203.67129516602},
         {1483.9045410156,-69.171852111816,141.52766418457},
         {1815.5014648438,3390.2497558594,42.748138427734},
         {-805.14489746094,327.82266235352,243.22470092773},
        },
        draw = {
            drawmarker = {
                enabled = true,
                id = 30
            },
            -- drawtext3d = {
            --     enabled = true,
            --     text = "[E] para abrir a loja",
            -- },
        },
        products = {
            ["comida"] = {
                icon = "https://cdn-icons-png.flaticon.com/512/3132/3132693.png",
                itens = {
                    ["pizza"] = {
                        name = "Pizza",
                        price = 500,
                        itemname = "pizza",
                    },
                    ["salgadinho"] = {
                        name = "salgadinho",
                        price = 500,
                      --  image = "",
                        itemname = "chips",
                    },
                    ["sanduiche"] = {
                        name = "sanduiche",
                        price = 500,
                      --  image = "",
                        itemname = "sanduiche",
                    },
                    ["rosquinha"] = {
                        name = "rosquinha",
                        price = 500,
                      --  image = "",
                        itemname = "rosquinha",
                    },
                    ["xburguer"] = {
                        name = "xburguer",
                        price = 500,
                      --  image = "",
                        itemname = "xburguer",
                    },
                    ["frangofrito"] = {
                        name = "frangofrito",
                        price = 300,
                      --  image = "",
                        itemname = "frango",
                    }
                }
            },
                ["utilidades"] = {
                    icon = "https://images-ext-2.discordapp.net/external/pLDZVikc2G6jhgKObmFuRImCyYFDlP6rxmpfYRoCCAk/https/cdn-icons-png.flaticon.com/512/564/564939.png",
                    itens = {
                        ["celular"] = {
                            name = "Celular",
                            price = 2000,
                           --  image = "",
                            itemname = "celular",
                        },
                        ["roupas"] = {
                            name = "Roupas",
                            price = 2000,
                           --  image = "",
                            itemname = "roupas",
                        },
                        ["isca"] = {
                            name = "Isca",
                            price = 50,
                           --  image = "",
                            itemname = "isca",
                        },
                        ["mochila"] = {
                            name = "Mochila",
                            price = 5000,
                           --  image = "",
                            itemname = "mochila",
                        },
                        ["repairkit"] = {
                            name = "Kit Reparo",
                            price = 5000,
                           --  image = "",
                            itemname = "repairkit",
                        },

                        ["aneldecompromisso"] = {
                            name = "Anel de Compromisso",
                            price = 10000,
                           --  image = "",
                            itemname = "aneldecompromisso",
                        },

                        ["alianca"] = {
                            name = "Aliança",
                            price = 50000,
                           --  image = "",
                            itemname = "alianca",
                        },

                        ["bandagem"] = {
                            name = "Bandagem",
                            price = 5000,
                           --  image = "",
                            itemname = "bandagem",
                        },

                        ["ferramenta"] = {
                            name = "Ferramenta",
                            price = 200,
                           --  image = "",
                            itemname = "ferramenta",
                        },

                        ["garrafavazia"] = {
                            name = "Garrafa Vazia",
                            price = 20,
                           --  image = "",
                            itemname = "garrafavazia",
                        },

                        ["radio"] = {
                            name = "Radio",
                            price = 3000,
                          --  image = "",
                            itemname = "radio",
                        }
                    }
                },
            ["bebida"] = {
                icon = "https://cdn-icons-png.flaticon.com/512/3076/3076028.png",
                default = true,
                itens = {
                    ["agua"] ={
                        name = "Agua",
                        price = 500,
                       --  image = "",
                        itemname = "agua",
                    },
                    ["cola"] ={
                        name = "cola",
                        price = 160,
                       --  image = "",
                        itemname = "cola",
                    },
                    ["tequila"] ={
                        name = "tequila",
                        price = 1500,
                       --  image = "",
                        itemname = "tequila",
                    },
                    ["sprunk"] ={
                        name = "sprunk",
                        price = 1500,
                       --  image = "",
                        itemname = "sprunk",
                    },
                    ["cerveja"] ={
                        name = "cerveja",
                        price = 1500,
                       --  image = "",
                        itemname = "cerveja",
                    },
                    ["energetico"] ={
                        name = "Energetico",
                        price = 1500,
                       --  image = "",
                        itemname = "energetico",
                    },
                    ["absinto"] = {
                        name = "Absinto",
                        price = 250,
                     --  image = "https://www.imagensempng.com.br/wp-content/uploads/2022/01/2442.png",
                        itemname = "absinto",
                    },
                }
            }
        }
    },

}

return cfg 