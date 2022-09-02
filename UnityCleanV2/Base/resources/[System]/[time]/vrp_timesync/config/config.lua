config = {}

config.standardWeather = 'CLEAR' --[ Clima padrão do servidor ]--
config.startHour = 6 --[ Hora inicial do servidor ]--
config.startMinutes = 20 --[ Minuto inicial do servidor. ]--

config.climate = { --[ Climas disponíveis para troca automatica ]--
    [1] = { 'CLEAR' },
	[2] = { 'CLEARING' }
	--[3] = { 'CLEARING' }
	--[4] = { 'EXTRASUNNY' }
	--[5] = { 'RAIN' }
}

config.climateCommand = 'clima' --[ Exemplo: /clima EXTRASUNNY | Comando para mudar o clima do servidor. ]--
config.timePermission = 'admin.permissao' --[ Permissão para mudar as horas e o clima. ]--

-- AvailableWeatherTypes: EXTRASUNNY, CLEAR, NEUTRAL, SMOG, FOGGY, OVERCAST, CLOUDS, CLEARING, RAIN, THUNDER, SNOW, BLIZZARD, SNOWLIGHT, XMAS, HALLOWEEN.