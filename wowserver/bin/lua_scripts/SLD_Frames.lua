local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Frames2 = SLD_LIB or require("SLD_Frames2")
assert(not SLD_Frames, "SLD_Frames is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_Frames =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}



local SLD_Frames = SLD_Frames
if not AIO.AddAddon() then

   if AIO_LD_CONFIG["ROL"] == nil then
      AIO_LD_CONFIG["ROL"] = {}
   end	  
   
   function LD_SetMainFrame()
      LD_MainFrame = CreateFrame ( "Frame", "LD_MainFrame", UIParent )
	  local LD_MainFrameBackground = LD_MainFrame:CreateTexture("LD_MainFrameBackground", "BACKGROUND")
      LD_MainFrameBackground:SetTexture(1, 1, 1, 0.1)
      LD_MainFrameBackground:SetAllPoints()
	  LD_MainFrame:SetSize(400, 50)
	  LD_MainFrame:SetPoint("BOTTOMRIGHT")
	  
	  LD_MainFrame.TargetT=LD_MainFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
      LD_MainFrame.TargetT:SetTextColor(1, 1, 0, 1)
      LD_MainFrame.TargetT:SetPoint("TOPLEFT", 30,0)
	  
	  if AIO_LD_CONFIG["ROL"]["APP"] == nil then
         LD_MainFrame.TargetT:SetText(" ---- Personaje sin datos de rol ----- ")
	  elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
         LD_MainFrame.TargetT:SetText(" - Personaje con datos de rol pendientes de aprobación - ")
	  else
         LD_MainFrame.TargetT:SetText("")
	  end
	  
	  -- ATRIBUTOS
	  LD_MainFrame.Button1 = LD_ButtonFrame ( 10, 10, LD_MainFrame, "Interface\\ICONS\\INV_Inscription_ArmorScroll01" )
      LD_MainFrame.Button1:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff ATRIBUTOS / DESCRIPCION");
            GameTooltip:AddLine("|cffffffff Características innatas");
            GameTooltip:AddLine("|cffffffff Tambien puedes poner el aspecto físico");
            GameTooltip:AddLine("|cffffffff del personaje.");
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               GameTooltip:AddLine("|cffff0000 (Personaje sin datos de rol)");
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               GameTooltip:AddLine("|cffff0000 (Datos de rol pendientes de aprobación)");
			end
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button1:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)
      LD_MainFrame.Button1:SetScript("OnClick", 
	     function(self) 
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               return
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               return
			end		 
		    if LD_ATRFrame:IsVisible() then
			   LD_ATRFrame:Hide()
			else
			   LD_ATRFrame:Show()
			end
         end)
	  -- HABILIDADES
	  LD_MainFrame.Button2 = LD_ButtonFrame ( 40, 10, LD_MainFrame, "Interface\\ICONS\\INV_Inscription_ArmorScroll03" )
      LD_MainFrame.Button2:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff HABILIDADES / HECHIZOS");
            GameTooltip:AddLine("|cffffffff Características que el personaje aprende con el tiempo");
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               GameTooltip:AddLine("|cffff0000 (Personaje sin datos de rol)");
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               GameTooltip:AddLine("|cffff0000 (Datos de rol pendientes de aprobación)");
			end
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button2:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)
      LD_MainFrame.Button2:SetScript("OnClick", 
	     function(self) 
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               return
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               return
			end		 
         end)

	  -- EQUIPO
	  LD_MainFrame.Button3 = LD_ButtonFrame ( 70, 10, LD_MainFrame, "Interface\\ICONS\\Ability_Warrior_SwordandBoard" )
      LD_MainFrame.Button3:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff EQUIPO");
            GameTooltip:AddLine("|cffffffff No vas a ir en pelotas ¿verdad?");
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               GameTooltip:AddLine("|cffff0000 (Personaje sin datos de rol)");
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               GameTooltip:AddLine("|cffff0000 (Datos de rol pendientes de aprobación)");
			end
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button3:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)
      LD_MainFrame.Button3:SetScript("OnClick", 
	     function(self) 
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               return
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               return
			end		 
         end)

	  -- MONTURAS
	  LD_MainFrame.Button4 = LD_ButtonFrame ( 100, 10, LD_MainFrame, "Interface\\ICONS\\Ability_Mount_RidingHorse" )
      LD_MainFrame.Button4:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff MONTURAS");
            GameTooltip:AddLine("|cffffffff ¿Crees que vas a ir a pie siempre?");
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               GameTooltip:AddLine("|cffff0000 (Personaje sin datos de rol)");
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               GameTooltip:AddLine("|cffff0000 (Datos de rol pendientes de aprobación)");
			end
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button4:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)
      LD_MainFrame.Button4:SetScript("OnClick", 
	     function(self) 
			if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               return
			elseif AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
               return
			end		 
         end)

	  -- MACROS
	  LD_MainFrame.Button5 = LD_ButtonFrame ( 130, 10, LD_MainFrame, "Interface\\ICONS\\Trade_Engineering" )
      LD_MainFrame.Button5:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff ACCIONES");
            GameTooltip:AddLine("|cffffffff Aqui tienes acceso a las posibles acciones")
			GameTooltip:AddLine("|cffffffff o macros que tengas configuradas en tus barras");
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button5:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)
      LD_MainFrame.Button5:SetScript("OnClick", 
	     function(self) 
 		    if LD_MacroFrame:IsVisible() then
			   LD_MacroFrame:Hide()
			else
			   LD_MacroFrame:Show()
			end
         end)
		 

	  -- DIALOGOS / EMOTES
	  LD_MainFrame.Button5 = LD_ButtonFrame ( 160, 10, LD_MainFrame, "Interface\\ICONS\\spell_holy_silence" )
      LD_MainFrame.Button5:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff DIALOGOS/EMOTES/DADOS");
            GameTooltip:AddLine("|cffffffff Todo lo necesario para interactuar con el mundo.")
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button5:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)
      LD_MainFrame.Button5:SetScript("OnClick", 
	     function(self) 
		    if LD_ROLFrame:IsVisible() then
			   LD_ROLFrame:Hide()
			else
			   LD_ROLFrame:Show()
			end
         end)

	  return LD_MainFrame
   end

