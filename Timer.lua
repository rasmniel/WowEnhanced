local _, addon = ...

local Timer = {}

local function print_with(with)
    if with ~= '' then
        addon.Output.Raid('Combat opened with ' .. with)
    end
end

local function pause_out_of_combat()
    local combat = UnitAffectingCombat('player')
    if not combat then
        Stopwatch_Pause()
    end
    return combat
end

-- TODO: CombatStartDelay `/startcombat 3.5 Fireball`
-- Consider if a more unified approach to delays would be appropriate.
-- May require debouncing, especially if the CombatEnd `with` argument is to be useful.

function Timer.CombatStart(with)
    if not UnitAffectingCombat('player') then
        Stopwatch_Clear()
        -- print_with(with)
        Stopwatch_Play()
    end
end

function Timer.CombatEnd(with)
    -- print_with(with)
    if not pause_out_of_combat() then
        C_Timer.After(1, pause_out_of_combat)
        C_Timer.After(2, pause_out_of_combat)
    end
end

addon.Timer = Timer
