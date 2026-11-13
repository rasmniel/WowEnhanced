local addonName, addon = ...

-- TODO: Deprecate in favor of global `function RegisterNewSlashCommand(callback, command, commandAlias)`
function addon:RegisterSlash(command, aliases, handler)
	for i, alias in ipairs(aliases) do
		_G["SLASH_" + command + i] = alias
	end
	SlashCmdList[command] = handler
end



