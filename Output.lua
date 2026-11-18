local _, addon = ...

local Output = {}

local Colors = {
    default = { r = 1, g = 1, b = 1 },
}

function Output.Chat(message, color)
    DEFAULT_CHAT_FRAME:AddMessage(message, color or Colors.default)
end

function Output.UIError(message, color)
    UIErrorsFrame:AddMessage(message, color or Colors.default)
end

function Output.Raid(message, color)
    RaidNotice_AddMessage(RaidWarningFrame, message, color or ChatTypeInfo['RAID_WARNING'])
end

addon.Output = Output
