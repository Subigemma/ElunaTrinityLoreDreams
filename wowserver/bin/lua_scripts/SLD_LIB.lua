local AIO = AIO or require("AIO")
assert(not SLD_LIB, "SLD_LIB is already loaded. Possibly different versions!")
-- SLD_LIB main table
SLD_LIB =
{
    -- SLD_LIB flavour functions
    unpack = unpack,
}

local SLD_LIB = SLD_LIB
if not AIO.AddAddon() then
   function LDSendMsg( Msg )
       senttime = time()
       AIO.Msg():Add("LDMsg", Msg):Send()
   end
   --
   -- VARIABLES GLOBALES
   --
   LD_Saved_ChatFrameEvent = nil
   AIO_LD_CONFIG = {}
   --
   -- Funciones varias de utilidad
   --
   function LD_deciToHexa(number)
	number = math.floor(number*255);
	local num1 = math.fmod(number, 16);
	local num2 = math.floor(number/16);
	if num2 == 10 then
		num2 = "A";
	elseif num2 == 11 then
		num2 = "B";
	elseif num2 == 12 then
		num2 = "C";
	elseif num2 == 13 then
		num2 = "D";
	elseif num2 == 14 then
		num2 = "E";
	elseif num2 == 15 then
		num2 = "F";
	end
	if num1 == 10 then
		num1 = "A";
	elseif num1 == 11 then
		num1 = "B";
	elseif num1 == 12 then
		num1 = "C";
	elseif num1 == 13 then
		num1 = "D";
	elseif num1 == 14 then
		num1 = "E";
	elseif num1 == 15 then
		num1 = "F";
	end
	return ""..num2..num1;
   end
   
   function LD_ColorToHexa(r,g,b)
      return "|cff"..LD_deciToHexa(r)..LD_deciToHexa(g)..LD_deciToHexa(b);
   end
   
   function LD_Today()
      local ThisDate = date("%Y%m%d%H%M%S")
	  return ThisDate
   end
   
   function PG (text)
      LDSendMsg ( "PRTXT"  .. "#" .. UnitName("player") .. "#" .. text )
   end
   
   function LT ( Player, Attr, Value)
      LDSendMsg ( "CATTR" .. "#" .. tostring(Player) .. "." .. tostring(Attr) .. "." .. tostring(Value))
   end
   
   function RD (MyMin, MyMax)
      MyRnd = random (MyMin, MyMax)
      PG ( "|cff00ffff[" .. UnitName("Player") .. "]|cffffff00 tira los dados y obtiene " .. MyRnd .. " (" ..MyMin .. "-" .. MyMax .. ")")
      return MyRnd
   end
   
   function SysPrint(msg)
      print("|cffaaaaff[LD]: " .. msg )
   end

   function ErrPrint(msg)
      print("|cffff0000[LD]: " .. msg )
   end
   
   -- VARIABLES GUARDADAS
   function LD_SetPjVar ( MyName, MyType, MyValue )
      local ThisDate = date("%Y%m%d%H%M%S")
      LDSendMsg("LDSET#" .. UnitName("player") .. "#" .. MyName .. "#" .. 
	            MyType  .. "#" .. MyValue  .. "#" .. ThisDate)
      AIO_LD_CONFIG[MyType][MyName]	= MyValue
      -- print("DEBUG:AIO_LD_CONFIG[" .. MyType .. "][" .. MyName .. "]=" .. MyValue)
   end
   function LD_GetPjVar ( MyName, MyType, MyValue )
      LDSendMsg("LDGET#" .. UnitName("player") .. "#" .. MyName  .. "#" .. MyType .. "#" .. MyValue )
   end
   function LD_GetPjVarDef ( MyName, MyType, MyValue, MyDefault )
      LDSendMsg("LDGDF#" .. UnitName("player") .. "#" .. MyName  .. "#" .. MyType .. "#" .. MyValue .. "#" .. MyDefault)
   end
   function LD_GetAllPjVar ( MyType )
      LDSendMsg("GTALL#" .. UnitName("player") .. "#" .. MyType )
   end
   function LD_LoadPjData ()
      LDSendMsg("GTAPJ#" .. UnitName("player") )
      LDSendMsg("LDSYS#" .. UnitName("player") )
   end
   
   function LD_EditFrame ( MyParentFrame, LeftOff, TopOff, Xsize, Ysize, MyIndex, MyDefault, IsNumeric)
      local MyEditFrame=CreateFrame("EditBox", "MyEditFrame" .. tostring(MyIndex), MyParentFrame, "UIPanelButtonTemplate" )
      MyEditFrame:SetPoint("TOPLEFT",LeftOff,TopOff)
      MyEditFrame:SetWidth(Xsize)
      MyEditFrame:SetHeight(Ysize)
      local MyEditFrameTex = MyEditFrame:CreateTexture("MyEditFrameTex")
      MyEditFrameTex:SetAllPoints(MyEditFrame)
      MyEditFrameTex:SetTexture(0, 0, 0.6, 0.6)
      MyEditFrame.Texture = MyEditFrameTex
      MyEditFrame:SetBackdrop(nil)
      MyEditFrame:SetAutoFocus(false)
      MyEditFrame:SetFontObject(GameFontNormalSmall)   
      MyEditFrame:SetTextInsets(0, 0, 3, 3)
      if IsNumeric == true then
         MyEditFrame:SetText (tostring(MyDefault))
	     -- print ("Number: " .. tostring(MyDefault) .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      else										  
         MyEditFrame:SetText (MyDefault)
	     -- print ("String: " .. MyDefault .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      end
      return MyEditFrame
   end
   function LD_EditFrameTrans ( MyParentFrame, LeftOff, TopOff, Xsize, Ysize, MyIndex, MyDefault, IsNumeric, Transp)
      local MyEditFrame=CreateFrame("EditBox", "MyEditFrame" .. tostring(MyIndex), MyParentFrame, "UIPanelButtonTemplate" )
      MyEditFrame:SetPoint("TOPLEFT",LeftOff,TopOff)
      MyEditFrame:SetWidth(Xsize)
      MyEditFrame:SetHeight(Ysize)
      local MyEditFrameTex = MyEditFrame:CreateTexture("MyEditFrameTex")
      MyEditFrameTex:SetAllPoints(MyEditFrame)
      MyEditFrameTex:SetTexture(0, 0, 0.6, Transp)
      MyEditFrame.Texture = MyEditFrameTex
      MyEditFrame:SetBackdrop(nil)
      MyEditFrame:SetAutoFocus(false)
      MyEditFrame:SetFontObject(GameFontNormalSmall)   
      MyEditFrame:SetTextInsets(0, 0, 3, 3)
      if IsNumeric == true then
         MyEditFrame:SetText (tostring(MyDefault))
	     -- print ("Number: " .. tostring(MyDefault) .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      else										  
         MyEditFrame:SetText (MyDefault)
	     -- print ("String: " .. MyDefault .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      end
      return MyEditFrame
   end
   function LD_ButtonFrame (Xoff, Yoff, PFrame, Icon)
      local MyFrame = CreateFrame ( "Button", "LD_F" .. tostring(Xoff) .. tostring(Yoff), PFrame )
	  MyFrame:SetSize(20,20)
	  MyFrame:SetAlpha(0.5)
	  local MyT = MyFrame:CreateTexture(nil,"BACKGROUND",nil,-6)
      MyT:SetTexture(Icon)
      MyT:SetTexCoord(0.1,0.9,0.1,0.9) --cut out crappy icon border
      MyT:SetAllPoints(MyFrame) --make texture sa
	  MyFrame:SetPoint ( "BOTTOMLEFT", Xoff, Yoff )
	  return MyFrame
   end
   
   function LD_ButtonFrameTop (Xoff, Yoff, PFrame, Icon)
      local MyFrame = CreateFrame ( "Button", "LD_BF" .. tostring(Xoff) .. tostring(Yoff), PFrame )
	  MyFrame:SetSize(20,20)
	  MyFrame:SetAlpha(1)
	  MyFrame.MyT = MyFrame:CreateTexture(nil,"BACKGROUND",nil,-6)
      MyFrame.MyT:SetTexture(Icon)
      MyFrame.MyT:SetTexCoord(0.1,0.9,0.1,0.9) --cut out crappy icon border
      MyFrame.MyT:SetAllPoints(MyFrame) --make texture sa
	  MyFrame:SetPoint ( "TOPLEFT", Xoff, Yoff )
	  return MyFrame
   end
   
   function LD_LabelTop (Xoff, Yoff, PFrame, Text)
      local MyFont = PFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
      MyFont:SetFontObject(GameFontNormal)   
      MyFont:SetTextColor(1, 1, 1, 1)
      MyFont:SetPoint("TOPLEFT", PFrame, "TOPLEFT", Xoff, Yoff)
	  MyFont:SetText ( Text )
	  return MyFont
   end
   
   function LD_LabelTopColors (Xoff, Yoff, PFrame, Text, MyR, MyG, MyB, MyT)
      local MyFont = PFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
      MyFont:SetFontObject(GameFontNormal)   
      MyFont:SetTextColor(MyR, MyG, MyB, MyT)
      MyFont:SetPoint("TOPLEFT", PFrame, "TOPLEFT", Xoff, Yoff)
	  MyFont:SetText ( Text )
	  return MyFont
   end
   function LD_LabelTopS (Xoff, Yoff, PFrame, Text)
      local MyFont = PFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
      MyFont:SetFontObject(GameFontNormalSmall)   
      MyFont:SetTextColor(1, 1, 1, 1)
      MyFont:SetPoint("TOPLEFT", PFrame, "TOPLEFT", Xoff, Yoff)
	  MyFont:SetText ( Text )
	  return MyFont
   end
else
   PrintInfo("LD Libraries loaded") 
end
   