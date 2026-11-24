local _, addon = ...

local Frames = {}

local function find_frame_by_name_recursively(parent, name)
    if not parent then
        return nil
    end

    local ok, parent_name = pcall(function()
        return parent:GetName()
    end)
    if not ok then
        return nil
    end

    if parent_name == name then
        return parent
    end

    local ok2, parent_children = pcall(function()
        return { parent:GetChildren() }
    end)
    if not ok2 then
        return
    end

    for _, child in ipairs(parent_children) do
        local result = find_frame_by_name_recursively(child, name)
        if result then
            return result
        end
    end
end

local function find_frame_by_name(name)
    return find_frame_by_name_recursively(UIParent, name)
end

function Frames.FindGamepadPageUnitFrame()
    local a = { GamepadMainActionBarFrame:GetChildren() }
    return a[2]
    --return find_frame_by_name_recursively(GamepadMainActionBarFrame, 'GamepadMainActionBarFramePageUnit')
    --return find_frame_by_name('GamepadMainActionBarFramePageUnit')
end

addon.Frames = Frames
