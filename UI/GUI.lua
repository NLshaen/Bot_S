local AceGUI = LibStub("AceGUI-3.0")
local mainWindow, paymentLines, windowSettings = nil, nil, nil
local resettingWindowPosition = false
GUI = {}

local function AddPaymentToWindow(payer, amount)
    DebugHelper:Print("GUI:AddPaymentToWindow("..payer..", "..amount..")")

    local text = " "..payer..", "..GetCoinTextureString(amount)
    DebugHelper:Print("-> "..text)

    local payment = AceGUI:Create("Label")
    payment:SetFullWidth(true)
    payment:SetText(text)
    paymentLines:AddChild(payment)
end

local function ClearpaymentLines()
    DebugHelper:Print("GUI:ClearpaymentLines()")
    paymentLines:ReleaseChildren()
    paymentLines.frame.height = 0
end

local function SaveWindowSettings()
    DebugHelper:Print("GUI:SaveWindowSettings()")

    local point, relativeTo, relativePoint, xOfs, yOfs = mainWindow:GetPoint()

    DebugHelper:Print("-> Point: "..point)
    DebugHelper:Print("-> relativePoint: "..relativePoint)
    DebugHelper:Print("-> xOfs: "..xOfs)
    DebugHelper:Print("-> yOfs: "..yOfs)

    windowSettings = { 
        point = point,
        --relativeTo = UIParent,
        relativePoint = relativePoint,
        x = xOfs,
        y = yOfs,
        IsShown = mainWindow:IsShown()
    }
end

local function SetWindowPosition(windowSettings)
    DebugHelper:Print("GUI:SetWindowPosition()")

    -- The reason why we do this is because when you log in the window will be in the center according to the Window:GetPoint() function.
    -- HOWEVER, this is not the case, as most players have moved it around, but it still somehow says center...
    -- Hence we need to clear all current Active POINTS
    mainWindow:ClearAllPoints()

    mainWindow:SetPoint(windowSettings.point, nil, windowSettings.relativePoint, windowSettings.x, windowSettings.y)
end

local function UpdateHeight()
    DebugHelper:Print("GUI:UpdateHeight()")
    local defaultHeight = 140
    local newHeight = defaultHeight + paymentLines.frame.height

    DebugHelper:Print("-> newHeight: "..newHeight)
    mainWindow:SetHeight(newHeight)
end

local function UpdatePayments()
    DebugHelper:Print("GUI:UpdatePayments()")

    if Settings:GetKey("PAYMENT_REPORTMAIN") then
        local rowCount = 0
        local payments = Payment:GetPayments()
        if (payments ~= nil) then
            DebugHelper:Print("-> Looping payments")
            for key, value in pairs(payments) do 
                AddPaymentToWindow(key, value)
                rowCount = rowCount + 1
            end
        end
    end
end

local function UpdateLineHeight(oldHeight, newHeight)
    if windowSettings then
        local heightToAdjust = 0

        if oldHeight < newHeight then -- Rows have been added
            heightToAdjust = (newHeight - oldHeight) / 2
            windowSettings.y = windowSettings.y - heightToAdjust
        elseif oldHeight > newHeight then -- Rows have been removed
            heightToAdjust = (oldHeight - newHeight) / 2
            windowSettings.y = windowSettings.y + heightToAdjust
        end

        SetWindowPosition(windowSettings)
    end
end

local function RestoreSavedWindowSettings()
    if SavedWindowSettings ~= nil then
        SetWindowPosition(SavedWindowSettings)

        if SavedWindowSettings["IsShown"] then
            mainWindow:Show()
        end
    else
        mainWindow:Show()
    end
end

local function LockoutTrackerPulse()
    local title = "Tracker"
    local generatedTimeTakenString = LockoutTracker:GenerateTimeTaken()

    if string.len(generatedTimeTakenString) > 0 then
        local instanceName = LockoutTracker:GetCurrentLockout().instanceName

        if instanceName then
            title = instanceName
        end

        title = title.." - "..generatedTimeTakenString
    end

    mainWindow:SetTitle(title)
end

function GUI:ResetPosition()
    print ("resetting position")
    
    resettingWindowPosition = true
    SavedWindowSettings = nil
    ReloadUI()
end

function GUI:Update()
    DebugHelper:Print("GUI:Update()")

    local oldHeight = mainWindow.frame.height
    ClearpaymentLines()
    UpdatePayments()
    SaveWindowSettings()
    UpdateHeight()
    UpdateLineHeight(oldHeight, mainWindow.frame.height)
end

function GUI:Show()
    DebugHelper:Print("GUI:Show()")
    mainWindow:Show()
    GUI:Update()
end

function GUI:Reset()
    DebugHelper:Print("GUI:Reset()")

    StaticPopupDialogs["RESET"] = {
        text = "Do you want to perform a reset?", button1 = "Yes", button2 = "No",
        OnAccept = function()
            Payment:Reset()
            GUI:Update()
            ResetInstances()
        end,
    }
    StaticPopup_Show("RESET");
end

function GUI:PLAYER_LOGOUT()
    DebugHelper:Print("GUI:PLAYER_LOGOUT")

    if not resettingWindowPosition then
        SaveWindowSettings()
        SavedWindowSettings = windowSettings
    end
end

function GUI:PLAYER_LOGIN()
    DebugHelper:Print("GUI:PLAYER_LOGIN")
    GUI:Update()
    RestoreSavedWindowSettings()
end

mainWindow = AceGUI:Create("Window")
mainWindow:Hide()
mainWindow:SetTitle("BOT Script LUA Tester - by NLshaaen")
mainWindow:SetWidth(220)
mainWindow:EnableResize(false)

local group = AceGUI:Create("SimpleGroup")
group:SetFullWidth(true)
mainWindow:AddChild(group)

local buttonGroup = AceGUI:Create("SimpleGroup")
buttonGroup:SetFullWidth(true)
group:AddChild(buttonGroup)

local paymentsBtn = AceGUI:Create("Button")
paymentsBtn:SetText("Payments")
paymentsBtn:SetFullWidth(true)
paymentsBtn:SetCallback("OnClick", function() GUIPayments:Show() end)
buttonGroup:AddChild(paymentsBtn)

local lockoutsBtn = AceGUI:Create("Button")
lockoutsBtn:SetText("Lockouts")
lockoutsBtn:SetFullWidth(true)
lockoutsBtn:SetCallback("OnClick", function() GUILockouts:Show() end)
buttonGroup:AddChild(lockoutsBtn)

local lockoutsBtn = AceGUI:Create("Button")
lockoutsBtn:SetText("Settings")
lockoutsBtn:SetFullWidth(true)
lockoutsBtn:SetCallback("OnClick", function() GUISettings:Show() end)
buttonGroup:AddChild(lockoutsBtn)

local resetBtn = AceGUI:Create("Button")
resetBtn:SetText("Reset")
resetBtn:SetFullWidth(true)
resetBtn:SetCallback("OnClick", function() GUI:Reset() end)
buttonGroup:AddChild(resetBtn)

paymentLines = AceGUI:Create("SimpleGroup")
paymentLines:SetFullWidth(true)
group:AddChild(paymentLines)

mainWindow.frame:SetScript("OnMouseUp", SaveWindowSettings)

LockoutTracker:OnPulse(LockoutTrackerPulse)