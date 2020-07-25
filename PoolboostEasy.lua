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
            addPlayerPopUpCancelButton:SetText("Cancel")

      addPlayerTargetNameButton = CreateFrame("Button", "addPlayerTargetNameButton", addPlayerPopupWindow, "UIPanelButtonGrayTemplate")
            addPlayerTargetNameButton:SetPoint("LEFT", addPlayerNameEditBox, "RIGHT", 5, 0)
            addPlayerTargetNameButton:SetWidth(70)
            addPlayerTargetNameButton:SetHeight(20)
            addPlayerTargetNameButton:SetText("Target")
			
-- Adds a button for getting the target name. For easier add.
addPlayerTargetNameButton:SetScript("OnClick", function(self)
    local targetName = GetUnitName("Target")

    if UnitIsPlayer("Target") and targetName then
        addPlayerNameEditBox:SetText(targetName)
    end
end)

-- Cancel
addPlayerPopUpCancelButton:SetScript("OnClick", function(self)
    -- Clear the editboxes.
    addPlayerNameEditBox:SetText("")

    -- close the window.
    addPlayerPopupWindow:Hide()
end)

-- Add player
addPlayerPopUpAddButton:SetScript("OnClick", function(self)
	
end)