LD_NPC_POOL  = {}
LD_NPC_INDEX = 1
LD_NPCsFrame = CreateFrame ( "Frame", "LD_NPCsFrame", UIParent )
local LD_NPCsFrameBackground = LD_NPCsFrame:CreateTexture("LD_LD_NPCsFrameBackground", "BACKGROUND")
LD_NPCsFrameBackground:SetTexture(0, 0, 1, 0.1)
LD_NPCsFrameBackground:SetAllPoints()
LD_NPCsFrame:SetSize(400, 100)
LD_NPCsFrame:SetPoint("BOTTOMRIGHT", 0, 100)
LD_NPCsFrame:SetMovable(true)
LD_NPCsFrame:EnableMouse(true)
LD_NPCsFrame:Hide()

--
-- DADOS - DECIR - EMOTES
--
-- INICIO VARIABLES GLOBALES
function LD_TxtDice_Vars()
   if AIO_LD_CONFIG["DICE"] == nil then
      AIO_LD_CONFIG["DICE"] = {}
   end
   if AIO_LD_CONFIG["SAY"] == nil then
      AIO_LD_CONFIG["SAY"] = {}
   end
   LD_GetPjVarDef ("DICE1MIN", "DICE", "DICE1MIN", 1 )
   LD_GetPjVarDef ("DICE1MAX", "DICE", "DICE1MAX", 10 )
   LD_GetPjVarDef ("DICE2MIN", "DICE", "DICE2MIN" , 1)
   LD_GetPjVarDef ("DICE2MAX", "DICE", "DICE2MAX" , 6)
   LD_GetPjVarDef ("SAY1", "SAY", "SAY1" , " ")
   LD_GetPjVarDef ("SAY2", "SAY", "SAY2" , " ")
   LD_GetPjVarDef ("SAY3", "SAY", "SAY3" , " ")
end   

LD_TxtDice_Vars()
LD_ROLFrame = CreateFrame ( "Frame", "LD_ROLFrame", UIParent )
local LD_ROLFrameBackground = LD_ROLFrame:CreateTexture("LD_ROLFrameBackground", "BACKGROUND")
LD_ROLFrameBackground:SetTexture(0, 0, 1, 0.1)
LD_ROLFrameBackground:SetAllPoints()
LD_ROLFrame:SetSize(400, 120)
LD_ROLFrame:SetPoint("BOTTOMRIGHT", 0, 50)
LD_ROLFrame:SetMovable(true)
LD_ROLFrame:EnableMouse(true)
LD_ROLFrame.MyTitle = LD_ROLFrame:CreateTitleRegion()
LD_ROLFrame.MyTitle:SetSize(400, 100) 
LD_ROLFrame.MyTitle:SetPoint("TOPLEFT", LD_ROLFrame, "TOPLEFT", 0, 0)

