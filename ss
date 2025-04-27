[1mdiff --git a/UnityVrpex/Base/resources/[Core]/unity_core/itemdrop/server.lua b/UnityVrpex/Base/resources/[Core]/unity_core/itemdrop/server.lua[m
[1mindex bafd319..9c6a154 100644[m
[1m--- a/UnityVrpex/Base/resources/[Core]/unity_core/itemdrop/server.lua[m
[1m+++ b/UnityVrpex/Base/resources/[Core]/unity_core/itemdrop/server.lua[m
[36m@@ -33,29 +33,29 @@[m [mAddEventHandler('DropSystem:drop',function(item,count)[m
 end)[m
 [m
 RegisterServerEvent('DropSystem:take')[m
[31m-AddEventHandler('DropSystem:take',function(id)[m
[32m+[m[32mAddEventHandler('DropSystem:take', function(id)[m
 	local source = source[m
 	local user_id = vRP.getUserId(source)[m
[31m-	if user_id then[m
[31m-		if items[id] ~= nil then[m
[31m-			local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(items[id].item)*items[id].count[m
[31m-			if new_weight <= vRP.getInventoryMaxWeight(user_id) then[m
[31m-				if items[id] == nil then[m
[31m-					return[m
[31m-				end[m
[31m-				local d = items[id][m
[31m-				items[id] = nil[m
[32m+[m	[32mif user_id == nil then return end[m[41m   [m
 [m
[31m-				vRP.giveInventoryItem(user_id,d.item,d.count)[m
[31m-				vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)[m
[31m-				local identity = vRP.getUserIdentity(user_id)[m
[31m-				SendWebhookMessage(webhookpegaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..d.name.." \n[QUANTIDADE]: "..d.count.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")[m
[31m-				markers_ids:free(id)[m
[31m-				TriggerClientEvent('DropSystem:remove',-1,id)[m
[31m-			else[m
[31m-				TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")[m
[31m-			end[m
[32m+[m	[32mif items[id] ~= nil then[m[41m        [m
[32m+[m		[32mlocal itemData = items[id][m[41m       [m
[32m+[m		[32mitems[id] = nil -- Remove o item do array global imediatamente, para evitar dup.[m
[32m+[m
[32m+[m[41m		[m
[32m+[m		[32mif vRP.getInventoryWeight(user_id) + vRP.getItemWeight(itemData.item) * itemData.count > vRP.getInventoryMaxWeight(user_id) then[m
[32m+[m			[32mitems[id] = itemData -- Retorna ao Array global[m
[32m+[m			[32mTriggerClientEvent("Notify", source, "negado", "<b>Mochila</b> cheia.")[m
[32m+[m			[32mreturn[m
 		end[m
[32m+[m[41m		[m
[32m+[m		[32m-- Dá o item ao jogador[m
[32m+[m		[32mvRP.giveInventoryItem(user_id, itemData.item, itemData.count)[m
[32m+[m		[32mvRPclient._playAnim(source, true, {{"pickup_object","pickup_low"}}, false)[m[41m  [m
[32m+[m		[32mlocal identity = vRP.getUserIdentity(user_id)[m
[32m+[m		[32mSendWebhookMessage(webhookpegaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..d.name.." \n[QUANTIDADE]: "..d.count.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")[m[41m                                           [m
[32m+[m		[32mmarkers_ids:free(id)[m
[32m+[m		[32mTriggerClientEvent('DropSystem:remove', -1, id)[m[41m		[m
 	end[m
 end)[m
 [m
