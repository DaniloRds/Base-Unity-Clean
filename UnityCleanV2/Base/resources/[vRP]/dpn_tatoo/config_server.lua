Config_server = {}


function pagamento(source,user_id,preco)
	local source = source
	local user_id = vRP.getUserId(source)
	if preco and user_id then
		if vRP.tryFullPayment(user_id, preco) then
			return true
		else
			return false
		end
	end
end