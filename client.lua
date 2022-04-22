
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

Citizen.CreateThread(function()
    while true do
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
					else
                    end
                end  
            end
        end


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

		for i = 0, 256 do
			if NetworkIsPlayerTalking(i) then
				playersTalking[count] = GetPlayerName(i)
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
