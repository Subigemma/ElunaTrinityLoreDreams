local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
assert(not SLD_Frames, "SLD_Frames is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_Frames =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}

local SLD_Frames = SLD_Frames
if not AIO.AddAddon() then
   function LD_ButtonFrame (Xoff, Yoff, PFrame, Icon)
      local MyFrame = CreateFrame ( "Button", "LD_F" .. tostring(Xoff) .. tostring(Yoff), PFrame )
	  MyFrame:SetSize(20,20)
	  MyFrame:SetAlpha(0.5)
	  local MyT = MyFrame:CreateTexture(nil,"BACKGROUND",nil,-6)
      MyT:SetTexture(Icon)
      MyT:SetTexCoord(0.1,0.9,0.1,0.9) --cut out crappy icon border
      MyT:SetAllPoints(MyFrame) --make texture sa
	  MyFrame:SetPoint ( "TOPLEFT", Xoff, Yoff )
	  return MyFrame
   end
   function LD_SetMainFrame()
      LD_MainFrame = CreateFrame ( "Frame", "LD_MainFrame", UIParent )
	  local LD_MainFrameBackground = LD_MainFrame:CreateTexture("LD_MainFrameBackground", "BACKGROUND")
      LD_MainFrameBackground:SetTexture(1, 1, 1, 0.1)
      LD_MainFrameBackground:SetAllPoints()
	  LD_MainFrame:SetSize(400, 40)
	  LD_MainFrame:SetPoint("BOTTOMRIGHT")
	  
	  -- ATRIBUTOS
	  LD_MainFrame.Button1 = LD_ButtonFrame ( 10, -10, LD_MainFrame, "Interface\\ICONS\\INV_Inscription_ArmorScroll01" )
      LD_MainFrame.Button1:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff ATRIBUTOS / DESCRIPCION");
            GameTooltip:AddLine("|cffffffff Características innatas");
            GameTooltip:AddLine("|cffffffff Tambien puedes poner el aspecto físico");
            GameTooltip:AddLine("|cffffffff del personaje.");
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button1:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)

	  -- HABILIDADES
	  LD_MainFrame.Button2 = LD_ButtonFrame ( 40, -10, LD_MainFrame, "Interface\\ICONS\\INV_Inscription_ArmorScroll03" )
      LD_MainFrame.Button2:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff HABILIDADES / HECHIZOS");
            GameTooltip:AddLine("|cffffffff Características que el personaje aprende con el tiempo");
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button2:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)

	  -- EQUIPO
	  LD_MainFrame.Button3 = LD_ButtonFrame ( 70, -10, LD_MainFrame, "Interface\\ICONS\\Ability_Warrior_SwordandBoard" )
      LD_MainFrame.Button3:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff EQUIPO");
            GameTooltip:AddLine("|cffffffff No vas a ir en pelotas ¿verdad?");
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button3:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)

	  -- MONTURAS
	  LD_MainFrame.Button4 = LD_ButtonFrame ( 100, -10, LD_MainFrame, "Interface\\ICONS\\Ability_Mount_RidingHorse" )
      LD_MainFrame.Button4:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff MONTURAS");
            GameTooltip:AddLine("|cffffffff ¿Crees que vas a ir a pie siempre?");
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button4:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)

	  -- MACROS
	  LD_MainFrame.Button5 = LD_ButtonFrame ( 130, -10, LD_MainFrame, "Interface\\ICONS\\Trade_Engineering" )
      LD_MainFrame.Button5:SetScript("OnEnter", 
	     function(self) 
		    self:SetAlpha(1) 
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            GameTooltip:AddLine("|cff00ffff MACROS");
            GameTooltip:AddLine("|cffffffff Sabemos que eres un artista,")
			GameTooltip:AddLine("|cffffffff no te vamos a cortar el rollo con eso");
            GameTooltip:Show();		 
		 end)
      LD_MainFrame.Button5:SetScript("OnLeave", 
	     function(self) 
		    self:SetAlpha(0.5) 
            GameTooltip:Hide();
         end)

	  -- DIALOGOS / EMOTES
	  LD_MainFrame.Button5 = LD_ButtonFrame ( 160, -10, LD_MainFrame, "Interface\\ICONS\\spell_holy_silence" )
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

	  return LD_MainFrame
   end
else
   PrintInfo("SLD Frames Loaded ...")
end