-- OBJETIVO
LD_ROLFrame.TargetT=LD_ROLFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.TargetT:SetTextColor(1, 1, 0, 1)
LD_ROLFrame.TargetT:SetPoint("BOTTOMLEFT", 230,100)
LD_ROLFrame.TargetT:SetText(".")

-- DADOS 1

LD_ROLFrame.Dice1Txt1=LD_ROLFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.Dice1Txt1:SetTextColor(1, 1, 1, 1)
LD_ROLFrame.Dice1Txt1:SetPoint("BOTTOMLEFT",10,100)
LD_ROLFrame.Dice1Txt1:SetText("Dados(1) Min:")
LD_ROLFrame.Dice1Min = LD_EditFrame (LD_ROLFrame, 100, -7, 20, 15, 1, 0, true)
LD_ROLFrame.Dice1Min:SetScript("OnLeave" ,
   function(self)
      AIO_LD_CONFIG["DICE"]["DICE1MIN"] = tonumber(self:GetText())
      LD_SetPjVar( "DICE1MIN", "DICE" , self:GetText())
   end)
LD_ROLFrame.Dice1Txt2=LD_ROLFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.Dice1Txt2:SetTextColor(1, 1, 1, 1)
LD_ROLFrame.Dice1Txt2:SetPoint("BOTTOMLEFT",125,100)
LD_ROLFrame.Dice1Txt2:SetText("Max:")
LD_ROLFrame.Dice1Max = LD_EditFrame (LD_ROLFrame, 160, -7, 30, 15, 2, 0, true)
LD_ROLFrame.Dice1Max:SetScript("OnLeave" ,
   function(self)
      AIO_LD_CONFIG["DICE"]["DICE1MAX"] = tonumber(self:GetText())
      LD_SetPjVar( "DICE1MAX", "DICE" , self:GetText())
   end)
LD_ROLFrame.Dice1 = LD_ButtonFrame ( 200, 96, LD_ROLFrame, "Interface\\ICONS\\inv_misc_dice_02" )
LD_ROLFrame.Dice1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff LANZAR (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Dice1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Dice1:SetScript("OnClick", 
   function(self) 
      RandomRoll(tonumber(LD_ROLFrame.Dice1Min:GetText()), tonumber(LD_ROLFrame.Dice1Max:GetText()))
   end)
 
-- DADOS 2
LD_ROLFrame.Dice2Txt1=LD_ROLFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.Dice2Txt1:SetTextColor(1, 1, 1, 1)
LD_ROLFrame.Dice2Txt1:SetPoint("BOTTOMLEFT",10, 80)
LD_ROLFrame.Dice2Txt1:SetText("Dados(2) Min:")
LD_ROLFrame.Dice2Min = LD_EditFrame (LD_ROLFrame, 100, -30, 20, 15, 3, 0, true)
LD_ROLFrame.Dice2Min:SetScript("OnLeave" ,
   function(self)
      AIO_LD_CONFIG["DICE"]["DICE2MIN"] = tonumber(self:GetText())
      LD_SetPjVar( "DICE2MIN", "DICE" , self:GetText())
   end)
LD_ROLFrame.Dice2Txt2 = LD_ROLFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.Dice2Txt2:SetTextColor(1, 1, 1, 1)
LD_ROLFrame.Dice2Txt2:SetPoint("BOTTOMLEFT",125, 80)
LD_ROLFrame.Dice2Txt2:SetText("Max:")
LD_ROLFrame.Dice2Max = LD_EditFrame (LD_ROLFrame, 160, -30, 30, 15, 4, 0, true)
LD_ROLFrame.Dice2Max:SetScript("OnLeave" ,
   function(self)
      AIO_LD_CONFIG["DICE"]["DICE2MAX"] = tonumber(self:GetText())
      LD_SetPjVar( "DICE2MAX", "DICE" , self:GetText())
   end)
LD_ROLFrame.Dice2 = LD_ButtonFrame ( 200, 74, LD_ROLFrame, "Interface\\ICONS\\inv_misc_dice_02" )
LD_ROLFrame.Dice2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 LANZAR (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Dice2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Dice2:SetScript("OnClick", 
   function(self) 
      RandomRoll(tonumber(LD_ROLFrame.Dice2Min:GetText()), tonumber(LD_ROLFrame.Dice2Max:GetText()))
   end)
-- TEXTO1   
LD_ROLFrame.Txt1 = LD_EditFrame (LD_ROLFrame, 10, -50, 300, 17, 5, "", false)
LD_ROLFrame.Txt1:SetScript("OnLeave", 
   function(self)
      AIO_LD_CONFIG["SAY"]["SAY1"] = self:GetText()
      LD_SetPjVar( "SAY1", "SAY" , self:GetText())
   end)
LD_ROLFrame.Say1 = LD_ButtonFrame ( 315, 53, LD_ROLFrame, "Interface\\ICONS\\spell_holy_silence" )
LD_ROLFrame.Say1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff DECIR (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Say1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Say1:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt1:GetText(), "SAY")
   end)
LD_ROLFrame.Emo1 = LD_ButtonFrame ( 340, 53, LD_ROLFrame, "Interface\\ICONS\\spell_brokenheart" )
LD_ROLFrame.Emo1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff EMOCION (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Emo1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Emo1:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt1:GetText(), "EMOTE")
   end)
