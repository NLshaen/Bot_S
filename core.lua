-- Print message on connect
message("You are not alone !!!")

local bot = {
    word = '',
}

bot.__index = bot

local __bot = {}
setmetatable(__bot, bot)

local frame = CreateFrame("Frame")

frame:SetScript("OnEvent", function(_, _,text, author)
    __bot:onGuildMessage(text, author)
end)

-- frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("CHAT_MSG_GUILD")

function bot:spam(text)
    SendChatMessage(text, "GUILD")
end

function bot:onGuildMessage(message, author)
    if message == '!bot_start' then
        self:start()
    elseif message == '!bot_status' then
        self:status()
    elseif message == '!bot_stop' then
        self:stop()
    end
end

function bot:start()
    self:spam("[BOT_S] Actived : J'aime quand tu m'actives !!!")
end

function bot:stop()
    self:spam("[BOT_S] Stopped : Adieu veaux vaches cochons !!! ")
end

function bot:status()
    self:spam("[BOT_S] Status : Je suis toujours là !!!")
end

-- end)
-- CHAT_MSG_GUILD
