local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

fclient = Tunnel.getInterface("vrp_identity")
func = {}

Tunnel.bindInterface("vrp_identity",func)

vRP.prepare("vRP/updateName","UPDATE vrp_user_identities SET name = @name WHERE user_id = @user_id")
vRP.prepare("vRP/updatePhoto","UPDATE vrp_user_identities SET foto = @foto WHERE user_id = @user_id")

function func.verifyItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not config.needItem then return true end
		return vRP.getInventoryItemAmount(user_id,config.item) >= 1
	end
end

function func.checkInfos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		local surname = identity.surname or ""
		local name = identity.name..' '..identity.firstname
		local registry = identity.registration
		local phone = identity.phone
		local image = identity.foto or ""

		local carteira = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)

		local multas = vRP.getUData(user_id,'vRP:multas')
		local mymultas = json.decode(multas) or 0

		local job = vRP.getUserGroupByType(user_id,'job')
		if job == '' then job = 'Desempregado' end

		local status = 'Nenhum'
		local age = identity.age

		local vip = vRP.getUserGroupByType(user_id,"vip")
		local vipDays = vRP.getVipDaysRemaining(user_id)

		if vip == '' then vip = 'Nenhum' end
		if vipDays == nil then vipDays = 'Vip' end

		local coin = vRP.getCoin(user_id)

		local staff = vRP.getUserGroupByType(user_id,'staff')
		if staff == '' then staff = 'Nenhum' end

		local type = ''
		for k,v in pairs(config.types) do
			if vRP.hasPermission(user_id, k) then
				type = v
			end
		end

		if type == '' then
			type = config.default
		end
		
		return {surname,name,registry,user_id,phone,image,carteira,banco,mymultas,job,status,age,coin,vip,vipDays,staff},type

	end
end

function func.checkPeopleInfos()
	local source = source
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local user_id = vRP.getUserId(nplayer)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
			local surname = identity.surname or ""
			local name = identity.name..' '..identity.firstname
			local registry = identity.registration
			local phone = identity.phone
			local image = identity.foto or ""

			local carteira = vRP.getMoney(user_id)
			local banco = vRP.getBankMoney(user_id)

			local multas = vRP.getUData(user_id,'vRP:multas')
			local mymultas = json.decode(multas) or 0

			local job = vRP.getUserGroupByType(user_id,'job')
			if job == '' then job = 'Desempregado' end

			local status = 'Nenhum'
			local age = identity.age

			local vip = vRP.getUserGroupByType(user_id,'vip')
			if vip == '' then vip = 'Nenhum' end

			local staff = vRP.getUserGroupByType(user_id,'staff')
			if staff == '' then staff = 'Nenhum' end

			local type = ''
			for k,v in pairs(config.types) do
				if vRP.hasPermission(user_id, k) then
					type = v
				end
			end

			if type == '' then
				type = config.default
			end

			return {surname,name,registry,user_id,phone,image,carteira,banco,mymultas,job,status,age,vip,staff},type

		end
	end
end


function func.checkPerm()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id, config.sing)
	end
end

function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id, config.otherID.permission)
	end
end

function func.saveSign(assinatura)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute('vRP/updateName', {user_id = user_id, name = assinatura})
		return true
	end
end


function func.takePhoto()
	local source = source
	local user_id = vRP.getUserId(source)
	local teste = fclient.requestPhoto(source,config.webhook, true)
	if teste then
	end
	for k,v in pairs(teste.attachments) do
		for l,w in pairs(v) do
			if l == "url" then
				vRP.execute('vRP/updatePhoto', {user_id = user_id, foto = w})		
			end
		end
	end
end