LD_ROLFrame.Gri1 = LD_ButtonFrame ( 365, 53, LD_ROLFrame, "Interface\\ICONS\\ability_druid_challangingroar" )
LD_ROLFrame.Gri1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff GRITAR (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Gri1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Gri1:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt1:GetText(), "YELL")
   end)
-- 
--    
-- TEXTO2
--
LD_ROLFrame.Txt2 = LD_EditFrame (LD_ROLFrame, 10, -70, 300, 17, 6, "", false)
LD_ROLFrame.Txt2:SetScript("OnLeave", 
   function(self)
      AIO_LD_CONFIG["SAY"]["SAY2"] = self:GetText()
      LD_SetPjVar( "SAY2", "SAY" , self:GetText())
   end)
LD_ROLFrame.Say2 = LD_ButtonFrame ( 315, 33, LD_ROLFrame, "Interface\\ICONS\\spell_holy_silence" )
LD_ROLFrame.Say2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 DECIR (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Say2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Say2:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt2:GetText(), "SAY")
   end)
LD_ROLFrame.Emo2 = LD_ButtonFrame ( 340, 33, LD_ROLFrame, "Interface\\ICONS\\spell_brokenheart" )
LD_ROLFrame.Emo2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 EMOCION (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Emo2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Emo2:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt2:GetText(), "EMOTE")
   end)
LD_ROLFrame.Gri2 = LD_ButtonFrame ( 365, 33, LD_ROLFrame, "Interface\\ICONS\\ability_druid_challangingroar" )
LD_ROLFrame.Gri2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 GRITAR (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Gri2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Gri2:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt2:GetText(), "YELL")
   end)
   
-- TEXTO3
LD_ROLFrame.Txt3 = LD_EditFrame (LD_ROLFrame, 10, -90, 300, 17, 7, "", false)
LD_ROLFrame.Txt3:SetScript("OnLeave", 
   function(self)
      AIO_LD_CONFIG["SAY"]["SAY3"] = self:GetText()
      LD_SetPjVar( "SAY3", "SAY" , self:GetText())
   end)
LD_ROLFrame.Say3 = LD_ButtonFrame ( 315, 13, LD_ROLFrame, "Interface\\ICONS\\spell_holy_silence" )
LD_ROLFrame.Say3:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cffff00ff DECIR (III)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Say3:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Say3:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt3:GetText(), "SAY")
   end)
LD_ROLFrame.Emo3 = LD_ButtonFrame ( 340, 13, LD_ROLFrame, "Interface\\ICONS\\spell_brokenheart" )
LD_ROLFrame.Emo3:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cffff00ff EMOCION (III)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Emo3:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Emo3:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt3:GetText(), "EMOTE")
   end)   
LD_ROLFrame.Gri3 = LD_ButtonFrame ( 365, 13, LD_ROLFrame, "Interface\\ICONS\\ability_druid_challangingroar" )
LD_ROLFrame.Gri3:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cffff00ff GRITAR (III)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Gri3:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Gri3:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt3:GetText(), "YELL")
   end)
