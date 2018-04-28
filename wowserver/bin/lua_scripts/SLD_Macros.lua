local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
assert(not SLD_Macros, "SLD_Macros is already loaded. Possibly different versions!")
-- SLD_Macros main table
SLD_Macros =
{
    -- SLD_Macros flavour functions
    unpack = unpack,
}



local SLD_Macros = SLD_Macros
if not AIO.AddAddon() then
LD_MacroFrame = CreateFrame ( "Frame", "LD_MacroFrame", UIParent )
local LD_MacroFrameBackground = LD_MacroFrame:CreateTexture("LD_MacroFrameBackground", "BACKGROUND")
LD_MacroFrameBackground:SetTexture(1, 1, 1, 0.2)
LD_MacroFrameBackground:SetAllPoints()
LD_MacroFrame:SetSize(75, 300)
LD_MacroFrame:SetPoint("BOTTOMRIGHT", 0, 470)
LD_MacroFrame:SetMovable(true)
LD_MacroFrame:EnableMouse(true)
LD_MacroFrame.MyTitle = LD_MacroFrame:CreateTitleRegion()
LD_MacroFrame.MyTitle:SetSize(75, 400) 
LD_MacroFrame.MyTitle:SetPoint("TOPLEFT", LD_MacroFrame, "TOPLEFT", 0, 0) 
LD_MacroFrame:SetBackdrop({
	-- bgFile = [[Interface\Buttons\WHITE8x8]],
	-- bgFile = [[Interface\PaperDollInfoFrame\UI-GearManager-Title-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
  
LD_MacroFrame.MyHead = LD_MacroFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_MacroFrame.MyHead:SetFontObject(GameFontNormal)   
LD_MacroFrame.MyHead:SetTextColor(1, 1, 1, 1)
LD_MacroFrame.MyHead:SetPoint("TOP", LD_MacroFrame, "TOP", 0, -10)
LD_MacroFrame.MyHead:SetJustifyH("LEFT")
LD_MacroFrame.MyHead:SetText("ACCIONES")
LD_MacroFrame.MyLabels = {}
LD_MacroFrame.MyIcons = {}
local MyOffset = -25
local MyIcon   = "Interface\\ICONS\\inv_misc_questionmark"
LD_MacroFrame.MyLabels["1"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 1 ->" )
LD_MacroFrame.MyIcons["1"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["2"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 2 ->" )
LD_MacroFrame.MyIcons["2"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["3"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 3 ->" )
LD_MacroFrame.MyIcons["3"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["4"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 4 ->" )
LD_MacroFrame.MyIcons["4"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["5"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 5 ->" )
LD_MacroFrame.MyIcons["5"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["6"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 6 ->" )
LD_MacroFrame.MyIcons["6"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["7"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 7 ->" )
LD_MacroFrame.MyIcons["7"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["8"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 8 ->" )
LD_MacroFrame.MyIcons["8"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["9"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 9 ->" )
LD_MacroFrame.MyIcons["9"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["0"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " 0 ->" )
LD_MacroFrame.MyIcons["0"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["R"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " - ->" )
LD_MacroFrame.MyIcons["R"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)
MyOffset = MyOffset - 21
LD_MacroFrame.MyLabels["S"] = LD_LabelTop ( 5, MyOffset-2, LD_MacroFrame, " = ->" )
LD_MacroFrame.MyIcons["S"] = LD_ButtonFrameTop ( 40, MyOffset, LD_MacroFrame, MyIcon)

LD_MacroFrame:Hide()
LD_MacroFrame:SetScript("OnShow",
   function(self)
      LD_MacroFrame.MyIcons["1"].MyT:SetTexture(GetActionTexture(1))
      LD_MacroFrame.MyIcons["2"].MyT:SetTexture(GetActionTexture(2))
      LD_MacroFrame.MyIcons["3"].MyT:SetTexture(GetActionTexture(3))
      LD_MacroFrame.MyIcons["4"].MyT:SetTexture(GetActionTexture(4))
      LD_MacroFrame.MyIcons["5"].MyT:SetTexture(GetActionTexture(5))
      LD_MacroFrame.MyIcons["6"].MyT:SetTexture(GetActionTexture(6))
      LD_MacroFrame.MyIcons["7"].MyT:SetTexture(GetActionTexture(7))
      LD_MacroFrame.MyIcons["8"].MyT:SetTexture(GetActionTexture(8))
      LD_MacroFrame.MyIcons["9"].MyT:SetTexture(GetActionTexture(9))
      LD_MacroFrame.MyIcons["0"].MyT:SetTexture(GetActionTexture(10))
      LD_MacroFrame.MyIcons["R"].MyT:SetTexture(GetActionTexture(11))
      LD_MacroFrame.MyIcons["S"].MyT:SetTexture(GetActionTexture(12))
   end)
 





else
   PrintInfo("SLD Macros Loaded ...")
end