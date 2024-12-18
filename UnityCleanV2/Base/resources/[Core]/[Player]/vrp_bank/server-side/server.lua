local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_bank:doQuickDeposit")
AddEventHandler("vrp_bank:doQuickDeposit", function(amount)
    local src = source
    local user_id = vRP.getUserId(src)
    local curBank = vRP.getMoney(user_id)
    while user_id == nil do Wait(0) end
    if tonumber(amount) <= curBank then
        vRP.tryDeposit(user_id, tonumber(amount))
        TriggerClientEvent("vrp_bank:refreshBank", src)
		TriggerClientEvent("Notify",src,"sucesso","Você depositou $".. amount ..".")
    else
		TriggerClientEvent("Notify",src,"negado","Você não possui $".. amount ..".")
    end
end)

RegisterServerEvent("vrp_bank:doQuickWithdraw")
AddEventHandler("vrp_bank:doQuickWithdraw", function(amount)
    local src = source
    local user_id = vRP.getUserId(src)
    local curBank = vRP.getBankMoney(user_id)
    while user_id == nil do Wait(0) end
    if tonumber(amount) <= curBank then
		vRP.tryWithdraw(user_id,tonumber(amount))
        TriggerClientEvent("vrp_bank:refreshBank", src)
		TriggerClientEvent("Notify",src,"sucesso","Você sacou $".. amount ..".")
    else
		TriggerClientEvent("Notify",src,"negado","Você não possui $".. amount ..".")
    end
end)

RegisterServerEvent("vrp_bank:doQuickWithdrawATM")
AddEventHandler("vrp_bank:doQuickWithdrawATM", function(amount)
    local src = source
    local user_id = vRP.getUserId(src)
    local curBank = vRP.getBankMoney(user_id)
    while user_id == nil do Wait(0) end
    if tonumber(amount) <= curBank then
        vRP.tryWithdraw(user_id, tonumber(amount))
        TriggerClientEvent("vrp_bank:refreshAtm", src)
        TriggerClientEvent("Notify",src,"sucesso","Você sacou $".. amount ..".")
    else
        TriggerClientEvent("Notify",src,"negado","Você não possui $".. amount ..".")
    end
end)

RegisterServerEvent("vrp_bank:checkWallet")
AddEventHandler("vrp_bank:checkWallet", function()
    local src = source
    local user_id = vRP.getUserId(src)
	local identity = vRP.getUserIdentity(user_id)
    local bank = vRP.getBankMoney(user_id)
    local cash = vRP.getMoney(user_id)
    TriggerClientEvent("checkWallet", src, bank, cash, identity.name.." "..identity.firstname)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PAGAR MULTAS ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('multas',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	local value = vRP.getUData(parseInt(user_id),"vRP:multas")
	local multas = json.decode(value) or 0
	local banco = vRP.getBankMoney(user_id)
	
	if user_id then
		if args[1] == nil then
			if multas >= 1 then
				TriggerClientEvent("Notify",source,"aviso","Você possuí <b>$"..multas.." dólares em multas</b> para pagar.",8000)
			else
				TriggerClientEvent("Notify",source,"aviso","Você <b>não possuí</b> multas para pagar.",8000)
			end
		elseif args[1] == "pagar" then
			local valorpay = vRP.prompt(source,"Saldo de multas: $"..multas.." - Valor de multas a pagar:","")
			if parseInt(valorpay) > 0 then
                if banco >= parseInt(valorpay) then
                    if parseInt(valorpay) <= parseInt(multas) then
                        vRP.setBankMoney(user_id,parseInt(banco-valorpay))
                        vRP.setUData(user_id,"vRP:multas",json.encode(parseInt(multas)-parseInt(valorpay)))
                        TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..valorpay.." dólares</b> em multas.",8000)
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não pode pagar mais multas do que deve.",8000)
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro em sua conta suficiente para isso.",8000)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Valores negativos não são aceitos",8000)
            end
		end
	end
end)