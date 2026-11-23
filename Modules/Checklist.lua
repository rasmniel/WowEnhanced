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

local function output_item_state(item, count, target, color)
    local message = string.format('%s: %d / %d', item, count, target)
    addon.Output.Chat(message, color)
end

--- Outputs a status text for the given item's count compared to the target count.
---@param item string Name of the item to check.
---@param target number The target item count.
function Checklist.CheckItemCount(item, target)
    local count = get_item_count_by_name(item)
    if count >= target then
        return
    elseif count == 0 or count == 1 or count == 2 then
        output_item_state(item, count, target, colors.red)
    elseif count < target / 2 then
        output_item_state(item, count, target, colors.orange)
    elseif count < target then
        output_item_state(item, count, target, colors.green)
    else
        -- This case should never occur.
        output_item_state(item, count, target, colors.white)
    end
end

-- TODO: /repaircheck to output durability percentage.

addon.Checklist = Checklist
