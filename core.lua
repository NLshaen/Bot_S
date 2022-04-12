-- ------------------------------------------------------------------------------
-- BOT SCRIPT TESTER
-- ------------------------------------------------------------------------------

BST = {}

local OriginalSetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link, ...)
	if link and string.match(link, "InstanceTrackerLink") then
		return;
	end
	return OriginalSetHyperlink(self, link, ...);
end

function BST:PrintMsg(msg)
    local colorCodeStr = "|cff00CB72"
    local prefix = colorCodeStr.."BOT SCRIPT TESTER: |r"
    
    print(prefix..msg)
end

function BST:ReloadUIPopup(msg)
	BST:PrintMsg(msg)
	StaticPopupDialogs["RELOAD_UI"] = {
		text = "Do you want to reload your UI?", button1 = "Yes", button2 = "No",
		OnAccept = function()
			ReloadUI()
		end,
	}
	StaticPopup_Show("RELOAD_UI");
end

function BST:GetInstanceInfo()
	local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()

	local dungeonDifficultyId = GetDungeonDifficultyID()
	--print ("Player has entered dungeon " .. instanceName .. " with difficulty " .. tostring(dungeonDifficultyId))

	-- Apparently in TBC the heroics are difficulty ID 174 you can verify this by running:
	-- /run for i = 1, 200 do local name = GetDifficultyInfo(i) if name then print(i, name) end end
	if (instanceType == "party" and (dungeonDifficultyId == 2 or dungeonDifficultyId == 174)) then -- heroic
        instanceName = "[H] " .. instanceName
    end

	return instanceName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID
end

if SavedAntiReloadUISettings == nil then SavedAntiReloadUISettings = {} end

BST_CONST_UNIT_NAME_PLAYER = UnitName("player")



-- ------------------------------------------------------------------------------
-- MESSAGE ON CONNECT
-- ------------------------------------------------------------------------------
message("BOT Script Tester !!!\nNLshaaen\nyan.lucas@free.fr")
print("BOT Script Tester !!!\nNLshaaen\nyan.lucas@free.fr")

-- ------------------------------------------------------------------------------
-- DEBUG FUNCTION CAPTURE CHAT_MSG_GUILD
-- ------------------------------------------------------------------------------
LoadAddOn("Blizzard_DebugTools")
function ShowMessageArgs(self,event,...)
   DevTools_Dump({...})
end

local function myChatFilter(self, event, msg, author, ...)
end

local debug = GetChannelName("Debug")

ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", myChatFilter)
-- debug_AddMessageEventFilter(event['CHAT_MSG_GUILD'], myChatFilter)


-- ------------------------------------------------------------------------------
-- LOCAL VARIABLES
-- ------------------------------------------------------------------------------

local bot = {
    word = '',
}

local __hello = {'coucou','salut','bonjour','bonsoir','hello','hi','kikoo','ola','yo'}
local __thello = hello[random(1,9)]
local __answer_hello = {"Salut, la banane","Yo, alors tu suxxes toujours autant ?","Hello, alors tu viens plus aux soirées?","Bonsoir, la pêche ?","Kikoo, comment vas tu ?"}

bot.__index = bot

local __bot = {}
setmetatable(__bot, bot)

local frame = CreateFrame("Frame")

-- ------------------------------------------------------------------------------
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("CHAT_MSG_GUILD")
frame:RegisterEvent("CHAT_MSG_WHISPER")

frame:SetScript("OnEvent", function(_, _, text, sender)
    __bot:onGuildMessage(text, sender)
end)

-- ------------------------------------------------------------------------------
-- BOT SEND CHAT GUILD FUNCTION
-- ------------------------------------------------------------------------------
function bot:spam(msg)
    -- print (thello)
    -- local wPlayerName = UnitName('target');
    SendChatMessage(msg,'GUILD')
    -- SendChatMessage(msg,'WHISPER',nil,sender)
end

-- ------------------------------------------------------------------------------
-- BOT HELLO FUNCTION
-- ------------------------------------------------------------------------------
function bot:hello()
    -- print (thello)
    self:spam("[BOT_S] Oh bonsoir" .. sender .. " comment allez vous ce soir ? un petit verre peut-être ?!!!")
end

-- ------------------------------------------------------------------------------
-- BOT COMMAND FUNCTION
-- ------------------------------------------------------------------------------
function bot:onGuildMessage(msg, sender)
    -- local hello = {'coucou','salut','bonjour','bonsoir','hello','hi','kikoo','ola','yo'}
    -- local thello = hello[random(1,9)]
    ChatFrame4:AddMessage(thello, sender)
    if msg == '!bot_start' then
        self:start()
    elseif msg == '!bot_status' then
        self:status()
    elseif msg == '!bot_stop' then
        self:stop()
    elseif msg == '!bot_help' then
        self:help()
    elseif msg == thello then
        self:hello()
    -- elseif not msg:find(' ') then
       -- self:guess(msg:lower(), sender)
    end
end

-- ------------------------------------------------------------------------------
-- TODO FUNCTION TIMER HELP

-- ------------------------------------------------------------------------------
-- BOT CHAT GUILD FUNCTION
-- ------------------------------------------------------------------------------
function bot:start()
    self:spam("[BTS] Actived : J'aime quand tu m'actives !!!")
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