LD_ROLFrame:SetScript("OnShow",
   function(self)
      self.Dice1Min:SetText(AIO_LD_CONFIG["DICE"]["DICE1MIN"])
      self.Dice1Max:SetText(AIO_LD_CONFIG["DICE"]["DICE1MAX"])
      self.Dice2Min:SetText(AIO_LD_CONFIG["DICE"]["DICE2MIN"])
      self.Dice2Max:SetText(AIO_LD_CONFIG["DICE"]["DICE2MAX"])
      self.Txt1:SetText(AIO_LD_CONFIG["SAY"]["SAY1"])
      self.Txt2:SetText(AIO_LD_CONFIG["SAY"]["SAY2"])
      self.Txt3:SetText(AIO_LD_CONFIG["SAY"]["SAY3"])
   end)   
LD_ROLFrame:Hide()




LD_ATRFrame = CreateFrame ( "Frame", "LD_ATRFrame", UIParent )
local LD_ATRFrameBackground = LD_ATRFrame:CreateTexture("LD_ATRFrameBackground", "BACKGROUND")
LD_ATRFrameBackground:SetTexture(0, 0, 1, 0.1)
LD_ATRFrameBackground:SetAllPoints()
LD_ATRFrame:SetSize(400, 300)
LD_ATRFrame:SetPoint("BOTTOMRIGHT", 0, 170)
LD_ATRFrame:SetMovable(true)
LD_ATRFrame:EnableMouse(true)
LD_ATRFrame.MyTitle = LD_ATRFrame:CreateTitleRegion()
LD_ATRFrame.MyTitle:SetSize(400, 200) 
LD_ATRFrame.MyTitle:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, 0)   
LD_ATRFrame.MyHead = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyHead:SetTextColor(1, 1, 1, 1)
LD_ATRFrame.MyHead:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, 0)
LD_ATRFrame.MyHead:SetJustifyH("LEFT")
LD_ATRFrame.MyHead:SetText( UnitName("Player") .. ": Ficha de personaje")
LD_ATRFrame.MyDesc1 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyDesc1:SetTextColor(0, 1, 0, 1)
LD_ATRFrame.MyDesc1:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, -15)
LD_ATRFrame.MyDesc1:SetJustifyH("RIGHT")
LD_ATRFrame.MyDesc1:SetText("Nombre:\nApellidos:\nEdad:\n")
LD_ATRFrame.MyDesc2 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyDesc2:SetTextColor(1, 1, 0, 1)
LD_ATRFrame.MyDesc2:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, -55)
LD_ATRFrame.MyDesc2:SetJustifyH("RIGHT")
LD_ATRFrame.MyHist1 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyHist1:SetTextColor(1, 1, 0, 1)
LD_ATRFrame.MyHist1:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 140, -35)
LD_ATRFrame.MyHist1:SetJustifyH("LEFT")
LD_ATRFrame.MyHist1:SetText("Reseña histórica:\n")
LD_ATRFrame.MyHist1B = LD_LabelTopS ( 140, -55, LD_ATRFrame, "")
LD_ATRFrame.MyHist1B:SetSize ( 250, 100)
LD_ATRFrame.MyHist1B:SetJustifyH("LEFT")
LD_ATRFrame.MyHist1B:SetJustifyV("TOP")
LD_ATRFrame.MyHist1B:SetWordWrap(true)
LD_ATRFrame.MyHist2 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyHist2:SetTextColor(1, 1, 0, 1)
LD_ATRFrame.MyHist2:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 140, -150)
LD_ATRFrame.MyHist2:SetJustifyH("LEFT")
LD_ATRFrame.MyHist2:SetText("Aspecto físico:\n")
LD_ATRFrame.MyHist2B = LD_LabelTopS ( 140, -170, LD_ATRFrame, "")
LD_ATRFrame.MyHist2B:SetSize ( 250, 100)
LD_ATRFrame.MyHist2B:SetJustifyH("LEFT")
LD_ATRFrame.MyHist2B:SetJustifyV("TOP")
LD_ATRFrame.MyHist2B:SetWordWrap(true)

