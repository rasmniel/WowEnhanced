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

-- Checklist

RegisterSlash('check', function(args, arg_string)
    local target = table.remove(args)
    if not target then
        return
    end
    target = tonumber(target)
    local item = arg_string:gsub(' ' .. target, '')
    if not item then
        return
    end
    addon.Checklist.CheckItemCount(item, target)
end)

RegisterSlash('checkpot', function(args)
    local target = args[1]
    if target then
        target = tonumber(target)
    else
        target = 5
    end
    addon.Checklist.CheckPot(target)
end)

RegisterSlash('checkpotm', function(args)
    local target = args[1]
    if target then
        target = tonumber(target)
    else
        target = 5
    end
    addon.Checklist.CheckPot(target, true)
end)

RegisterSlash('checkpoison', function(args)
    local type, target = unpack(args)
    if target then
        target = tonumber(target)
    else
        target = 20
    end
    addon.Checklist.CheckPoison(type, target)
end)

RegisterSlash('checkrepair', function()
    addon.Checklist.CheckDurability()
end)

-- Timer

RegisterSlash('startcombat', function(args)
    local label = args[1]
    if label then
        label = tostring(label)
    end
    addon.Timer.CombatTime(label)
end)
