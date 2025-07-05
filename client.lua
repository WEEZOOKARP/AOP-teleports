local function drawTxt3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

local function createmarker(v)
    CreateThread(function()
        local sleep = 0
        while true do
            Wait(sleep)
            if #(v.from - GetEntityCoords(PlayerPedId())) <= 15 then
                sleep = 0
                DrawMarker(1, v.from.x,v.from.y,v.from.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 2.0, v.colour.r, v.colour.g, v.colour.b, v.colour.a, false, true, 2, nil, nil, false)
                drawTxt3D(v.from.x,v.from.y,v.from.z + 1, "[E] - ".. v.label)
            else
                sleep = 500
            end
        end
    end)
end

for k,v in pairs(Config) do
    createmarker(v)
end

RegisterCommand("gotoaop", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, v in pairs(Config) do
        if #(playerCoords - v.from) <= 2.0 then
            StartPlayerTeleport(PlayerId(), v.to, 0.0, false, true, true)
            break
        end
    end
end, false)

RegisterKeyMapping('gotoaop', 'Interact with AOP tps', 'keyboard', 'e')