-- LD_ATRFrame.FUERZA = LD_EditFrame (LD_ATRFrame, 115,  -68, 20, 11, 1, 0, true)
-- LD_ATRFrame.CONSTI = LD_EditFrame (LD_ATRFrame, 115,  -80, 20, 11, 1, 0, true)
-- LD_ATRFrame.DESTRE = LD_EditFrame (LD_ATRFrame, 115,  -92, 20, 11, 1, 0, true)
-- LD_ATRFrame.AGILID = LD_EditFrame (LD_ATRFrame, 115, -104, 20, 11, 1, 0, true)
-- LD_ATRFrame.INTELE = LD_EditFrame (LD_ATRFrame, 115, -116, 20, 11, 1, 0, true)
-- LD_ATRFrame.SABIDU = LD_EditFrame (LD_ATRFrame, 115, -128, 20, 11, 1, 0, true)
-- LD_ATRFrame.PERCEP = LD_EditFrame (LD_ATRFrame, 115, -140, 20, 11, 1, 0, true)
LD_ATRFrame:Hide()
LD_ATRFrame:SetScript ("OnShow", function(self)
   local MyName = "Nombre: "
   local MySName = "Apellidos: "
   local MyAge = "Edad: "

   

   self.MyDesc2:SetText("- ATRIBUTOS - \nFuerza: " .. AIO_LD_CONFIG["ATRIBUTO"]["FUERZA"] ..
                            "\nConstitución: " .. AIO_LD_CONFIG["ATRIBUTO"]["CONSTI"] ..
							"\nDestreza: " .. AIO_LD_CONFIG["ATRIBUTO"]["DESTRE"] ..
							"\nAgilidad: " .. AIO_LD_CONFIG["ATRIBUTO"]["AGILID"] ..
							"\nIntelecto: " .. AIO_LD_CONFIG["ATRIBUTO"]["INTELE"] ..
							"\nSabiduría: " .. AIO_LD_CONFIG["ATRIBUTO"]["SABIDU"] ..
							"\nPercepción:" .. AIO_LD_CONFIG["ATRIBUTO"]["PERCEP"] ..
							"\n\n\nP. atributo: " .. tostring(AIO_LD_CONFIG["ROL"]["PATTR"])) 
							
   if AIO_LD_CONFIG["ROL"] ~= nil then
      if AIO_LD_CONFIG["ROL"]["NOMBRE"] ~= nil then
	     MyName = MyName .. AIO_LD_CONFIG["ROL"]["NOMBRE"]
	  end
      if AIO_LD_CONFIG["ROL"]["APELLIDO"] ~= nil then
	     MySName = MySName .. AIO_LD_CONFIG["ROL"]["APELLIDO"]
	  end
      if AIO_LD_CONFIG["ROL"]["EDAD"] ~= nil then
	     MyAge = MyAge .. AIO_LD_CONFIG["ROL"]["EDAD"]
	  end
      if AIO_LD_CONFIG["ROL"]["HIST1"] ~= nil then
	     LD_ATRFrame.MyHist1B:SetText(AIO_LD_CONFIG["ROL"]["HIST1"])
	  end
      if AIO_LD_CONFIG["ROL"]["HIST2"] ~= nil then
	     LD_ATRFrame.MyHist2B:SetText(AIO_LD_CONFIG["ROL"]["HIST2"])
	  end
	  LD_ATRFrame.MyDesc1:SetText( MyName .. "\n" .. MySName .. "\n" .. MyAge )
   end   
   end)	
--
-- FRAME DE VENDEDORES DE ATRIBUTO
--   


LD_ATRVendors = { 
    ["Zipeau Magicfingers"] = { "DESTRE", "Destreza", "Como mi nombre indica soy el rey de las carteras flojas, el maestro en construir con palillos, el fiera que deja tuerta a una mosca. Lo has adivinado, la Destreza es lo mio, y estoy dispuesto a enseñarte, por un módico precio, claro." },
   ["Oraculus Coscotodo"] = { "PERCEP", "Percepción", "No te equivoques y no me intentes timar. A mi no se me escapa nada. Por mucho que te quieras esconder, o me quieras colar gato por liebre, te voy a pillar. Si Percepcion es lo que quieres y tienes pasta, habla conmigo"},
   ["Muelleflojo Parcour"] = { "AGILID", "Agilidad", "¿Subir a un arbol con los brazos cruzados? ¿Saltar de la alcoba de una doncella a la calle?. No hay reto que se me resista. Agilidad es lo que me sobra y es tuya siempre que pagues"},
   ["Seneca Kerabiadas"] = { "SABIDU", "Voluntad/Espíritu", "Todo el mundo sabe que lo que importa es el espíritu y no la carne mortal. Aquellos que eligen sábiamente cultivarán el arte del espíritu y la sabiduria. Claro que no vivo del aire, asi que pagame y tendras mis lecciones"},
   ["Martinez Gordobiceps"] = { "FUERZA", "Fuerza", "¿Sabes que el animal mas fuerte en relacion a su tamaño es la hormiga? Asi que no te dejes engañar por mi tamaño, puedo arrancarte la cabeza con solo dos dedos. ¿Te gustaria ser tan fuerte? Mis clases valen lo que cuestan"},
   ["Poveda Cuatroojos"] = { "INTELE", "Entendimiento", "Los niños en el cole se burlaban de mi y me llamaban empollon. Pero mírame ahora, soy rico gracias a mis inventos. Hay que tener Intelecto en esta vida. Asi que si quieres triunfar muestrame el color de tu dinero"},
   ["Noremasti Todoinmune"] = { "CONSTI", "Constitucion", "Cada dia me entreno tirándome rocas a la cabeza. No, no estoy loco, sencillamente nada me afecta, resisto todo tipo de ataques. Si quieres tener buena Constitucion, pagame al contado y serás casi como yo" }
}

				
				
