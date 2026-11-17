local _, addon = ...

local Timer = {}

local function print_with(with)
    if with ~= '' then
        print('Combat opened with ' .. with)
    end
end

local function pause_out_of_combat()
    local combat = UnitAffectingCombat('player')
    if not combat then
        Stopwatch_Pause()
    end
    return combat
end

function Timer.Start(with)
    Stopwatch_Clear()
    print_with(with)
    Stopwatch_Play()
end

function Timer.Stop(with)
    print_with(with)
    if not pause_out_of_combat() then
        C_Timer.After(1, pause_out_of_combat)
    end
end

addon.Timer = Timer
