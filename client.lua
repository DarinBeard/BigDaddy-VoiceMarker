
function displayText(text, justification, red, green, blue, alpha, posx, posy)
    SetTextFont(4)
    SetTextWrap(0.0, 1.0)
    SetTextScale(1.0, 0.5)
    SetTextJustification(justification)
    SetTextColour(red, green, blue, alpha)
    SetTextOutline()

    BeginTextCommandDisplayText("STRING") -- old: SetTextEntry()
    AddTextComponentSubstringPlayerName(text) -- old: AddTextComponentString
    EndTextCommandDisplayText(posx, posy) -- old: DrawText()

end

local function DrawText3D(position, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(position.x,position.y,position.z+1)
    local dist = #(GetGameplayCamCoords()-position)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do

		local playersTalking = {'empty'}
		local count = 1
		local px = 0.5
		local py = 0.025
		local pj = 0
		
		if (Config.TextPlacement == 1) then
			px = 0.01
			py = 0.3
			pj = 1
		end

        for id = 0, 256 do
            if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                ped = GetPlayerPed( id )
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				local takeaway = 0.95
				z2 = z2 + Config.MarkerHeight

                if ((distance < Config.DrawDistance) and IsEntityVisible(GetPlayerPed(id))) ~= GetPlayerPed( -1 ) then
					if NetworkIsPlayerTalking(id) then
						DrawMarker(Config.MarkerType, x2, y2, z2 - 0.0, 0, 0, 10, 0, 0, 0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 105, Config.MarkerBounce, Config.MarkerFaceCamera, 2, Config.MarkerRotate, 0, 0, 0)
						if ((Config.ShowId) == 1 and (distance < Config.DrawIdDistance)) then
							DrawText3D(GetEntityCoords( ped, true), GetPlayerServerId(id), Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b )
						end
					else
						if ((Config.ShowId) == 1 and (distance < Config.DrawIdDistance)) then
							DrawText3D(GetEntityCoords( ped, true), GetPlayerServerId(id), 255, 255, 255 )
						end
                    end
                end  
            end
			if NetworkIsPlayerTalking(id) then
				playersTalking[count] = GetPlayerName(id)
				count = count + 1
			end

        end

		if playersTalking[1] ~= "empty" and Config.ShowText == 1 then
			displayText("Currently talking:", pj, 255, 255, 255, 255, px, py) -- always white
			count = 0
			for k,v in pairs(playersTalking) do
				displayText(v, pj, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 255, px, py + (0.025*(count+1)))
				count = count + 1
			end
		end

        Citizen.Wait(0)
    end
end)
