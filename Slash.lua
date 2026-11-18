local addonName, addon = ...

function ArgumentHandler(handler)
    return function(argstring)
        local args = {}
        for arg in string.gmatch(argstring, '%S+') do
            table.insert(args, arg)
        end
        handler(args)
    end
end

-- Camera

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        addon.Camera.SetZoom(args[0])
    end),
    'setzoom'
)

-- Timer

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        addon.Timer.CombatStart(args[0])
    end),
    'startcombat'
)

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        addon.Timer.CombatEnd(args[0])
    end),
    'stopcombat'
)

-- CVar toggles

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        local var, from, to = unpack(args)
        addon.CVar.Toggle(var, from, to)
    end),
    'togglevar'
)

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        local from, to = unpack(args)
        addon.CVar.Toggle('Sound_MusicVolume', from or 0, to or 0.3)
    end),
    'togglemusic'
)

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        local from, to = unpack(args)
        addon.CVar.Toggle('Sound_AmbienceVolume', from or 0, to or 0.3)
    end),
    'toggleamb'
)

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        local from, to = unpack(args)
        addon.CVar.Toggle('Sound_SFXVolume', from or 0.3, to or 1)
    end),
    'togglesfx'
)

RegisterNewSlashCommand(
    ArgumentHandler(function()
        addon.CVar.Toggle('Sound_EnableAllSound', 0, 1)
    end),
    'togglemute'
)

