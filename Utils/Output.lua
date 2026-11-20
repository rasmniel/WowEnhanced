local _, addon = ...

local Output = {}

local Colors = {
    default = { r = 1, g = 1, b = 1 },
}

--- Output an arbitrary string to the chat window.
---@param message string The message to output.
---@param color table The color of the text. Default: white.
function Output.Chat(message, color)
    DEFAULT_CHAT_FRAME:AddMessage(message, color or Colors.default)
end

--- Output an arbitrary string to the UI error frame.
---@param message string The message to output.
---@param color table The color of the text. Default: white.
function Output.UIError(message, color)
    UIErrorsFrame:AddMessage(message, color or Colors.default)
end

--- Output an arbitrary string to the UI error frame.
---@param message string The message to output.
---@param color table The color of the text. Default: raid warning.
function Output.Raid(message, color)
    RaidNotice_AddMessage(RaidWarningFrame, message, color or ChatTypeInfo['RAID_WARNING'])
end

--- Output a usage format to help the user with commands.
---@param command string The name of the command.
---@param table arguments A table like { name = type } with constraints for the command's arguments.
function Output.Usage(command, arguments)
    local usage = 'Usage: /' .. command
    for field, type in pairs(arguments) do
        usage = string.format('%s <%s:%s>', usage, field, type)
    end
    print(usage)
end

addon.Output = Output
