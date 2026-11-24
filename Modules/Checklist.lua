local _, addon = ...

local Checklist = {}

local colors = addon.Output.Colors

local function get_item_count_by_name(name)
    local id = C_Item.GetItemInfoInstant(name)
    if not id then
        return -1
    end
    return C_Item.GetItemCount(id, false, false, false)
end

local function output_list_state(item, count, target, color)
    local message = string.format('%s: %d / %d', item, count, target)
    addon.Output.Chat(message, color)
end

local function get_severity_color(value, target)
    if value >= target then
        return nil
    elseif value == 0 or value == 1 or value == 2 then
        return colors.red
    elseif value < target / 2 then
        return colors.orange
    elseif value < target then
        return colors.green
    else -- This case should never occur.
        return colors.white
    end
end

--- Outputs a status text for the given item's count compared to the target count.
---@param item string Name of the item to check.
---@param target number The target item count.
function Checklist.CheckItemCount(item, target)
    local count = get_item_count_by_name(item)
    local color = get_severity_color(count, target)
    local message = string.format('%s: %d / %d', item, count, target)
    addon.Output.Chat(message, color)
end

local slots = {
    INVSLOT_HEAD,
    INVSLOT_SHOULDER,
    INVSLOT_CHEST,
    INVSLOT_WAIST,
    INVSLOT_LEGS,
    INVSLOT_FEET,
    INVSLOT_WRIST,
    INVSLOT_HAND,
    INVSLOT_MAINHAND,
    INVSLOT_OFFHAND,
}

function Checklist.CheckDurability()
    local durability = 0
    local total = 0

    for _, slot in ipairs(slots) do
        local current, maximum = GetInventoryItemDurability(slot)

        if current and maximum and maximum > 0 then
            durability = durability + current
            total = total + maximum
        end
    end

    if total > 0 then
        local percentage = math.floor((durability / total) * 100)
        local message = string.format('Repair: %d / %d', percentage, 100)
        local color = get_severity_color(percentage, 100)
        addon.Output.Chat(message, color)
    end
end

addon.Checklist = Checklist
