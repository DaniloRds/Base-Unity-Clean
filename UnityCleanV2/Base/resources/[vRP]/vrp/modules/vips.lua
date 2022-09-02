vRP.prepare("vRP/get_user_vip","SELECT * FROM vrp_vips WHERE user_id = @user_id")
vRP.prepare("vRP/get_user_vip_active","SELECT user_id FROM vrp_vips WHERE user_id = @user_id AND data_contrat <= @data_contrat")
vRP.prepare("vRP/insert_new_vip","INSERT IGNORE INTO vrp_vips(user_id,vipName,data_contrat) VALUES (@user_id,@vipName,@data_contrat)")
vRP.prepare("vRP/delete_user_vip","DELETE FROM vrp_vips WHERE user_id = @user_id")

function vRP.getVipActive(user_id)
    local data_contrat = vRP.getVipDate(user_id)
    if data_contrat ~= 0 then
        local M,D,Y = string.match(string.sub(tostring(data_contrat),1,10),'(%d%d)/(%d%d)/(%d%d%d%d)')
        local h,m = string.match(string.sub(tostring(data_contrat),14),'(%d%d):(%d%d)')
        local data_fim = os.time{day = D, month = M, year = Y, hour = h, min = m} + (30*24*60*60)
        local user = vRP.query("vRP/get_user_vip_active", { user_id = user_id, data_contrat = os.date("%m/%d/%Y - %H:%M",data_fim) })
        if #user > 0 then
            return true
        else
            return false
        end
    end
    return false
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
    if data_contrat ~= 0 then
        local M,D,Y = string.match(string.sub(tostring(data_contrat),1,10),'(%d%d)/(%d%d)/(%d%d%d%d)')
        local h,m = string.match(string.sub(tostring(data_contrat),14),'(%d%d):(%d%d)')
        local data_fim = ( os.time{day = D, month = M, year = Y, hour = h, min = m} + (30*24*60*60) ) -
                           os.time{day = os.date("%d"), month = os.date("%m"), year = os.date("%Y"), hour = os.date("%H"), min = os.date("%M")}
        local days_fim = os.date("%d",data_fim)
        if parseInt(days_fim) > 0 and parseInt(days_fim) < 31 then
            return days_fim
        else
            vRP.deleteVip(user_id)
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
    end
end

function vRP.deleteVip(user_id)
    if vRP.getVipById(user_id) ~= 0 then
        vRP.execute("vRP/delete_user_vip",{
            user_id = user_id
        })
    end
end
