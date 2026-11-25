local _, addon = ...

local Checklist = {}

local colors = addon.Output.Colors

local function get_item_count_by_name(name)
    local id = C_Item.GetItemInfoInstant(name)
    if not id then
        return 0
    end
    return C_Item.GetItemCount(id, false, false, false)
end

local function find_affixed_item(affixes, apply_affix)
    for _, affix in ipairs(affixes) do
        local item = apply_affix(affix)
        local count = get_item_count_by_name(item)
        if count > 0 then
            return item
        end
    end
end

local function find_suffixed_item(base, suffixes)
    return find_affixed_item(suffixes, function(suffix)
        return base .. ' ' .. suffix
    end) or base
end

local function find_prefixed_item(base, prefixes)
    return find_affixed_item(prefixes, function(prefix)
        return prefix .. ' ' .. base
    end) or base
end

local function get_severity_color(value, target)
    if value >= target then
        return colors.white
    elseif value == 0 or value == 1 or value == 2 then
        return colors.red
    elseif value <= target / 2 then
        return colors.orange
    elseif value < target then
        return colors.green
    else -- This case should never occur.
        return colors.white
    end
end

--- Output a count status for the given item compared to the target count.
---@param item string Name of the item to check.
---@param target number The target item count.
function Checklist.CheckItemCount(item, target)
    local count = get_item_count_by_name(item)
    if count >= target then
        return nil
    end
    local message = string.format('%s: %d / %d', item, count, target)
    local color = get_severity_color(count, target)

    addon.Output.Chat(message, color)
end

--- Output a count status for the given potion of the detected size.
---@param target number The target potion count.
---@param mana boolean Whether the check is for mana potions.
function Checklist.CheckPot(target, mana)
    local type = mana and 'Mana' or 'Healing'
    local potion = find_prefixed_item(type .. ' Potion', { 'Major', 'Superior', 'Greater', '', 'Lesser', 'Minor' })

    Checklist.CheckItemCount(potion, target)
end

--- Output a count status for the given rogue poison key of the detected rank.
---@param type string The type key of poison to check.
---@param target number The target poison count.
function Checklist.CheckPoison(type, target)
    local poison = nil
    type = string.lower(type)
    if type == 'instant' then
        poison = find_suffixed_item('Instant Poison', { 'VI', 'V', 'IV', 'III', 'II', '' })
    elseif type == 'deadly' then
        poison = find_suffixed_item('Deadly Poison', { 'V', 'IV', 'III', 'II', '' })
    elseif type == 'wound' then
        poison = find_suffixed_item('Wound Poison', { 'IV', 'III', 'II', '' })
    elseif type == 'mind' then
        poison = find_suffixed_item('Mind-numbing Poison', { 'III', 'II', '' })
    elseif type == 'crippling' then
        poison = find_suffixed_item('Crippling Poison', { 'II', '' })
    else
        addon.Output.Usage('poison', { type = 'Instant|Deadly|Wound|Mind|Crippling' })
        return
    end

    Checklist.CheckItemCount(poison, target)
end

local durability_slots = {
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

--- Output the average amount of durability left on equipped items.
function Checklist.CheckDurability()
    local durability = 0
    local total = 0

    for _, slot in ipairs(durability_slots) do
        local current, maximum = GetInventoryItemDurability(slot)

        if current and maximum and maximum > 0 then
            durability = durability + current
            total = total + maximum
        end
    end

    if total == 0 or durability == total then
        return
    end

    local percentage = math.floor((durability / total) * 100)
    local message = string.format('Repair: %d / %d%%', percentage, 100)
    local color = get_severity_color(percentage, 100)

    addon.Output.Chat(message, color)
end

addon.Checklist = Checklist
