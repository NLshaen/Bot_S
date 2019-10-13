
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

local bot = {
    word = '',
}

local hello = {'coucou','salut','bonjour','bonsoir','hello','hi','kikoo','ola','yo'}
local answer_hello = {"Salut, la banane","Yo, alors tu suxxes toujours autant ?","Hello, alors tu viens plus aux soirées?","Bonsoir, la pêche ?","Kikoo, comment vas tu ?"}

bot.__index = bot

local __bot = {}
setmetatable(__bot, bot)

local frame = CreateFrame("Frame")

local eventHandlers = {}

-- ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("CHAT_MSG_GUILD")
-- frame:RegisterEvent("CHAT_MSG_WHISPER")

frame:SetScript("OnEvent", myEventHandler)

--frame:SetScript("OnEvent", function(_, _, msg, sender)
--    __bot:onGuildMessage(text, author)
--end)

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

-- ------------------------------------------------------------------------------
-- BOT HELLO FUNCTION
-- ------------------------------------------------------------------------------
function bot:hello()
    -- local wPlayerName = UnitName('target');
    self:spam("[BOT_S] Oh bonsoir comment allez vous ce soir ? un petit verre peut-être ?!!!")
end

-- ------------------------------------------------------------------------------
-- BOT COMMAND FUNCTION
-- ------------------------------------------------------------------------------
-- function bot:onGuildMessage(msg, sender)
--    local thello = hello[random(1,9)];
--    if msg == '!bot_start' then
--        self:start()
--    elseif msg == '!bot_status' then
--        self:status()
--    elseif msg == '!bot_stop' then
--        self:stop()
--    elseif msg == '!bot_help' then
--        self:help()
--    elseif msg == 'thello' then
     --  for key,value in pairs(hello) do   -- Stuff to do with keys and values
--        self:hello()
--    end
--end

-- ------------------------------------------------------------------------------

-- TODO FUNCTION TIMER HELP


-- ------------------------------------------------------------------------------
-- BOT CHAT GUILD FUNCTION
-- ------------------------------------------------------------------------------
function bot:start()
    self:spam("[BOT_S] Actived : J'aime quand tu m'actives !!!")
end

function bot:stop()
    self:spam("[BOT_S] Stopped : Adieu veaux vaches cochons !!! ")
end

function bot:status()
    self:spam("[BOT_S] Status : Je suis toujours là !!!")
end

-- TODO FUNCTION HELP
function bot:help()
    self:spam("[BOT_S] Help : !bot_help !!! !bot_start : Pour lancer le [BOT_S] !bot_stop : Pour stopper le [BOT_S] !bot_status: Pour avoir un status du [BOT_S]" )
end
