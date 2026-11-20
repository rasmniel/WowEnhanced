local _, addon = ...

local Debounce = {}

-- TODO: WIP

---@param delay number Delay in seconds.
---@return function debounced The debounced function.
function Debounce.Debouncer(delay)
    local timer

    ---@param callback function The callback to debounce.
    return function(callback)
        if timer then
            timer:Cancel()
        end

        timer = C_Timer.NewTimer(delay, function()
            timer = nil
            callback()
        end)
    end
end

addon.Debounce = Debounce
