local addonName, addon = ...

print('Loaded: ' .. addonName .. '!')

--- Register a slash command using an indexed table argument instead of a single string.
function RegisterSlash(name, handler)
    RegisterNewSlashCommand(function(arg_string)
        local arg_table = {}
        for arg in string.gmatch(arg_string, '%S+') do
            table.insert(arg_table, arg)
        end
        handler(arg_table, arg_string)
    end, name, name)
end

-- Camera

RegisterSlash('setzoom', function(args)
    local target = tonumber(args[1])
    if type(target) ~= 'number' then
        return addon.Output.Usage('setzoom', { target = 'number' })
    end
    addon.Camera.SetZoom(target)
end)

-- CVar toggles

RegisterSlash('togglevar', function(args)
    local var, from, to = unpack(args)
    if type(var) ~= 'string' and addon.CVar.ValidateRangue(from, to) then
        return addon.Output.Usage('togglevar', { var = 'string', from = 'number', to = 'number' })
    end
    addon.CVar.Toggle(var, from, to)
end)

RegisterSlash('togglemusic', function(args)
    local from, to = unpack(args)
    if addon.CVar.ValidateRange(from, to) then
        return addon.Output.Usage('togglemusic', { from = 'number', to = 'number' })
    end
    addon.CVar.Toggle('Sound_MusicVolume', from or 0, to or 0.3)
end)

RegisterSlash('toggleamb', function(args)
    local from, to = unpack(args)
    if addon.CVar.ValidateRange(from, to) then
        return addon.Output.Usage('toggleamb', { from = 'number', to = 'number' })
    end
    addon.CVar.Toggle('Sound_AmbienceVolume', from or 0, to or 0.3)
end)

RegisterSlash('togglesfx', function(args)
    local from, to = unpack(args)
    if addon.CVar.ValidateRange(from, to) then
        return addon.Output.Usage('togglesfx', { from = 'number', to = 'number' })
    end
    addon.CVar.Toggle('Sound_SFXVolume', from or 0.3, to or 1)
end)

RegisterSlash('togglemute', function()
    addon.CVar.Toggle('Sound_EnableAllSound', 0, 1)
end)

-- Timer

RegisterSlash('startcombat', function(args)
    local label = args[1]
    if label then
        label = tostring(label)
    end
    addon.Timer.CombatTime(label)
end)

-- Checklist

RegisterSlash('checklist', function(args, arg_string)
    local target = table.remove(args)
    target = tonumber(target)
    local item = arg_string:gsub(' ' .. target, '')
    addon.Checklist.CheckItemCount(item, target)
end)

RegisterSlash('checkrepair', function()
    addon.Checklist.CheckDurability()
end)
