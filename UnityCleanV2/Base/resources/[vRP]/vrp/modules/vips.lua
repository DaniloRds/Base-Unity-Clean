local cfg = module("cfg/shop_vip")
local group_cfg = module("cfg/groups")

-- [Prepares / DATABASE] --
vRP.prepare("vRP/get_user_vip","SELECT * FROM vrp_vips WHERE user_id = @user_id")
vRP.prepare("vRP/get_user_vip_active","SELECT user_id FROM vrp_vips WHERE user_id = @user_id AND data_contrat <= @data_contrat")
vRP.prepare("vRP/insert_new_vip","INSERT IGNORE INTO vrp_vips(user_id,vipName,data_contrat) VALUES (@user_id,@vipName,@data_contrat)")
vRP.prepare("vRP/delete_user_vip","DELETE FROM vrp_vips WHERE user_id = @user_id")

vRP.prepare("vRP/vip_maxvehs","SELECT COUNT(vehicle) as qtd FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP.prepare("vRP/vip_garagem","SELECT * FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/update_garagem","UPDATE vrp_users SET garagem = @garagem WHERE id = @id")

-----------------------------------
-- [Vagas Adicionais de Garagem] -- 
-----------------------------------
function vRP.checkVagasGaragem(user_id,index)
	local source = vRP.getUserSource(user_id)
	local maxvehs = vRP.query("vRP/vip_maxvehs",{ user_id = user_id })
	local maxgars = vRP.query("vRP/vip_garagem",{ user_id = user_id })

	if index == 1 then -- Total de vagas
		return parseInt(maxgars[1].garagem)
	end

	if index == 2 then -- Vagas disponíveis
		return (parseInt(maxgars[1].garagem) - parseInt(maxvehs[1].qtd))
	end

	if parseInt(maxvehs[1].qtd) < (parseInt(maxgars[1].garagem)) then
		return true
	else
		return false
	end
end

----------------
-- [SHOP VIP] -- 
----------------
local itemsVip = cfg.itemsVip
----------------------------------------------------------
-- SHOP ITEMS
----------------------------------------------------------
function vRP.itemVip()
	return itemsVip
end

----------------------------------------------------------
-- SHOP NAME
----------------------------------------------------------
function vRP.itemVipPrice(name)
	return itemsVip[name].name
end

----------------------------------------------------------
-- SHOP PREÇOS
----------------------------------------------------------
function vRP.itemVipPrice(name)
	return itemsVip[name].preco
end

function vRP.itemVipPrice2(name)
	return itemsVip[name].preco2
end
----------------------------------------------------------
-- SHOP TYPE
----------------------------------------------------------
function vRP.itemVipType(name)
	return itemsVip[name].tipo
end

---------------------------
-- FUNCTIONS VIP SET/REM --
---------------------------
function vRP.getVipActive(user_id)
    local data_contrat = vRP.getVipDate(user_id)
    if data_contrat ~= 0 then
        local M,D,Y = string.match(string.sub(tostring(data_contrat),1,10),'(%d%d)/(%d%d)/(%d%d%d%d)')
        local h,m = string.match(string.sub(tostring(data_contrat),14),'(%d%d):(%d%d)')
        local data_fim = os.time{day = D, month = M, year = Y, hour = h, min = m} + (30*24*60*60)
        local user = vRP.query("vRP/get_user_vip_active", { user_id = user_id, data_contrat = os.date("%m/%d/%Y - %H:%M",data_fim) })
        if user then
            return true
        else
            return false
        end
    end
end

function vRP.getVipById(user_id)
	local user = vRP.query("vRP/get_user_vip",{ user_id = user_id })
	if #user > 0 then
		return user[1]
	else
		return 0
	end
end

function vRP.getVipDate(user_id)
	local user = vRP.query("vRP/get_user_vip",{ user_id = user_id })
	if #user > 0  then
		return user[1].data_contrat
	else
		return 0
	end
end

function vRP.getVipDaysRemaining(user_id)
    local data_contrat = vRP.getVipDate(user_id)
    local user_groups = vRP.getUserGroups(user_id)
	local vip = vRP.getUserGroupByType(user_id,"vip")
    local groups = group_cfg.groups
    local config_dias
    local data_fim

    if data_contrat ~= 0 then
        local M,D,Y = string.match(string.sub(tostring(data_contrat),1,10),'(%d%d)/(%d%d)/(%d%d%d%d)')
        local h,m = string.match(string.sub(tostring(data_contrat),14),'(%d%d):(%d%d)')

        for k,v in pairs(user_groups) do
            local kgroup = groups[k]
            if kgroup then
                if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == "vip" then
                    config_dias = kgroup._config.dias -- número de dias configurado para o VIP

					-- subtrai o tempo atual para obter a diferença
                    data_fim = (os.time{day = D, month = M, year = Y, hour = h, min = m} + (config_dias * 24 * 60 * 60)) - os.time() 

                end
            end
        end

        local days_fim = math.floor(data_fim / (24 * 60 * 60)) 

        if days_fim > 0 and days_fim < config_dias then
            return days_fim
        else
			vRP.deleteVip(user_id)
			vRP.vipsConfig(user_id,"del_vip")
			return 0
        end
    end
end

function vRP.insertNewVip(user_id,vipName)
    if not vRP.getVipActive(user_id) then
        vRP.execute("vRP/insert_new_vip",{
            user_id = user_id,
            vipName = vipName,
            data_contrat = os.date("%m/%d/%Y - %H:%M")
        })
		vRP.vipsConfig(user_id,"dinheiro")
		vRP.vipsConfig(user_id,"coins")
		vRP.vipsConfig(user_id,"itens")
		vRP.vipsConfig(user_id,"mochila")
		vRP.vipsConfig(user_id,"add_garagem")
		vRP.vipsConfig(user_id,"carros")
    end
end

function vRP.deleteVip(user_id)
    if vRP.getVipById(user_id) ~= 0 then
		vRP.execute("vRP/delete_user_vip",{
			user_id = user_id
		})
    end
end

-- [Configuração dos vips no vrp/cfg/group] -- 
function vRP.vipsConfig(user_id,more)
	local user_groups = vRP.getUserGroups(user_id)
	local groups = group_cfg.groups
	local vip = vRP.getUserGroupByType(user_id,"vip")
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then

			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == "vip" then

				if more == "coins" then
					vRP.giveCoin(user_id,parseInt(kgroup._config.coins))
					return kgroup._config.coins

				elseif more == "dinheiro" then
					vRP.giveBankMoney(user_id,parseInt(kgroup._config.dinheiro))
					return kgroup._config.dinheiro

				elseif more == "itens" then
					if kgroup._config.itens then
						for k,v in pairs(kgroup._config.itens) do
							vRP.giveInventoryItem(user_id,v.item,v.quantidade)
						end
					end

				elseif more == "carros" then
					if kgroup._config.carros then
						for k,v in pairs(kgroup._config.carros) do
							vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = v.car, ipva = os.time() })
						end
					end

				elseif more == "mochila" then
					if kgroup._config.mochila == true then
						vRP.addUserGroup(user_id,"mochila")
					end

				elseif more == "add_garagem" then
					local playerGaragens = vRP.query("vRP/vip_garagem",{ user_id = user_id })
					if kgroup._config.garagem then
						garagemAdicional = kgroup._config.garagem
						garagemFinal = (parseInt(playerGaragens[1].garagem) + garagemAdicional)
						vRP.execute("vRP/update_garagem",{
							id = user_id,
							garagem = garagemFinal
						})
					end

				elseif more == "del_vip" then
					local playerGaragens = vRP.query("vRP/vip_garagem",{ user_id = user_id })
					if kgroup._config.garagem then
						garagemAdicional = kgroup._config.garagem
						garagemFinal = (parseInt(playerGaragens[1].garagem) - garagemAdicional)
						vRP.execute("vRP/update_garagem",{
							id = user_id,
							garagem = garagemFinal
						})
					end
					vRP.removeUserGroup(user_id,"mochila")
					vRP.removeUserGroup(user_id,vip)
				end

			end
		end
	end
	return ""
end