local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Frames = SLD_Frames or require("SLD_Frames")

assert(not SLD_Frames2, "SLD_Frames2 is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_Frames2 =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}



local SLD_Frames2 = SLD_Frames2
if not AIO.AddAddon() then
LD_HistFrame=CreateFrame ( "Frame", "LD_HistFrame", UIParent )
LD_HistFrame:SetSize(400, 500)
LD_HistFrame:SetPoint("CENTER", 0, 150)
LD_HistFrame:SetBackdrop({
	--bgFile = [[Interface\Buttons\WHITE8x8]],
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Gold-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_HistFrame:SetMovable(true)
LD_HistFrame:EnableMouse(true)
LD_HistFrame.MyTitle = LD_HistFrame:CreateTitleRegion()
LD_HistFrame.MyTitle:SetSize(400, 300) 
LD_HistFrame.MyTitle:SetPoint("TOPLEFT", LD_HistFrame, "TOPLEFT", 0, 0)

LD_HistFrame.MyTit = LD_HistFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_HistFrame.MyTit:SetFont("Fonts\\MORPHEUS.TTF", 15)
LD_HistFrame.MyTit:SetTextColor(0.3, 1, 0.3, 1)
LD_HistFrame.MyTit:SetPoint("TOP", LD_HistFrame, "TOP", 0, -10)
LD_HistFrame.MyTit:SetText("Tu ficha de rol")

LD_HistFrame.MyTxt = LD_HistFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_HistFrame.MyTxt:SetTextColor(0.3, 1, 0.3, 1)
LD_HistFrame.MyTxt:SetPoint("TOPLEFT", LD_HistFrame, "TOPLEFT", 10, -27)
LD_HistFrame.MyTxt:SetJustifyH("LEFT")	
LD_HistFrame.MyTxt:SetText("Nombre:\nApellidos:\nEdad:\n\nAntecedentes históricos:\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nDescripción fisica:")

LD_HistFrame.NOMBRE = LD_EditFrameTrans (LD_HistFrame,  75,  -30, 150,  11, 1, "", false, 0.3)
LD_HistFrame.APELLI = LD_EditFrameTrans (LD_HistFrame,  75,  -42, 150,  11, 2, "", false, 0.3)
LD_HistFrame.EDAD   = LD_EditFrameTrans (LD_HistFrame,  75,  -54,  40,  11, 3, "", false, 0.3)
LD_HistFrame.HIST1  = LD_EditFrameTrans (LD_HistFrame,  20,  -90, 250, 150, 4, "", false, 0.3)
LD_HistFrame.HIST1:SetMultiLine(true)
LD_HistFrame.HIST1:SetMaxLetters(255)
LD_HistFrame.HIST1:SetSize(370,50)

LD_HistFrame.HIST2  = LD_EditFrameTrans (LD_HistFrame,  20,  -300, 250, 50, 1, "", false, 0.3)
LD_HistFrame.HIST2:SetMultiLine(true)
LD_HistFrame.HIST2:SetSize(370,50)
LD_HistFrame.HIST2:SetMaxLetters(255)

LD_HistFrame.TIRAMILLAS = CreateFrame ( "Button","TIRAMILLAS",LD_HistFrame,"UIPanelButtonTemplate") 
LD_HistFrame.TIRAMILLAS:SetSize(120,25)
LD_HistFrame.TIRAMILLAS:SetPoint("BOTTOMLEFT", LD_HistFrame, "BOTTOMLEFT", 50, 10)
LD_HistFrame.TIRAMILLAS:SetText("Enviar Historia")
LD_HistFrame.TIRAMILLAS:SetScript ("OnClick", function (self)
   StaticPopup_Show("CONFIRM_HISTORY")
end)
LD_HistFrame.CANCEL = CreateFrame ( "Button","HistCANCEL",LD_HistFrame,"UIPanelButtonTemplate") 
LD_HistFrame.CANCEL:SetSize(120,25)
LD_HistFrame.CANCEL:SetPoint("BOTTOMLEFT", LD_HistFrame, "BOTTOMLEFT", 200, 10)
LD_HistFrame.CANCEL:SetText("Cancelar")
LD_HistFrame.CANCEL:SetScript ("OnClick", function (self)
   LD_HistFrame:Hide()
end)
LD_HistFrame:Hide()
function LD_HistFrameLoad()
   if AIO_LD_CONFIG["ROL"] == nil then
      return
   end
   if AIO_LD_CONFIG["ROL"]["NOMBRE"] ~= nil then
      LD_HistFrame.NOMBRE:SetText(AIO_LD_CONFIG["ROL"]["NOMBRE"])
   end   
   if AIO_LD_CONFIG["ROL"]["APELLIDO"] ~= nil then
      LD_HistFrame.APELLI:SetText(AIO_LD_CONFIG["ROL"]["APELLIDO"])
   end   
   if AIO_LD_CONFIG["ROL"]["EDAD"] ~= nil then
      LD_HistFrame.EDAD:SetText(AIO_LD_CONFIG["ROL"]["EDAD"])
   end   
   if AIO_LD_CONFIG["ROL"]["HIST1"] ~= nil then
      LD_HistFrame.HIST1:SetText(AIO_LD_CONFIG["ROL"]["HIST1"])
   end   
   if AIO_LD_CONFIG["ROL"]["HIST2"] ~= nil then
      LD_HistFrame.HIST2:SetText(AIO_LD_CONFIG["ROL"]["HIST2"])
   end   
end


LD_ApproFrame=CreateFrame ( "Frame", "LD_ApproFrame", UIParent )
LD_ApproFrame:SetSize(400, 500)
LD_ApproFrame:SetPoint("CENTER", 0, 150)
LD_ApproFrame:SetBackdrop({
	--bgFile = [[Interface\Buttons\WHITE8x8]],
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Gold-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_ApproFrame:SetMovable(true)
LD_ApproFrame:EnableMouse(true)
LD_ApproFrame.MyTitle = LD_ApproFrame:CreateTitleRegion()
LD_ApproFrame.MyTitle:SetSize(400, 300) 
LD_ApproFrame.MyTitle:SetPoint("TOPLEFT", LD_ApproFrame, "TOPLEFT", 0, 0)
LD_ApproFrame.PjName = ""
LD_ApproFrame.Labels = LD_LabelTopColors ( 10, 
   -30, 
   LD_ApproFrame, 
   "  Nombre: \nApellidos: \nEdad: \n\n --- Reseña historica ---\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n --- Aspecto fisico ---", 
   0, 1, 0, 1 )
LD_ApproFrame.Cabecera  = LD_LabelTopColors ( 75,  -10, LD_ApproFrame, "-#-", 1, 1, 1, 1 )
LD_ApproFrame.Nombre    = LD_LabelTopColors ( 75,  -30, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Apellidos = LD_LabelTopColors ( 75,  -43, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Edad      = LD_LabelTopColors ( 50,  -55, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Hist1     = LD_LabelTopColors ( 10,  -95, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Hist1:SetSize ( 380, 100 )
LD_ApproFrame.Hist1:SetJustifyH("LEFT")
LD_ApproFrame.Hist1:SetJustifyV("TOP")
LD_ApproFrame.Hist1:SetWordWrap (true)
LD_ApproFrame.Hist2     = LD_LabelTopColors ( 10, -300, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Hist2:SetSize ( 380, 100 )
LD_ApproFrame.Hist2:SetJustifyH("LEFT")
LD_ApproFrame.Hist2:SetJustifyV("TOP")
LD_ApproFrame.Hist2:SetWordWrap (true)
   
LD_ApproFrame.Cabecera:SetJustifyH("LEFT")
LD_ApproFrame.Labels:SetJustifyH("LEFT")
LD_ApproFrame.Nombre:SetJustifyH("LEFT")
LD_ApproFrame.Apellidos:SetJustifyH("LEFT")
LD_ApproFrame.Edad:SetJustifyH("LEFT")

LD_ApproFrame.TIRAMILLAS = CreateFrame ( "Button","TIRAMILLAS",LD_ApproFrame,"UIPanelButtonTemplate") 
LD_ApproFrame.TIRAMILLAS:SetSize(120,25)
LD_ApproFrame.TIRAMILLAS:SetPoint("BOTTOMLEFT", LD_ApproFrame, "BOTTOMLEFT", 50, 10)
LD_ApproFrame.TIRAMILLAS:SetText("Aprobar")
LD_ApproFrame.TIRAMILLAS:SetScript ("OnClick", function (self)
   LDSendMsg("APPHI#" .. LD_ApproFrame.PjName )
end)
LD_ApproFrame.CANCEL = CreateFrame ( "Button","HistCANCEL",LD_ApproFrame,"UIPanelButtonTemplate") 
LD_ApproFrame.CANCEL:SetSize(120,25)
LD_ApproFrame.CANCEL:SetPoint("BOTTOMLEFT", LD_ApproFrame, "BOTTOMLEFT", 200, 10)
LD_ApproFrame.CANCEL:SetText("Cancelar")
LD_ApproFrame.CANCEL:SetScript ("OnClick", function (self)
   LD_ApproFrame:Hide()
end)


LD_ApproFrame:Hide()
--
-- BARRAS
--
LD_StatusBars=CreateFrame ( "Frame", "LD_StatusBars", UIParent )
LD_StatusBars:SetSize(850, 60)
LD_StatusBars:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
LD_StatusBars.MyTitle = LD_StatusBars:CreateTitleRegion()
LD_StatusBars.MyTitle:SetSize(850, 60) 
LD_StatusBars.MyTitle:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 0, 0)
LD_StatusBars:EnableMouse(true)
LD_StatusBars:SetMovable(false)

LD_StatusBars.HPBar = CreateFrame("StatusBar", nil, LD_StatusBars)
LD_StatusBars.HPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
LD_StatusBars.HPBar:GetStatusBarTexture():SetHorizTile(true)
LD_StatusBars.HPBar:SetWidth(800)
LD_StatusBars.HPBar:SetHeight(10)
LD_StatusBars.HPBar:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 10, -10)
LD_StatusBars.HPBar:SetStatusBarColor(0,1,0)
LD_StatusBars.HPBar:SetMinMaxValues(0, 800)
LD_StatusBars.HPBar:SetValue(300)
LD_StatusBars.HPBar:SetAlpha(0.6)
LD_StatusBars.HPBar:EnableMouse(true)

LD_StatusBars.EPBar = CreateFrame("StatusBar", nil, LD_StatusBars)
LD_StatusBars.EPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
LD_StatusBars.EPBar:GetStatusBarTexture():SetHorizTile(true)
LD_StatusBars.EPBar:SetWidth(800)
LD_StatusBars.EPBar:SetHeight(10)
LD_StatusBars.EPBar:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 10, -25)
LD_StatusBars.EPBar:SetStatusBarColor(1,1,0)
LD_StatusBars.EPBar:SetMinMaxValues(0, 800)
LD_StatusBars.EPBar:SetValue(300)
LD_StatusBars.EPBar:SetAlpha(0.6)
LD_StatusBars.EPBar:EnableMouse(true)

LD_StatusBars.MPBar = CreateFrame("StatusBar", nil, LD_StatusBars)
LD_StatusBars.MPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
LD_StatusBars.MPBar:GetStatusBarTexture():SetHorizTile(true)
LD_StatusBars.MPBar:SetWidth(800)
LD_StatusBars.MPBar:SetHeight(10)
LD_StatusBars.MPBar:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 10, -40)
LD_StatusBars.MPBar:SetStatusBarColor(0,0,1)
LD_StatusBars.MPBar:SetMinMaxValues(0, 800)
LD_StatusBars.MPBar:SetValue(300)
LD_StatusBars.MPBar:SetAlpha(0.6)
LD_StatusBars.MPBar:EnableMouse(true)

LD_StatusBars:Hide()
function LD_RefreshBars()
   AIO_LD_CONFIG["HP"] = (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["CONSTI"]) * 0.8 ) + 
                 (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["SABIDU"]) * 0.2 )
   AIO_LD_CONFIG["HP"] = AIO_LD_CONFIG["HP"] * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVHP"]
   LD_StatusBars.HPBar:SetValue(AIO_LD_CONFIG["HP"] * 5)   
   AIO_LD_CONFIG["EP"] = (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["CONSTI"]) * 0.4 ) + 
                 (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["AGILID"]) * 0.2 ) +
                 (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["SABIDU"]) * 0.2 ) +
                 (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["FUERZA"]) * 0.2 ) 
   AIO_LD_CONFIG["EP"] = AIO_LD_CONFIG["EP"] * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVEP"]
   LD_StatusBars.EPBar:SetValue(AIO_LD_CONFIG["EP"] * 5)   

   AIO_LD_CONFIG["MP"] = (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["SABIDU"]) * 0.7 ) + 
                 (tonumber(AIO_LD_CONFIG["ATRIBUTO"]["INTELE"]) * 0.3 ) 
   AIO_LD_CONFIG["MP"] = AIO_LD_CONFIG["MP"] * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVMP"]
   LD_StatusBars.MPBar:SetValue(AIO_LD_CONFIG["MP"] * 5)   