LD_AttrVendFrame = CreateFrame ( "Frame", "LD_AttrVendFrame", UIParent )
-- local LD_AttrVendFrameBackground = LD_AttrVendFrame:CreateTexture("LD_AttrVendFrameBackground", "BACKGROUND")
-- LD_AttrVendFrameBackground:SetTexture(1, 1, 0.5, 1)
-- LD_AttrVendFrameBackground:SetAllPoints()
LD_AttrVendFrame:SetSize(250, 200)
LD_AttrVendFrame:SetPoint("TOPLEFT", 10, -130)
LD_AttrVendFrame:SetBackdrop({
	-- bgFile = [[Interface\Buttons\WHITE8x8]],
	bgFile = [[Interface\PaperDollInfoFrame\UI-GearManager-Title-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_AttrVendFrame.AttrDesc = ""
LD_AttrVendFrame.AttrBBDD = ""

LD_AttrVendFrame.MyVend = LD_AttrVendFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrVendFrame.MyVend:SetFont("Fonts\\MORPHEUS.TTF", 15)
LD_AttrVendFrame.MyVend:SetTextColor(1, 1, 0, 1)
LD_AttrVendFrame.MyVend:SetPoint("TOP", LD_AttrVendFrame, "TOP", 0, -10)
LD_AttrVendFrame.MyVend:SetText("Goblin")

LD_AttrVendFrame.MyVendTx = LD_AttrVendFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrVendFrame.MyVendTx:SetTextColor(0, 1, 0, 1)
LD_AttrVendFrame.MyVendTx:SetPoint("TOP", LD_AttrVendFrame, "TOP", 0, -30)
LD_AttrVendFrame.MyVendTx:SetJustifyH("LEFT")	
LD_AttrVendFrame.MyVendTx:SetText("Maestro de atributo\n________________________")

LD_AttrVendFrame.MyVendTxl = LD_AttrVendFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrVendFrame.MyVendTxl:SetFont("Fonts\\ARIALN.TTF", 14)
LD_AttrVendFrame.MyVendTxl:SetTextColor(0.8, 0.8, 0, 1)
LD_AttrVendFrame.MyVendTxl:SetPoint("TOP", LD_AttrVendFrame, "TOP", 0, -50)
LD_AttrVendFrame.MyVendTxl:SetSize (230, 120)
LD_AttrVendFrame.MyVendTxl:SetWordWrap(true) 
LD_AttrVendFrame.MyVendTxl:SetJustifyH("LEFT")	
LD_AttrVendFrame.MyVendTxl:SetText("...")

LD_AttrVendFrame.Button = CreateFrame ( "Button","TIRAMILLAS",LD_AttrVendFrame,"UIPanelButtonTemplate") 
LD_AttrVendFrame.Button:SetSize(120,25)
LD_AttrVendFrame.Button:SetPoint("BOTTOMLEFT", LD_AttrVendFrame, "BOTTOMLEFT", 50, 10)
LD_AttrVendFrame.Button:SetText("Comprar")
LD_AttrVendFrame.Button:SetScript ("OnClick", function (self)
   StaticPopupDialogs["CONFIRM_ATTR"].text = "Aumentar 1 punto de " .. LD_AttrVendFrame.AttrDesc .. "\n¿Estas seguro?"
   StaticPopup_Show("CONFIRM_ATTR")
end)


LD_AttrVendFrame:Hide()	



else
   PrintInfo("SLD Frames Loaded ...")
end
