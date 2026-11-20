local _, addon = ...

local CVar = {}

function CVar.Toggle(var, from, to)
    if type(var) ~= 'string' or type(from) ~= 'number' or type(to) ~= 'number' then
        print('Usage: /togglevar <var:string> <from:number> <to:number>')
    end
    SetCVar(var, GetCVar(var) == tostring(from) and to or from)
end

addon.CVar = CVar
