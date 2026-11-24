local _, addon = ...

local Frames = {}

local function find_frame_by_name_recursively(parent, name)
    if not parent then
        return nil
    end

    if parent:GetName() == name then
        return parent
    end

    for _, child in ipairs({ parent:GetChildren() }) do
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
    return find_frame_by_name('GamepadActionBarPageUnitTemplate')
end

addon.Frames = Frames
