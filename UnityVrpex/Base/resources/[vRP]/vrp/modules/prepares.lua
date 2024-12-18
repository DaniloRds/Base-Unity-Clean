----------------------------------------------------------
-- [GERAL]
----------------------------------------------------------
vRP.prepare("database/imgProfile", "SELECT * FROM vrp_user_identities WHERE user_id = @user_id")
----------------------------------------------------------
-- [GARAGEM]
----------------------------------------------------------
vRP.prepare("garagem/get_inroad","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("garagem/get_vehicle_inroad","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND in_road = @in_road")
vRP.prepare("garagem/up_inroad","UPDATE vrp_user_vehicles SET in_road = @in_road WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("garagem/reset_inroad","UPDATE vrp_user_vehicles SET in_road = @in_road")
vRP.prepare("garagem/reset_player_inroad","UPDATE vrp_user_vehicles SET in_road = @in_road WHERE user_id = @user_id")

vRP.prepare("creative/get_vehicle","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP.prepare("creative/rem_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("creative/get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND alugado = 0")
-- vRP.prepare("creative/set_update_vehicles","UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("creative/set_update_vehicles","UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel, damage_state = @damage_state WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("creative/set_detido","UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("creative/set_ipva","UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("creative/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("creative/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,@ipva)")
vRP.prepare("creative/con_maxvehs","SELECT COUNT(vehicle) as qtd FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP.prepare("creative/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP.prepare("creative/get_estoque","SELECT * FROM vrp_lojavip WHERE vehicle = @vehicle")
vRP.prepare("creative/set_estoque","UPDATE vrp_estoque SET quantidade = @quantidade WHERE vehicle = @vehicle")
vRP.prepare("creative/get_users","SELECT * FROM vrp_users WHERE id = @user_id")
vRP.prepare("creative/up_garage","UPDATE vrp_users SET garagem = @garagem WHERE id = @id")
------------------------------------------------------------
-- [LOJA VIP]
------------------------------------------------------------
-- vRP.prepare("vRP/select_steam","SELECT * FROM vrp_user_ids")
vRP.prepare("vRP/userid","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/get_user_vip_active","SELECT user_id FROM vrp_vips WHERE user_id = @user_id AND data_contrat <= @data_contrat")
vRP.prepare("vRP/insert_new_vip","INSERT IGNORE INTO vrp_vips(user_id,vipName,data_contrat) VALUES (@user_id,@vipName,@data_contrat)")
vRP.prepare("vRP/delete_user_vip","DELETE FROM vrp_vips WHERE user_id = @user_id")
