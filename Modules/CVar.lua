local _, addon = ...

local CVar = {}

--- Toggle a Console Variable between two values.
---@param var string The name of the variable to toggle.
---@param from number The value to toggle from.
---@param to number The value to toggle to.
function CVar.Toggle(var, from, to)
    SetCVar(var, GetCVar(var) == tostring(from) and to or from)
end

--- Validate a toggle range.
--- For the sake of usability, a range may be inverted, e.g. from 10 to 5.
---@param from number The starting value of the range.
---@param to number The ending value of the range.
---@return boolean valid Whether the range is a valid numeric range.
function CVar.ValidateRange(from, to)
    return type(from) == 'number' and type(to) == 'number'
end

addon.CVar = CVar