end

LD_StatusBars.HPBar:SetScript("OnEnter", 
function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
   GameTooltip:AddLine("Barra de puntos de Vida (HP = " .. tostring(AIO_LD_CONFIG["HP"]) ..")")
   GameTooltip:Show();		 
end)
LD_StatusBars.HPBar:SetScript("OnLeave", 
function(self) 
   self:SetAlpha(0.6) 
   GameTooltip:Hide();
end)
LD_StatusBars.EPBar:SetScript("OnEnter", 
function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
   GameTooltip:AddLine("Barra de puntos de Energía (EP = " .. tostring(AIO_LD_CONFIG["EP"]) ..")")
   GameTooltip:Show();		 
end)
LD_StatusBars.EPBar:SetScript("OnLeave", 
function(self) 
   self:SetAlpha(0.6) 
   GameTooltip:Hide();
end)
LD_StatusBars.MPBar:SetScript("OnEnter", 
function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
   GameTooltip:AddLine("Barra de puntos de Maná (MP = " .. tostring(AIO_LD_CONFIG["MP"]) ..")")
   GameTooltip:Show();		 
end)
LD_StatusBars.MPBar:SetScript("OnLeave", 
function(self) 
   self:SetAlpha(0.6) 
   GameTooltip:Hide();
end)
LD_StatusBars:SetScript("OnShow",
function (self)
   if AIO_LD_CONFIG["ROL"]["APP"] == nil then
      self:Hide()
	  return
   end
   if AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
      self:Hide()
	  return
   end
   LD_RefreshBars()
end)

