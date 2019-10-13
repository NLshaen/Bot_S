
-- ------------------------------------------------------------------------------
-- MESSAGE ON CONNECT
-- ------------------------------------------------------------------------------
message("You are not alone !!!\nNLanae\nyan.lucas@free.fr")
print("You are not alone !!!\nNLanae\nyan.lucas@free.fr")

-- ------------------------------------------------------------------------------
-- DEBUG FUNCTION CAPTURE CHAT_MSG_GUILD
-- ------------------------------------------------------------------------------
LoadAddOn("Blizzard_DebugTools")
function ShowMessageArgs(self,event,...)
   DevTools_Dump({...})
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ShowMessageArgs)
-- ChatFrame3_AddMessageEventFilter("CHAT_MSG_GUILD", ShowMessageArgs)

-- ------------------------------------------------------------------------------
-- LOCAL VARIABLES
-- ------------------------------------------------------------------------------

local hello = {'coucou','salut','bonjour','bonsoir','hello','hi','kikoo','ola','yo'}
local answer_hello = {"Salut, la banane","Yo, alors tu suxxes toujours autant ?","Hello, alors tu viens plus aux soirées?","Bonsoir, la pêche ?","Kikoo, comment vas tu ?"}

local frame = CreateFrame("Frame")

local eventHandlers = {}

-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("CHAT_MSG_GUILD")
frame:RegisterEvent("CHAT_MSG_WHISPER")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

frame:SetScript("OnEvent", myEventHandler)

-- ------------------------------------------------------------------------------
-- FUNCTION EVENT HANDLER
-- ------------------------------------------------------------------------------

function eventHandlers.CHAT_MSG_GUILD(msg, sender)
end

function eventHandlers.CHAT_MSG_WHISPER(msg, sender)
end

function eventHandlers.ZONE_CHANGED_NEW_AREA()
end

local function myEventHandler(self, event, ...)
    return eventHandlers[event](...)
end

-- ------------------------------------------------------------------------------
-- BOT SEND CHAT GUILD FUNCTION
-- ------------------------------------------------------------------------------
--function bot:spam(text)
--    local wPlayerName = UnitName('target');
    -- SendChatMessage(text,'GUILD')
--    SendChatMessage(text,'WHISPER',nil,wPlayerName)
    --/run SendChatMessage('hello[random(1-9)]','WHISPER',nil,UnitName('target'))
--end
