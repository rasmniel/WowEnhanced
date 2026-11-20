local addonName, addon = ...

print('Loaded: ' .. addonName .. '!')

function ArgumentHandler(handler)
    return function(arg_string)
        local args = {}
        for arg in string.gmatch(arg_string, '%S+') do
            table.insert(args, arg)
        end
        handler(args)
    end
end

function RegisterSlash(name, handler)
    RegisterNewSlashCommand(
        ArgumentHandler(function(arg_table)
            handler(arg_table)
        end),
        name,
        name
    )
end

-- Camera

RegisterSlash('setzoom', function(args)
    addon.Camera.SetZoom(args[1])
end)

-- Timer

RegisterSlash('startcombat', function(args)
    addon.Timer.CombatStart(args[1])
end)

RegisterSlash('stopcombat', function(args)
    addon.Timer.CombatEnd(args[1])
end)

-- CVar toggles

RegisterSlash('togglevar', function(args)
    local var, from, to = unpack(args)
    addon.CVar.Toggle(var, from, to)
end)

RegisterSlash('togglemusic', function(args)
    local from, to = unpack(args)
    addon.CVar.Toggle('Sound_MusicVolume', from or 0, to or 0.3)
end)

RegisterSlash('toggleamb', function(args)
    local from, to = unpack(args)
    addon.CVar.Toggle('Sound_AmbienceVolume', from or 0, to or 0.3)
end)

RegisterSlash('togglesfx', function(args)
    local from, to = unpack(args)
    addon.CVar.Toggle('Sound_SFXVolume', from or 0.3, to or 1)
end)

RegisterSlash('togglemute', function(_)
    addon.CVar.Toggle('Sound_EnableAllSound', 0, 1)
end)