StaticPopupDialogs["CONFIRM_HISTORY"] = {
  text = "Enviando esta peticion, el estado del personaje volverá a 'datos de rol pendientes'. ¿Estas seguro?",
  button1 = "Si",
  button2 = "No",
  OnAccept = function()
      LD_SetPjVar ( "APP", "ROL", "P" )
      LD_SetPjVar ( "NOMBRE"  , "ROL", LD_HistFrame.NOMBRE:GetText() )
      LD_SetPjVar ( "APELLIDO", "ROL", LD_HistFrame.APELLI:GetText() )
      LD_SetPjVar ( "EDAD"    , "ROL", LD_HistFrame.EDAD:GetText() )
      LD_SetPjVar ( "HIST1"   , "ROL", LD_HistFrame.HIST1:GetText() )
      LD_SetPjVar ( "HIST2"   , "ROL", LD_HistFrame.HIST2:GetText() )
      LD_HistFrame:Hide()
	  SysPrint ( "Tu historia ha sido enviada.")
	  SysPrint ( "En breve se analizará por el consejo y serás informad@ del resultado.")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3 }  
  
StaticPopupDialogs["CONFIRM_ATTR"] = {
  text = "Aumentar 1 punto de " .. LD_AttrVendFrame.AttrDesc .. "\n¿Estas seguro?",
  button1 = "Si",
  button2 = "No",
  OnAccept = function()
     local MyRaceLoc, MyRace = UnitRace("player")
	  if tonumber(AIO_LD_CONFIG["ROL"]["PATTR"]) <= 0 then
	     ErrPrint("No tienes suficientes puntos de atributo")
	     return
	  end
	  if tonumber(AIO_LD_CONFIG["ATRIBUTO"][LD_AttrVendFrame.AttrBBDD]) >= 
	     tonumber(AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace][LD_AttrVendFrame.AttrBBDD .. "_MAX"]) then
	     ErrPrint("Has llegado al máximo permitido para tu raza de este atributo")
	     return
	  end
	  LD_ATRFrame:Hide()
      LD_SetPjVar ( LD_AttrVendFrame.AttrBBDD, 
	                "ATRIBUTO", 
					AIO_LD_CONFIG["ATRIBUTO"][LD_AttrVendFrame.AttrBBDD] + 1 )
      LD_SetPjVar ( "PATTR", 
	                "ROL", 
					AIO_LD_CONFIG["ROL"]["PATTR"] - 1 )
	  SysPrint ( "Has ganado 1 punto de " .. LD_AttrVendFrame.AttrDesc)
	  LD_ATRFrame:Show()
	  LD_RefreshBars()
	  -- print ( "¡¡MENTIRA!! todavia no está terminado lo de la compra de atributos")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3 }  
  
  

else
   PrintInfo("SLD Frames2 Loaded ...")
end