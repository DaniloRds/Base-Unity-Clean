local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")
arc = {}
Tunnel.bindInterface("unity_core",arc)
Proxy.addInterface("unity_core",arc)
vRP = Proxy.getInterface("vRP")
Config = module("unity_core","config_wall")

Config = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET USER ID AND STEAMHEX
-----------------------------------------------------------------------------------------------------------------------------------------	
function arc.getId(sourceplayer)
    local sourceplayer = sourceplayer
	if sourceplayer ~= nil and sourceplayer ~= 0 then
		local user_id = vRP.getUserId(sourceplayer)
		if user_id then
			return user_id
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- USER PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------	
function arc.getPermissao(toogle)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,Config['permwall']) then
        return true
    else
        return false
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOG
-----------------------------------------------------------------------------------------------------------------------------------------
function arc.reportwallLog(toggle)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
        PerformHttpRequest(Config['logwall'], function(err, text, headers) end, 'POST', json.encode({username = ' Wall ', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "REGISTRO DE ATIVADO /WALL⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = Config['img']
                    }, 
                    fields = {
                        { 
                            name = "**ID do Administrador:\n**",
                            value = "**"..identity.name.." "..identity.firstname.." ["..user_id.."]**"
                        },
                        {
							name = "**LOCALIZAÇÃO:**\n",
							value = "**"..x..", "..y..", "..z.."**"
                        }
                    }, 
                    footer = { 
                        text = Config['rodape'] ..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = Config['img']
                    },
                    color = 15906321 
                }
            }
        }), { ['Content-Type'] = 'application/json' })
    end
end

function arc.reportunwallLog(toggle)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
        PerformHttpRequest(Config['logwall'], function(err, text, headers) end, 'POST', json.encode({username = ' Maze Community ', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "REGISTRO DE DESATIVADO /WALL⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = Config['img']
                    }, 
                    fields = {
                        { 
                            name = "**ID do Administrador:\n**",
                            value = "**"..identity.name.." "..identity.firstname.." ["..user_id.."]**"
                        },
                        {
							name = "**LOCALIZAÇÃO:**\n",
							value = "**"..x..", "..y..", "..z.."**"
                        }
                    }, 
                    footer = { 
                        text = Config['rodape'] ..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = Config['img']
                    },
                    color = 15906321 
                }
            }
        }), { ['Content-Type'] = 'application/json' })
    end
end