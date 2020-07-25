-- Custom popup window for adding player.
addPlayerPopupWindow = CreateFrame("Frame", "addPlayerPopupWindow", UIParent, "BasicFrameTemplate")
      addPlayerPopupWindow:SetFrameStrata("TOOLTIP")
      addPlayerPopupWindow:SetPoint("TOP", UIParent, "TOP", 0, -100)
      addPlayerPopupWindow:SetSize(300, 150)
      addPlayerPopupWindow:SetMovable(true)
      addPlayerPopupWindow:EnableMouse(true)
      addPlayerPopupWindow:RegisterForDrag("LeftButton")
      addPlayerPopupWindow:SetScript("OnDragStart", addPlayerPopupWindow.StartMoving)
      addPlayerPopupWindow:SetScript("OnDragStop", addPlayerPopupWindow.StopMovingOrSizing)

      addPlayerPopupWindow.title = addPlayerPopupWindow:CreateFontString(nil, "Overlay")
            addPlayerPopupWindow.title:SetFontObject("GameFontHighlight")
            addPlayerPopupWindow.title:SetPoint("TOPLEFT", addPlayerPopupWindow.TitleBg, "TOPLEFT", 3, -3)
            addPlayerPopupWindow.title:SetText("Ω PoolboostEasy")
      
      addPlayerPopupWindow.titleCenter = addPlayerPopupWindow:CreateFontString(nil, "Overlay")
            addPlayerPopupWindow.titleCenter:SetFontObject("GameFontHighlight")
            addPlayerPopupWindow.titleCenter:SetPoint("TOP", addPlayerPopupWindow.TitleBg, "TOP", 0, -3)
            addPlayerPopupWindow.titleCenter:SetText("Add Player")

      addPlayerNameEditBox = CreateFrame("EditBox", "addPlayerNameEditBox", addPlayerPopupWindow, "InputBoxTemplate")
            addPlayerNameEditBox:SetPoint("TOP", addPlayerPopupWindow, "TOP", 0, -80)
            addPlayerNameEditBox:SetWidth(100)
            addPlayerNameEditBox:SetHeight(20)
            addPlayerNameEditBox:ClearFocus()
            addPlayerNameEditBox:SetAutoFocus(false)
            addPlayerNameEditBox:SetMaxLetters(12)
            addPlayerNameEditBox:SetAltArrowKeyMode(false)
            addPlayerNameEditBox:EnableMouse(true)
            addPlayerNameEditBox:SetText("")
            addPlayerNameEditBox:SetJustifyH("Center")
      
      addPlayerNameEditBox.fs = addPlayerNameEditBox:CreateFontString(nil, "OVERLAY")
            addPlayerNameEditBox.fs:SetFontObject("GameFontHighlight")
            addPlayerNameEditBox.fs:SetPoint("BOTTOM", addPlayerNameEditBox, "TOP", 0, 5)
            addPlayerNameEditBox.fs:SetText("To register a killer\nsimply enter the Player name\n\nPlayer Name:")
            addPlayerNameEditBox.fs:SetJustifyH("Center")

      addPlayerPopUpAddButton = CreateFrame("Button", "addPlayerPopUpAddButton", addPlayerPopupWindow, "UIPanelButtonGrayTemplate")
            addPlayerPopUpAddButton:SetPoint("BOTTOM", addPlayerPopupWindow, "BOTTOM", -55, 10)
            addPlayerPopUpAddButton:SetWidth(102)
            addPlayerPopUpAddButton:SetHeight(20)
            addPlayerPopUpAddButton:SetText("Add Player")
      
      addPlayerPopUpCancelButton = CreateFrame("Button", "addPlayerPopUpCancelButton", addPlayerPopupWindow, "UIPanelButtonGrayTemplate")
            addPlayerPopUpCancelButton:SetPoint("BOTTOM", addPlayerPopupWindow, "BOTTOM", 55, 10)
            addPlayerPopUpCancelButton:SetWidth(102)
            addPlayerPopUpCancelButton:SetHeight(20)
            addPlayerPopUpCancelButton:SetText("INVITE")

      addPlayerTargetNameButton = CreateFrame("Button", "addPlayerTargetNameButton", addPlayerPopupWindow, "UIPanelButtonGrayTemplate")
            addPlayerTargetNameButton:SetPoint("LEFT", addPlayerNameEditBox, "RIGHT", 5, 0)
            addPlayerTargetNameButton:SetWidth(70)
            addPlayerTargetNameButton:SetHeight(20)
            addPlayerTargetNameButton:SetText("Target")
                  

