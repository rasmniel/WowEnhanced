local _, addon = ...

-- TODO: Reconsider the use of frames, because most frames are forbidden or restricted.
--      This results in many unaviodable error messages surfacing to the game client as dialogs when touching forbidden frames.
--      Many mechanisms still work despite warnings but error dialogs mentioning tainted access is unacceptable.

local Frames = {}

local function find_frame_by_name_recursively(parent, name)
    if not parent then
        return nil
    end

    local name_ok, parent_name = pcall(function()
        return parent:GetName()
    end)
    if not name_ok then
        return nil
    end

    if parent_name == name then
        return parent
    end

    local children_ok, parent_children = pcall(function()
        return { parent:GetChildren() }
    end)
    if not children_ok then
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
