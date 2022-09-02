vRP.prepare("vRP/create_business","INSERT IGNORE INTO vrp_business(user_id,capital,laundered,reset_timestamp) VALUES(@user_id,@capital,0,@time)")
vRP.prepare("vRP/get_business","SELECT capital,laundered,reset_timestamp FROM vrp_business WHERE user_id = @user_id")
vRP.prepare("vRP/add_capital","UPDATE vrp_business SET capital = capital + @capital WHERE user_id = @user_id")
vRP.prepare("vRP/add_laundered","UPDATE vrp_business SET laundered = laundered + @laundered WHERE user_id = @user_id")
vRP.prepare("vRP/reset_transfer","UPDATE vrp_business SET laundered = 0, reset_timestamp = @time WHERE user_id = @user_id")

function vRP.getUserBusiness(user_id,cbr)
	if user_id then
		local rows = vRP.query("vRP/get_business",{ user_id = user_id })
		local business = rows[1]

		if business and os.time() >= business.reset_timestamp+24*60*60 then
			vRP.execute("vRP/reset_transfer",{ user_id = user_id, time = os.time() })
			business.laundered = 0
		end
		return business
	end
end

local function business_enter(source)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local menu = { name = "Empresas" }

		local business = vRP.getUserBusiness(user_id)
		if business then
			menu["Informações"] = { function(player,choice) end,"<text01>Capital:</text01> <text02>"..vRP.format(business.capital).."</text02><text01>Lavagem:</text01> <text02>"..vRP.format(business.laundered).."</text02>" }

			menu["Investir"] = { function(player,choice)
				local amount = vRP.prompt(player,"Investimento:","")
				amount = parseInt(amount)
				if amount > 0 then
					if vRP.tryPayment(user_id,amount) then
						vRP.execute("vRP/add_capital",{ user_id = user_id, capital = amount*0.5 })
						TriggerClientEvent("Notify",player,"sucesso","Investiu <b>$"..vRP.format(amount).." dólares</b> e adicionou <b>$"..vRP.format(parseInt(amount*0.5)).."</b> ao capital.")
					else
						TriggerClientEvent("Notify",player,"negado","Dinheiro insuficiente.")
					end
				end
			end }

			menu["Lavagem"] = { function(player,choice)
				local business = vRP.getUserBusiness(user_id)
				local restante = math.min(business.capital-business.laundered,vRP.getInventoryItemAmount(user_id,"dinheirosujo"))
				local amount = vRP.prompt(player,"Lavagem:","")
				local random = math.random(90,95)
				if parseInt(amount) > 0 and parseInt(amount) <= restante then
					if vRP.tryGetInventoryItem(user_id,"dinheirosujo",parseInt(amount)) then
						vRP.execute("vRP/add_laundered",{ user_id = user_id, laundered = amount })
						vRP.giveMoney(user_id,parseInt(amount*("0."..random)))
						TriggerClientEvent("Notify",player,"sucesso","Lavou <b>$"..vRP.format(amount).." dólares sujos</b> e recebeu <b>$"..vRP.format(parseInt(amount*("0."..random))).." dólares</b> limpos.")
					else
						TriggerClientEvent("Notify",player,"negado","Capital insuficiente.")
					end
				end
			end }
		else
			menu["Comprar"] = { function(player,choice)
				local ok = vRP.request(source,"Deseja compra da empresa por <b>$999.999.999</b> dólares?",30)
				if ok then
					if vRP.tryPayment(user_id,999999999) then
						vRP.execute("vRP/create_business",{ user_id = user_id, capital = 500000, time = os.time() })
						TriggerClientEvent("Notify",player,"sucesso","Compra concluida.")
						vRP.closeMenu(player)
					else
						TriggerClientEvent("Notify",player,"negado","Dinheiro insuficiente.")
					end
				end
			end }
		end
		vRP.openMenu(source,menu)
	end
end

local function business_leave(source)
	vRP.closeMenu(source)
end

local function build_client_business(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		--vRPclient._addMarker(source,23,-882.02,-1462.26,7.52-0.95,2,2,0.5,0,95,140,50,100)
		--vRP.setArea(source,"vRP:business",-882.02,-1462.26,7.52,2,2,business_enter,business_leave)
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_business(source)
	end
end)