local function doItAgain()
      SetPVP(1)
      SendChatMessage("inv" ,"WHISPER" ,nil ,Poolbooster);
end

local honorKills = 0

addPlayerPopupWindow:RegisterEvent("CINEMATIC_START")
addPlayerPopupWindow:RegisterEvent("PLAYER_LOGIN")
addPlayerPopupWindow:RegisterEvent("PARTY_INVITE_REQUEST")
addPlayerPopupWindow:RegisterEvent("PLAYER_DEAD")
addPlayerPopupWindow:RegisterEvent("GOSSIP_SHOW")
addPlayerPopupWindow:RegisterEvent("GOSSIP_CLOSED")
addPlayerPopupWindow:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")

addPlayerPopupWindow:SetScript("OnEvent", function(self, event, ...)
      if event == "CINEMATIC_START" then
            StopCinematic()
            doItAgain()         
      elseif event == "PARTY_INVITE_REQUEST" then
            arg1 = ...
            if arg1 == Poolbooster then
                  AcceptGroup()
                  self:RegisterEvent("GROUP_ROSTER_UPDATE")
            end
      elseif event == "PLAYER_LOGIN" then
            if not Poolbooster then
                  addPlayerPopupWindow:Show()
            else
                  addPlayerNameEditBox:SetText(Poolbooster)
            end

      elseif event == "GROUP_ROSTER_UPDATE" then
            StaticPopup_Hide("PARTY_INVITE")
            self:UnregisterEvent("GROUP_ROSTER_UPDATE")
      elseif event == "PLAYER_DEAD" then
            RepopMe()
      elseif event == "GOSSIP_SHOW" then
            SelectGossipOption(1)
      elseif event == "GOSSIP_CLOSED" then
            AcceptXPLoss()
      elseif event == "CHAT_MSG_COMBAT_HONOR_GAIN" then
            honorKills = honorKills + 1
            if honorKills >= 15 then
                  -- leave group
                  LeaveParty()
                  PlaySound(9379)
            end
      end
end)

-- Adds a button for getting the target name. For easier add.
addPlayerTargetNameButton:SetScript("OnClick", function(self)
    local targetName = GetUnitName("Target")

    if UnitIsPlayer("Target") and targetName then
        addPlayerNameEditBox:SetText(targetName)
    end
end)

-- Cancel
addPlayerPopUpCancelButton:SetScript("OnClick", function(self)
      doItAgain()
end)

addPlayerPopUpAddButton:SetScript("OnClick", function(self)
      Poolbooster = addPlayerNameEditBox:GetText()
end)

-- Editbox, on enter pressed.
addPlayerNameEditBox:SetScript("OnEnterPressed", function(self)
      Poolbooster = self:GetText()  
      self:ClearFocus()
end)







-- Slashcommands
local function slashCommands(msg, editbox)
      -- pattern matching that skips leading whitespace and whitespace between cmd and args
      -- any whitespace at end of args is retained
      local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
            
      if cmd == "show" then
            if addPlayerPopupWindow:IsShown() then
                  addPlayerPopupWindow:Hide()
            else
                  addPlayerPopupWindow:Show()
            end
      elseif cmd == "hide" then
            addPlayerPopupWindow:Hide()
      else
            print("print","Syntax: /Pbe (show||hide)");
      end
end

SLASH_PBE1 = '/pbe'
SlashCmdList["PBE"] = slashCommands