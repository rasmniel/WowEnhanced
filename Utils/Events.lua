local _, addon = ...

local Events = {}

local EventFrame = CreateFrame('Frame')
local subscribers = {}

EventFrame:SetScript('OnEvent', function(_, event, ...)
    local handlers = subscribers[event] or {}
    local matches = {}
    for i, handler in ipairs(handlers) do
        matches[i] = handler
    end
    for _, handler in ipairs(matches) do
        local success, error = xpcall(handler, geterrorhandler(), event, ...)
    end
end)

function Events.Subscribe(event, handler)
    if not subscribers[event] then
        subscribers[event] = {}
        EventFrame:RegisterEvent(event)
    end
    table.insert(subscribers[event], handler)
end

function Events.Unsubscribe(event, handler)
    if not subscribers[event] then
        return
    end
    for i = #subscribers[event], 1, -1 do
        if subscribers[event][i] == handler then
            table.remove(subscribers[event], i)
        end
    end
    if #subscribers[event] == 0 then
        subscribers[event] = nil
        EventFrame:UnregisterEvent(event)
    end
end

function Events.Once(event, handler)
    local internal
    internal = function(...)
        Events.Unsubscribe(event, internal)
        handler(event, ...)
    end
    Events.Subscribe(event, internal)
end

-- Event shorthands

function Events.NextCombatStart(handler)
    Events.Once('PLAYER_REGEN_DISABLED', handler)
end

function Events.NextCombatEnd(handler)
    Events.Once('PLAYER_REGEN_ENABLED', handler)
end

addon.Events = Events
