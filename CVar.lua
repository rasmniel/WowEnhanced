local _, addon = ...

local CVar = {}

function CVar.Toggle(var, from, to)
    local value = GetCVar(var)
    if value ~= from and value ~= to then
        print('Var ' .. var .. ' not in boundary: ' .. from .. ' - ' .. to)
    end
    SetCVar(var, GetCVar(var) == tostring(from) and to or from)
end

addon.CVar = CVar
