local _, addon = ...

local Timer = {}

local function time_combat()
    -- Show a label if one was provided.
    if label and label ~= '' then
        addon.Output.Raid('Combat opened with: ' .. label)
    end

    -- Show and start timer.
    StopwatchFrame:Show()
    Stopwatch_Clear()
    Stopwatch_Play()

    -- Stop the timer when combat ends.
    addon.Events.NextCombatEnd(function()
        Stopwatch_Pause()
    end)
end

--- Start combat timer.
---@param label string Label to print when starting combat.
function Timer.CombatTime(label)
    if InCombatLockdown() then
        time_combat()
    else
        addon.Events.NextCombatStart(time_combat)
    end
end

addon.Timer = Timer
