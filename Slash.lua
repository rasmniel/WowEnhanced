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
        addon.Timer.Start(args[0])
    end),
    'timestart'
)

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        addon.Timer.Stop(args[0])
    end),
    'timestop'
)


-- CVar toggles

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        local var, from, to = unpack(args)
        addon.CVar.Toggle(var, from, to)
    end),
    'vartoggle'
)

RegisterNewSlashCommand(
    ArgumentHandler(function(args)
        local from, to = unpack(args)
        addon.CVar.Toggle('Sound_AmbienceVolume', from or 0, to or 0.3)
        addon.CVar.Toggle('Sound_MusicVolume', from or 0, to or 0.3)
    end),
    'ambtoggle'
)

RegisterNewSlashCommand(
    ArgumentHandler(function()
        addon.CVar.Toggle('Sound_EnableAllSound', 0, 1)
    end),
    'mutetoggle'
)
