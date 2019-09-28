# Print message on connect
message("You are not alone !!!")

local EventFrame = CreateFrame("Frame")

EventFrame:RegisterEvent("PLAYER_LOGIN")

EventFrame:SetScript("OnEvent", function(self,event,...)
	if type(CharacterVar) ~= "number" then
		CharacterVar = 1
		ChatFrame1:SendChatMessage('[Bot_S] '.. UnitName("Player")..". I do believe this is the first time we've met. Nice to meet you!","GUILD")
	else
		if CharacterVar == 1 then
			ChatFrame1:SendChatMessage('[Bot_S] '.. UnitName("Player")..". How nice to see you again. I do believe I've seen you " .. CharacterVar .. " time before.","GUILD")
		else
			ChatFrame1:SendChatMessage('[Bot_S] '.. UnitName("Player")..". How nice to see you again. I do believe I've seen you " .. CharacterVar .. " times before.","GUILD")
		end
		CharacterVar = CharacterVar + 1
	end
end)
