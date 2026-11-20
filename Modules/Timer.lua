local _, addon = ...

local Timer = {}

local running = false

local function run_combat_timer(label)
    if running then
        return
    end
    running = true

    -- Show a label if one was provided.
    if label and label ~= '' then
        addon.Output.Raid('Combat started: ' .. label, ChatTypeInfo['SYSTEM'])
    end

    -- Show and start timer.
    StopwatchFrame:Show()
    Stopwatch_Clear()
    Stopwatch_Play()

    -- Stop the timer when combat ends.
    addon.Events.NextCombatEnd(function()
        Stopwatch_Pause()
        running = false
    end)
end

--- Start combat timer based on the combat state.
---@param label string Label to print when starting combat.
function Timer.CombatTime(label)
    if InCombatLockdown() then
        run_combat_timer(label)
    else
        addon.Events.NextCombatStart(function()
            run_combat_timer(label)
        end)
    end
end

addon.Timer = Timer
